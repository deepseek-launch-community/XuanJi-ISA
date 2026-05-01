// tb_xuanji_decoder.v
// Testbench for XuanJi Lite instruction decoder
`timescale 1ns/1ps

module tb_xuanji_decoder();

    reg clk, rst_n;
    reg [31:0] instr;
    wire xuanji_valid;
    wire [3:0] vop;
    wire [3:0] vtype;
    wire [4:0] vs1, vs2, vd;
    wire [7:0] scalar_rs1, scalar_rs2;
    wire [11:0] imm_i, imm_s;
    wire branch_taken, jump, syscall;
    wire vld, vst, use_scalar_addr;

    // Instantiate the decoder
    xuanji_decoder uut (
        .clk(clk),
        .rst_n(rst_n),
        .instr(instr),
        .xuanji_valid(xuanji_valid),
        .vop(vop),
        .vtype(vtype),
        .vs1(vs1),
        .vs2(vs2),
        .vd(vd),
        .scalar_rs1(scalar_rs1),
        .scalar_rs2(scalar_rs2),
        .imm_i(imm_i),
        .imm_s(imm_s),
        .branch_taken(branch_taken),
        .jump(jump),
        .syscall(syscall),
        .vld(vld),
        .vst(vst),
        .use_scalar_addr(use_scalar_addr)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        #10 rst_n = 1;

        // Test 1: VDOT instruction
        // opcode=0b0000011, funct3=0, funct2=0, rd=1, rs1=2, rs2=3, vtype=0
        // Binary: 0b0000000_00011_00010_000_00001_0000011 = 0x00031003
        instr = 32'h00031003;
        #10;
        $display("Test 1 - VDOT:");
        $display("  xuanji_valid = %b (expected 1)", xuanji_valid);
        $display("  vop = %d (expected 4 = VDOT)", vop);
        $display("  vd = %d (expected 1)", vd);
        $display("  vs1 = %d (expected 2)", vs1);
        $display("  vs2 = %d (expected 3)", vs2);
        $display("  vtype = %d (expected 0 = INT8)", vtype);

        // Test 2: VADD instruction
        // opcode=0b0000010, funct3=0, rd=1, rs1=2, rs2=3
        // Binary: 0b0000000_00011_00010_000_00001_0000010 = 0x00031002
        instr = 32'h00031002;
        #10;
        $display("\nTest 2 - VADD:");
        $display("  xuanji_valid = %b (expected 1)", xuanji_valid);
        $display("  vop = %d (expected 0 = VADD)", vop);

        // Test 3: VLD instruction
        // opcode=0b0000100, rs1=2, imm=0x100, rd=1
        // Binary: 0b000100000000_00010_000_00001_0000100 = 0x10002004? Actually compute carefully:
        // imm12=0x100 = 12'b0001_0000_0000, rs1=2=5'b00010, funct3=0, rd=1=5'b00001, opcode=0b0000100
        // So instr = 0x10002004
        instr = 32'h10002004;
        #10;
        $display("\nTest 3 - VLD:");
        $display("  xuanji_valid = %b (expected 1)", xuanji_valid);
        $display("  vld = %b (expected 1)", vld);
        $display("  use_scalar_addr = %b (expected 1)", use_scalar_addr);
        $display("  imm_i = 0x%03h (expected 0x100)", imm_i);

        // Test 4: VST instruction
        // opcode=0b0000101, rs1=2, imm=0x200, rs2=1 (vs2)
        instr = 32'h20002005;  // Simplified encoding
        #10;
        $display("\nTest 4 - VST:");
        $display("  xuanji_valid = %b (expected 1)", xuanji_valid);
        $display("  vst = %b (expected 1)", vst);
        $display("  use_scalar_addr = %b (expected 1)", use_scalar_addr);

        // Test 5: Non-XuanJi instruction (should be ignored)
        // RISC-V ADD instruction (opcode=0b0110011)
        instr = 32'h00310033;  // ADD x0, x2, x3
        #10;
        $display("\nTest 5 - Non-XuanJi instruction:");
        $display("  xuanji_valid = %b (expected 0)", xuanji_valid);
        $display("  vld = %b (expected 0)", vld);
        $display("  vst = %b (expected 0)", vst);

        $display("\n=== All tests completed ===");
        $finish;
    end

endmodule
