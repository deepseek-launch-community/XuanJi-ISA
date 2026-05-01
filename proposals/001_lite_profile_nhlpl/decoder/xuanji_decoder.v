// xuanji_decoder.v
// Decodes XuanJi Lite instructions for the oracle chip
// Assumes instruction is fetched and aligned.

module xuanji_decoder (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [31:0] instr,          // 32-bit instruction word
    output reg        xuanji_valid,    // high when instruction is XuanJi (not a standard RISC-V op)
    // Control signals for memristor crossbar / accumulator
    output reg  [3:0] vop,             // vector operation (see VOP_* defines)
    output reg  [3:0] vtype,           // 0: INT8, 1: INT4, others reserved
    output reg  [4:0] vs1, vs2, vd,    // vector register indices (0..11)
    output reg  [7:0] scalar_rs1, scalar_rs2, // scalar register indices (0..7)
    output reg  [11:0] imm_i, imm_s,   // I-type immediate (VLD), S-type immediate (VST)
    output reg        branch_taken,    // for BEQ; should be computed by CPU based on comparison
    output reg        jump,            // for JAL
    output reg        syscall,         // for SYS
    // Control for load/store
    output reg        vld, vst,        // load/store enable
    output reg        use_scalar_addr  // for VLD/VST: use (rs1 + imm) as base address
);

    // ----- Operation encoding -----
    localparam VOP_ADD        = 4'd0;
    localparam VOP_MAX        = 4'd1;
    localparam VOP_MIN        = 4'd2;
    localparam VOP_RELU       = 4'd3;
    localparam VOP_DOT        = 4'd4;
    localparam VOP_MA         = 4'd5;
    localparam VOP_DOT_ADD_RELU = 4'd6;
    localparam VOP_NOP        = 4'd15;

    // ----- Opcode fields (from spec) -----
    // Assuming:
    // 0b0000010 -> R-type vector arithmetic (ADD,MAX,MIN,RELU)
    // 0b0000011 -> R-type vector multiply/dot (DOT, MA, DOT_ADD_RELU)
    // 0b0000100 -> VLD (I-type)
    // 0b0000101 -> VST (S-type)
    // 0b0000110 -> BEQ (S-like)
    // 0b0000111 -> JAL (I)
    // 0b1111111 -> SYS (I)
    localparam OP_R_VEC_ARITH    = 7'b0000010;
    localparam OP_R_VEC_DOT      = 7'b0000011;
    localparam OP_VLD            = 7'b0000100;
    localparam OP_VST            = 7'b0000101;
    localparam OP_BEQ            = 7'b0000110;
    localparam OP_JAL            = 7'b0000111;
    localparam OP_SYS            = 7'b1111111;

    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];   // for R-type, also used for BEQ
    wire [1:0] funct2 = instr[25:24];   // for R-type
    wire [4:0] rd   = instr[11:7];
    wire [4:0] rs1  = instr[19:15];
    wire [4:0] rs2  = instr[24:20];
    wire [4:0] vtype_field = instr[29:25]; // assumed from spec (5 bits)
    // For I-type immediate (sign-extended)
    wire [11:0] imm12_i = instr[31:20];
    // For S-type immediate (split)
    wire [4:0] imm_low = instr[11:7];
    wire [6:0] imm_high = instr[31:25];
    wire [11:0] imm12_s = {imm_high, imm_low};

    reg is_xuanji;
    wire is_r_vec_arith, is_r_vec_dot, is_vld, is_vst, is_beq, is_jal, is_sys;
    wire is_valid = |{is_r_vec_arith, is_r_vec_dot, is_vld, is_vst, is_beq, is_jal, is_sys};

    assign is_r_vec_arith = (opcode == OP_R_VEC_ARITH);
    assign is_r_vec_dot   = (opcode == OP_R_VEC_DOT);
    assign is_vld         = (opcode == OP_VLD);
    assign is_vst         = (opcode == OP_VST);
    assign is_beq         = (opcode == OP_BEQ);
    assign is_jal         = (opcode == OP_JAL);
    assign is_sys         = (opcode == OP_SYS);

    always @* begin
        // default outputs
        xuanji_valid = is_valid;
        vop = VOP_NOP;
        vtype = vtype_field[1:0];      // lower 2 bits (00=INT8,01=INT4)
        vs1 = rs1;
        vs2 = rs2;
        vd  = rd;
        scalar_rs1 = rs1[2:0];  // only 3 LSBs needed for 8 scalar registers
        scalar_rs2 = rs2[2:0];
        imm_i = imm12_i;
        imm_s = imm12_s;
        branch_taken = 1'b0;
        jump = 1'b0;
        syscall = 1'b0;
        vld = 1'b0;
        vst = 1'b0;
        use_scalar_addr = 1'b0;

        if (is_r_vec_arith) begin
            case (funct3)
                3'b000: vop = VOP_ADD;
                3'b001: vop = VOP_MAX;
                3'b010: vop = VOP_MIN;
                3'b011: vop = VOP_RELU;
                default: vop = VOP_NOP;
            endcase
        end
        else if (is_r_vec_dot) begin
            case (funct3)
                3'b000: vop = VOP_DOT;
                3'b001: vop = VOP_MA;
                3'b010: vop = VOP_DOT_ADD_RELU;
                default: vop = VOP_NOP;
            endcase
        end
        else if (is_vld) begin
            vld = 1'b1;
            use_scalar_addr = 1'b1;
            vop = VOP_NOP;   // load/store handled by memory unit
        end
        else if (is_vst) begin
            vst = 1'b1;
            use_scalar_addr = 1'b1;
            vop = VOP_NOP;
        end
        else if (is_beq) begin
            // branch taken must be computed externally; we just pass condition
            // The CPU will evaluate (scalar_rs1 == scalar_rs2) and set branch_taken accordingly.
            // Here we set a flag that it's a branch.
            branch_taken = 1'b1; // placeholder; actual will be computed by CPU based on scalar regs
        end
        else if (is_jal) begin
            jump = 1'b1;
        end
        else if (is_sys) begin
            syscall = 1'b1;
        end
    end

endmodule
