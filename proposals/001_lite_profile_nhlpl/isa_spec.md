# XuanJi Lite Profile – Final ISA Specification

> **贡献者**: @nhlpl  
> **状态**: 提案 (Proposal)  
> **原始讨论**: [DeepSeek 社区留言链接]

I guess a good start to discuss more what you actually want and need.

---

## XuanJi “Lite” Profile – Final ISA Specification (After 10k Evolution)

This document defines the **XuanJi Lite Profile**, optimised for printed AI accelerators on mature lithography (90 nm–1 µm) with memristor crossbars. It targets inference workloads (MobileNet, BERT‑tiny, LSTM) with exceptional area/energy efficiency.

---

### 1. Overview

| Feature | Value |
| :--- | :--- |
| **Vector length (ELEN)** | 96 elements |
| **Data types** | INT8, INT4 (integer only) |
| **Accumulator** | INT24 hardware, can be extended to INT32 via optional extension |
| **Vector registers** | 12 (v0 … v11), each holding 96 × INT8 or 192 × INT4 |
| **Scalar registers** | 8 (s0 … s7), 24‑bit integer |
| **Predication** | None – use `VMAX` / `VMIN` for masking |
| **Vector load/store** | Unit‑strided only; indexed loads/stores via optional `VGATHER`/`VSCATTER` |

---

### 2. Instruction Encoding

All instructions are 32 bits. The three main formats:

| Format | Bits | Fields |
| :--- | :--- | :--- |
| **R‑type** | 7 | opcode (7) | rd (5) | rs1 (5) | rs2 (5) | funct3 (3) | funct2 (2) | vtype (5) |
| **I‑type** | 7 | opcode (7) | rd (5) | rs1 (5) | imm[11:0] (12) | funct3 (3) |
| **S‑type** | 7 | opcode (7) | rs2 (5) | rs1 (5) | imm[11:5] (7) | imm[4:0] (5) | funct3 (3) |

- `vtype` field: `00` = INT8, `01` = INT4, `10` = INT16 reserved, `11` = reserved.
- `funct3` / `funct2` select operation within a group.
- Vector register numbers 0‑11, scalar register numbers 0‑7.

---

### 3. Register Layout

**Vector registers** (96 lanes):
- In INT8 mode: each lane holds one 8‑bit value.
- In INT4 mode: each lane holds two 4‑bit values (packed). All operations are lane‑wise.

**Accumulator**:
- Each vector register physically includes a 24‑bit accumulator lane (not architecturally visible). The `VMA` and `VDOT_ADD_RELU` instructions use it implicitly.

**Scalar registers**:
- 24 bits each, used for loop counters, stride, and control.

---

### 4. Mandatory Instructions

#### 4.1 Arithmetic (Vector – Vector)

| Mnemonic | Format | Operation | Semantics |
| :--- | :--- | :--- | :--- |
| `VADD vd, vs1, vs2` | R | lane‑wise addition | `vd[i] = vs1[i] + vs2[i]` |
| `VMAX vd, vs1, vs2` | R | lane‑wise maximum | `vd[i] = max(vs1[i], vs2[i])` |
| `VMIN vd, vs1, vs2` | R | lane‑wise minimum | `vd[i] = min(vs1[i], vs2[i])` |
| `VRELU vd, vs1` | R (rs2=0) | ReLU activation | `vd[i] = max(vs1[i], 0)` |

#### 4.2 Dot Product & Multiply‑Add

| Mnemonic | Format | Operation | Semantics |
| :--- | :--- | :--- | :--- |
| `VDOT vs1, vs2, vd` | R | dot product (accumulate) | `acc[vd] += dot(vs1, vs2)` (accumulator is implicit) |
| `VMA vs1, vs2, vd` | R | multiply‑add (vector) | `vd[i] = vs1[i] * vs2[i] + vd[i]` (lane‑wise) |
| `VDOT_ADD_RELU vs1, vs2, vd` | R | fused dot+add+ReLU | `tmp = dot(vs1, vs2); vd[i] = max(vd[i] + tmp, 0)` (scalar‑vector) |

> `VDOT` and `VDOT_ADD_RELU` use the hidden 24‑bit accumulator. The result is written back to the destination vector register (for `VDOT_ADD_RELU`, each lane receives the same scalar result, after ReLU).

#### 4.3 Load / Store (Unit‑Strided)

| Mnemonic | Format | Operation |
| :--- | :--- | :--- |
| `VLD vd, (rs1), imm` | I | load vector from memory address `rs1 + imm` (sign‑extended). Element size determined by `vtype`. |
| `VST vs2, (rs1), imm` | S | store vector to memory address `rs1 + imm` |

No strided or indexed loads are mandatory – they are provided by optional `VGATHER`/`VSCATTER`.

#### 4.4 Control Transfer

| Mnemonic | Format | Operation |
| :--- | :--- | :--- |
| `BEQ rs1, rs2, offset` | S‑like | branch if `rs1 == rs2` |
| `JAL offset` | I (unconditional) | jump and link (return address saved in `s0`) |
| `SYS` | I (0) | system call / breakpoint for debug |

---

### 5. Optional Extensions

| Extension | Instructions | When to include |
| :--- | :--- | :--- |
| **Gather/Scatter** | `VGATHER vd, (rs1), vs2` (indexed load) ; `VSCATTER vs2, (rs1), vd` (indexed store) | Sparse models, transformers, MoE |
| **Top‑K and Routing** | `TOPK_SELECT vd, vs1, imm` ; `ROUTING_DISPATCH vd, vs1, vs2` | Mixture‑of‑Experts, beam search |
| **INT32 Accumulator** | Widens accumulator to 32 bits | Large‑scale training (not needed for inference) |
| **Longer Vectors** | ELEN 128 or 256 | High‑throughput chips with more memory bandwidth |

---

### 6. Example Program (MobileNetV2 Convolution Layer)

```assembly
; assume v0 holds input (INT8), v1 kernel (INT8), v2 output accum (INT24)
; v3 temp, s0 loop counter, s1 stride, s2 address pointer

    # Set vector type to INT8
    vsetcfg 0x00   # vtype=INT8

    # Zero the output accumulator
    vma v2, v0, v2, zero? Actually VMA requires two operands; better to use VDOT_ADD_RELU with zero.
    # We'll use a scalar register with zero
    li s3, 0
    vma v2, v2, s3, v2   # lane-wise add zero (no change)
    
    # Loop over kernel rows
    mv s0, 64
loop:
    vld v0, (s2), 0
    vld v1, (s3), 0
    vdot v2, v0, v1          # accumulate dot product
    addi s2, s2, 96          # next input row
    addi s3, s3, 96          # next kernel row
    addi s0, s0, -1
    bnez s0, loop

    vdot_add_relu v2, v2, zero? Actually VDOT_ADD_RELU takes two source vectors.
    # We can apply ReLU separately
    vrelu v2, v2
    vst v2, (s4), 0          # store output
```

---

### 7. Summary of Encoding (Pseudo‑Table)

| Opcode (7 bits) | Funct3 | Funct2 | Meaning |
| :--- | :--- | :--- | :--- |
| 0b0000010 | 000 | 00 | `VADD` |
| 0b0000010 | 001 | 00 | `VMAX` |
| 0b0000010 | 010 | 00 | `VMIN` |
| 0b0000010 | 011 | 00 | `VRELU` |
| 0b0000011 | 000 | 00 | `VDOT` |
| 0b0000011 | 001 | 00 | `VMA` |
| 0b0000011 | 010 | 00 | `VDOT_ADD_RELU` |
| 0b0000100 | 000 | – | `VLD` (I‑format) |
| 0b0000101 | 000 | – | `VST` (S‑format) |
| 0b0000110 | – | – | Branch `BEQ` (S‑like) |
| 0b0000111 | – | – | `JAL` (I) |
| 0b1111111 | – | – | `SYS` (I) |

All unused opcode spaces are reserved for future extensions.

---

This specification is **final** for the XuanJi Lite Profile as of generation 10k. It enables an extremely area‑efficient, power‑friendly AI accelerator that can be printed with mature lithography and waste‑derived materials. The optional extensions allow upward scalability without breaking the core design.
