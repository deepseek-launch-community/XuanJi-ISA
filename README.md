# 璇玑指令集 (XuanJi ISA)

[中文](#中文) | [English](#English)

---

## 中文

# 璇玑指令集 (XuanJi ISA)

璇玑是一个探索性项目，关注一个问题：如果不用现有的通用芯片架构（x86、ARM、GPU），能不能为AI推理设计一种更简单、更直接的硬件路径？

我们的方向是：用栈机替代寄存器机，用ROM存储权重替代HBM读取，用树形多核替代总线结构。目标是减少指令解码的冗余、减少数据搬运的开销、减少对昂贵内存的依赖。

璇玑和DeepSeek正在推进的自研推理芯片关注同一个技术方向——用更少的指令、更少的数据搬运、更直接的执行方式来优化推理效率。璇玑不依附于DeepSeek的官方架构，也不代表官方立场，但两者的技术关切是重叠的。这意味着参与璇玑的工作，本身是在探索一个与工业界前沿方向对齐的问题空间。


**目前正在推进的具体事情：**

- 9指令栈机模拟器（#30）：基本指令集已用Python验证，正在进行扩展测试。适合对仿真器或编译器有兴趣的人参与。
- 树形多核结构讨论（#48）：正在探索多核之间的通信和控制流分布。适合对并行架构或片上网络有兴趣的人参与。
- 硬件设计参考（#37、#40、#41、#47）：社区成员已提交多个硬件架构设计，包括类脑加速器、自适应ISA和量子计算原型。适合对数字电路或FPGA有兴趣的人参与。
- 编译器集成讨论（#1484）：讨论如何在现有架构上通过编译器优化推理延迟。适合对MLIR或编译优化有兴趣的人参与。


**参与璇玑的工作可能通向的方向：**

- 模拟器开发 → 编译器设计 / 硬件验证
- 架构讨论 → 技术报告 / 论文
- 硬件设计 → FPGA原型 / 芯片验证项目

这些方向不一定都能走到终点，但每一个方向都有被外部看到和评估的可能。


**如何参与：**

可以在对应的Issue下留言（#30、#48、#37、#40、#41、#47、#1484），也可以新建Issue提出自己的方向。


**许可证：**

Apache License 2.0

---

## English

# XuanJi ISA

XuanJi is an exploratory project that asks one question: without relying on existing general‑purpose chip architectures (x86, ARM, GPU), can we design a simpler and more direct hardware path for AI inference?

Our direction is: replace register machines with stack machines, replace HBM reads with ROM‑stored weights, and replace bus‑based structures with tree‑structured multi‑core layouts. The goal is to reduce instruction decoding overhead, minimize data movement, and lower dependency on expensive memory.

XuanJi and DeepSeek's ongoing in‑house inference chip efforts share the same technical concern — optimizing inference efficiency through fewer instructions, less data movement, and more direct execution. XuanJi is not affiliated with DeepSeek's official architecture and does not represent any official position, but the technical directions overlap. This means that contributing to XuanJi is, in itself, an exploration of a problem space aligned with a frontier industrial direction.


**What is currently being worked on:**

- 9‑instruction stack machine simulator (#30): the basic instruction set has been validated in Python, and extended testing is ongoing. Suitable for those interested in simulators or compilers.
- Tree‑structured multi‑core discussion (#48): exploring communication and control flow distribution between cores. Suitable for those interested in parallel architectures or network‑on‑chip.
- Hardware design references (#37, #40, #41, #47): community‑submitted hardware architecture designs, including neuromorphic accelerators, adaptive ISAs, and quantum computing prototypes. Suitable for those interested in digital circuits or FPGAs.
- Compiler integration discussion (#1484): discussing how to optimize inference latency through compilers on existing architectures. Suitable for those interested in MLIR or compilation optimization.


**Possible directions for contributors:**

- Simulator development → compiler design / hardware verification
- Architecture discussion → technical reports / papers
- Hardware design → FPGA prototypes / chip validation projects

Not all of these directions will necessarily reach completion, but each one has the potential to be seen and evaluated by the broader community.


**How to participate:**

Leave a comment in the corresponding Issue (#30, #48, #37, #40, #41, #47, #1484), or open a new Issue to propose your own direction.


**License:**

Apache License 2.0





