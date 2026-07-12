# XuanJi Execution Model — Stack‑based AI Inference Exploration

XuanJi is an exploratory project that asks one question: without relying on existing general‑purpose chip architectures (x86, ARM, GPU), can we design a simpler and more direct hardware path for AI inference?

Our direction is: use a stack machine as the execution model, replace HBM reads with ROM‑stored weights, and replace bus‑based structures with tree‑structured multi‑core layouts. The stack machine's instruction set is not fixed in advance; it grows at runtime through dictionary self‑bootstrapping (Forth style). The goal is to reduce instruction decoding overhead, minimize data movement, and lower dependency on expensive memory.


**Attribution**

The core concepts of the XuanJi execution model — stack machine, tree‑structured multi‑core, perception‑symbol separation, dynamic self‑bootstrapping instruction set — are drawn from public community discussions, especially the design ideas proposed in the following contributions:

- **qwas982**: Stack machine, tree‑structured multi‑core, and neuro‑symbolic framework concepts from #1174, #1188, #1243, #1254, #1289.
- **nhlpl**: Hardware architecture designs from #37, #47, etc., including:
  - ACME‑NEURO‑90 (#37): 256×256 memristor crossbar acoustic neuromorphic accelerator, 90nm CMOS, 25 fJ/MAC efficiency.
  - AxiomLiquid ISA (#47): 16‑bit adaptive instruction set with runtime precision morphing (fp16/bf16/int8/int4), supporting self‑reconfiguration.
  - Aether‑Rack (#40): Rack‑mounted quantum acoustic computer with GKP‑encoded phononic qubits, 1024 logical qubits.
  - Huygens‑Box (#41): Desktop chip‑fabrication system.

This project is an engineering consolidation and validation of these public ideas, not an original standalone architecture.


XuanJi shares the same technical direction as DeepSeek's ongoing in‑house inference chip efforts — optimizing inference efficiency through fewer instructions, less data movement, and more direct execution. XuanJi is not affiliated with DeepSeek's official architecture and does not represent any official position, but the technical concerns overlap. Contributing to XuanJi means exploring a problem space aligned with a frontier industrial direction.


**What is currently being worked on:**

- **Stack machine simulator** (#30): Forth‑style extensible instruction dictionary, prototype validated in Python; currently extending dictionary self‑bootstrapping. The instruction set is not fixed to 9 instructions; it can grow from a minimal kernel. Suitable for those interested in simulators or compilers.
- **Tree‑structured multi‑core discussion** (#48): Exploring inter‑core communication and control flow distribution. Suitable for those interested in parallel architectures or network‑on‑chip.
- **Hardware design references** (#37, #40, #41, #47): Community member nhlpl has submitted multiple hardware architecture designs covering neuromorphic acceleration, adaptive ISAs, quantum computing, and desktop chip fabrication. Suitable for those interested in digital circuits, FPGAs, or novel computing paradigms.
- **Compiler integration discussion** (#1484): Discussing compiler‑based inference latency optimization on existing architectures. Suitable for those interested in MLIR or compilation optimization.


**Possible directions for contributors:**

- Simulator development → compiler design / hardware verification
- Architecture discussion → technical reports / papers
- Hardware design → FPGA prototypes / chip validation projects

Not all of these directions will necessarily reach completion, but each one has the potential to be seen and evaluated by the broader community.


**How to participate:**

Leave a comment in the corresponding Issue (#30, #48, #37, #40, #41, #47, #1484), or open a new Issue to propose your own direction.


**License:**

Apache License 2.0
