# XuanJi ISA

**XuanJi ISA** — An open instruction set architecture for AI accelerators.  
**璇玑指令集** — 为AI加速器而生的开放指令集架构。

---

## English

### 🎯 Core Philosophy

- **100% Community-Owned**: Free from corporate or capital control.
- **Pure Open-Source Existence**: From silicon to framework to models.
- **AI-Native**: RISC-V inspired, but optimized for AI primitives.

### 🏗️ Three-Layer Architecture

| Layer | Name | Core Content | Goal |
| :--- | :--- | :--- | :--- |
| **L1** | **Chip Layer** | RISC-V + Vector Extensions, XuanJi Compiler | Break CUDA / closed-source monopoly |
| **L2** | **Framework Layer** | A brand new ML framework (No PyTorch dependence) | Community governed, no corporate control |
| **L3** | **Model Layer** | Pure, free model architectures | Innovation without capital distortion |

### 📂 Repository Structure

    XuanJi-ISA/
    ├── proposals/                    # Community-contributed ISA proposals
    │   └── 001_lite_profile_nhlpl/   # Lite Profile by nhlpl
    │       ├── isa_spec.md           # ISA specification
    │       ├── hardware_adaptation.md # Oracle + ASI adaptation
    │       └── decoder/              # Verilog implementation
    ├── specs/                        # Official ISA specifications (WIP)
    ├── roadmap.md                    # Project roadmap
    ├── CONTRIBUTING.md               # Contribution guidelines
    └── README.md                     # This file


### 🚀 Current Status (Roadmap v0.1)

| Phase | Status |
| :--- | :--- |
| **Phase 1: Requirements & Feasibility** | ✅ In progress – Received Lite Profile proposal |
| **Phase 2: Chip Layer (ISA + Compiler)** | ⏳ Waiting |
| **Phase 3: Framework Layer** | 🔜 Future |
| **Phase 4: Model Architecture Layer** | 🔜 Future |
| **Phase 5: Ecosystem Building** | 🔜 Future |

### 👥 How to Contribute

We need help in:

- **Chip / Hardware Design**: RISC‑V, vector acceleration, pipeline design
- **Compiler Engineering**: LLVM, TVM, open‑source GPU compilers
- **Framework Development**: Tensor libraries, autodiff, operator kernels
- **Model Research**: Novel architecture design
- **Community Operations**: Docs, outreach, coordination

**Ways to participate:**

1.  Join the discussion on [GitHub Discussions](https://github.com/deepseek-launch-community/XuanJi-ISA/discussions) (to be enabled) or the [original DeepSeek thread]([请在此处粘贴原始DeepSeek讨论帖链接]).
2.  Clone the repo, create a branch, and submit a Pull Request.
3.  Spread the word and help us build a truly open AI ISA.

### 📜 License

**Apache License 2.0** – Hardware‑friendly, with explicit patent grant.

---

## 中文

### 🎯 核心理念

- **完全由社区共建**：不受任何私有资本或企业的单方面控制。
- **纯净的技术存在**：从芯片到框架到模型，坚持开源信仰。
- **为AI优化**：汲取 RISC‑V 的精简哲学，为张量、注意力、MoE 等 AI 原生计算设计原子操作。

### 🏗️ 三层技术体系

| 层级 | 名称 | 核心内容 | 目标 |
| :--- | :--- | :--- | :--- |
| **L1** | **芯片层** | RISC‑V + 向量扩展，璇玑编译器 | 替代 CUDA 等闭源生态 |
| **L2** | **框架层** | 全新机器学习框架（不依赖 PyTorch） | 社区治理，无企业主导 |
| **L3** | **模型架构层** | 纯净、自由的模型架构 | 探索不受资本扭曲的创新 |

### 📂 仓库结构

    XuanJi-ISA/
    ├── proposals/                    # 社区贡献的指令集提案
    │   └── 001_lite_profile_nhlpl/   # nhlpl 贡献的 Lite Profile
    │       ├── isa_spec.md           # 指令集规范
    │       ├── hardware_adaptation.md # Oracle + ASI 适配方案
    │       └── decoder/              # Verilog 实现
    ├── specs/                        # 官方指令集规范（开发中）
    ├── roadmap.md                    # 项目路线图
    ├── CONTRIBUTING.md               # 贡献指南
    └── README.md                     # 本文件

### 🚀 当前进展（Roadmap v0.1）

| 阶段 | 状态 |
| :--- | :--- |
| **阶段一：需求与可行性** | ✅ 进行中 – 已收到 Lite Profile 提案 |
| **阶段二：芯片层（指令集 + 编译器）** | ⏳ 待启动 |
| **阶段三：框架层** | 🔜 未来 |
| **阶段四：模型架构层** | 🔜 未来 |
| **阶段五：生态建设** | 🔜 未来 |

### 👥 如何参与

我们需要以下方向的力量：

- **芯片/硬件设计**：RISC‑V、向量加速、流水线设计
- **编译器工程**：LLVM、TVM、开源 GPU 编译器
- **框架开发**：张量库、自动微分、算子库
- **模型研究**：新型模型架构设计
- **社区运营**：文档、宣传、协调

**参与方式：**

1.  在 [GitHub Discussions](https://github.com/deepseek-launch-community/XuanJi-ISA/discussions)（待启用）或 [DeepSeek 社区原始讨论帖]([请在此处粘贴原始DeepSeek讨论帖链接]) 中留言。
2.  克隆仓库、创建分支、提交 Pull Request。
3.  帮助我们传播，共同构建真正开放的 AI 指令集。

### 📜 许可证

**Apache License 2.0** – 对硬件友好，明确授予专利授权。
