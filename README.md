# 璇玑指令集 (XuanJi ISA)

[中文](#中文) | [English](#English)

---

## 中文

**璇玑指令集** — 为AI加速器而生的开放指令集架构。

### 核心理念

- **完全由社区共建**：不受任何私有资本或企业的单方面控制
- **纯净的技术存在**：从芯片到框架到模型，坚持开源信仰
- **为AI优化**：为张量、注意力、MoE等AI原生计算设计原子操作

### 三层技术体系

| 层级 | 名称 | 内容 | 目标 |
|------|------|------|------|
| **L1** | 芯片层 | RISC-V + 向量扩展，璇玑编译器 | 替代CUDA闭源生态 |
| **L2** | 框架层 | 全新机器学习框架（不依赖PyTorch） | 社区治理，无企业主导 |
| **L3** | 模型架构层 | 纯净、自由的模型架构 | 探索不受资本扭曲的创新 |

### 当前状态 (2026-05-03)

| 类别 | 内容 | 位置 |
|------|------|------|
| **ISA规范** | XuanJi v1.0 最终版 | `specs/xuanji_isa_v1.0.md` |
| **Verilog核心** | 可综合RTL | `hw/rtl/xuanji_core.v` |
| **测试平台** | 自检式testbench | `hw/sim/tb_xuanji.v` |
| **Python模拟器** | 完整指令集模拟 | `sw/simulator/xuanji_sim.py` |
| **GDSII脚本** | 3mm×3mm版图生成 | `hw/gds/generate_xuanji_gds.py` |
| **LLVM后端** | 编译器骨架 | `compiler/llvm-xuanji/` |
| **模型库** | 5个基准网络 | `models/tianling_zoo/` |

### 里程碑

| 里程碑 | 截止日期 | 状态 |
|--------|----------|------|
| v0.1 - 核心ISA + 模拟器 | 2026-05-17 | 🔄 进行中 |
| v0.2 - 硬件验证 | 2026-06-07 | ⏳ 待启动 |
| v0.3 - 框架集成 | 2026-06-28 | ⏳ 待启动 |
| v1.0 - Alpha版 | 2026-08-02 | ⏳ 待启动 |
| 探索性方向 | 无 | 🔄 并行进行 |

### 如何参与

参见 [CONTRIBUTING.md](CONTRIBUTING.md)

### 许可证

**Apache License 2.0**

---

## English

**XuanJi ISA** — An open instruction set architecture for AI accelerators.

### Core Philosophy

- **100% Community-Owned**: Free from corporate or capital control.
- **Pure Open-Source Existence**: From silicon to framework to models.
- **AI-Native**: RISC-V inspired, optimized for AI primitives.

### Three-Layer Architecture

| Layer | Name | Content | Goal |
|-------|------|---------|------|
| **L1** | Chip Layer | RISC-V + Vector Extensions, XuanJi Compiler | Break CUDA monopoly |
| **L2** | Framework Layer | New ML framework (No PyTorch) | Community governed |
| **L3** | Model Layer | Pure, free model architectures | Innovation without boundaries |

### Current Status (2026-05-03)

| Category | Content | Location |
|----------|---------|----------|
| **ISA Spec** | XuanJi v1.0 Final | `specs/xuanji_isa_v1.0.md` |
| **Verilog Core** | Synthesizable RTL | `hw/rtl/xuanji_core.v` |
| **Testbench** | Self-checking | `hw/sim/tb_xuanji.v` |
| **Python Simulator** | Full ISA simulation | `sw/simulator/xuanji_sim.py` |
| **GDSII Script** | 3mm×3mm layout generator | `hw/gds/generate_xuanji_gds.py` |
| **LLVM Backend** | Compiler skeleton | `compiler/llvm-xuanji/` |
| **Model Zoo** | 5 benchmark networks | `models/tianling_zoo/` |

### Milestones

| Milestone | Due | Status |
|-----------|-----|--------|
| v0.1 - Core ISA & Simulator | 2026-05-17 | 🔄 In Progress |
| v0.2 - Hardware Verification | 2026-06-07 | ⏳ Pending |
| v0.3 - Framework Integration | 2026-06-28 | ⏳ Pending |
| v1.0 - Alpha Release | 2026-08-02 | ⏳ Pending |
| Exploratory | No due date | 🔄 Parallel |

### How to Contribute

See [CONTRIBUTING.md](CONTRIBUTING.md)

### License

**Apache License 2.0**






