# XuanJi Execution Model — Stack‑based AI Inference Exploration

XuanJi is an exploratory project that asks one question: without relying on existing general‑purpose chip architectures (x86, ARM, GPU), can we design a simpler and more direct hardware path for AI inference?

Our direction is: use a stack machine as the execution model, replace HBM reads with ROM‑stored weights, and replace bus‑based structures with tree‑structured multi‑core layouts. The stack machine's instruction set is not fixed in advance; it grows at runtime through dictionary self‑bootstrapping (Forth style). The goal is to reduce instruction decoding overhead, minimize data movement, and lower dependency on expensive memory.


**1. Attribution**

The core concepts of the XuanJi execution model — stack machine, tree‑structured multi‑core, perception‑symbol separation, dynamic self‑bootstrapping instruction set — are drawn from public community discussions, especially the design ideas proposed in the following contributions:

- **qwas982**: Stack machine, tree‑structured multi‑core, and neuro‑symbolic framework concepts from #1174, #1188, #1243, #1254, #1289 in the DeepSeek‑V3 repository.
- **nhlpl**: Hardware architecture designs from #37, #47, etc. in the XuanJi repository, including:
  - ACME‑NEURO‑90 (#37): 256×256 memristor crossbar acoustic neuromorphic accelerator, 90nm CMOS, 25 fJ/MAC efficiency.
  - AxiomLiquid ISA (#47): 16‑bit adaptive instruction set with runtime precision morphing (fp16/bf16/int8/int4), supporting self‑reconfiguration.
  - Aether‑Rack (#40): Rack‑mounted quantum acoustic computer with GKP‑encoded phononic qubits, 1024 logical qubits.
  - Huygens‑Box (#41): Desktop chip‑fabrication system.

This project is an engineering consolidation and validation of these public ideas, not an original standalone architecture.


XuanJi shares the same technical direction as DeepSeek's ongoing in‑house inference chip efforts — optimizing inference efficiency through fewer instructions, less data movement, and more direct execution. XuanJi is not affiliated with DeepSeek's official architecture and does not represent any official position, but the technical concerns overlap. Contributing to XuanJi means exploring a problem space aligned with a frontier industrial direction.


**2. What is currently being worked on:**

- **Stack machine simulator** (#30): Forth‑style extensible instruction dictionary, prototype validated in Python; currently extending dictionary self‑bootstrapping. The instruction set is not fixed to 9 instructions; it can grow from a minimal kernel. Suitable for those interested in simulators or compilers.
- **Tree‑structured multi‑core discussion** (#48): Exploring inter‑core communication and control flow distribution. Suitable for those interested in parallel architectures or network‑on‑chip.
- **Hardware design references** (#37, #40, #41, #47): Community member nhlpl has submitted multiple hardware architecture designs covering neuromorphic acceleration, adaptive ISAs, quantum computing, and desktop chip fabrication. Suitable for those interested in digital circuits, FPGAs, or novel computing paradigms.
- **Compiler integration discussion** (#1484): Discussing compiler‑based inference latency optimization on existing architectures. Suitable for those interested in MLIR or compilation optimization.


**3. Possible directions for contributors:**

- Simulator development → compiler design / hardware verification
- Architecture discussion → technical reports / papers
- Hardware design → FPGA prototypes / chip validation projects

Not all of these directions will necessarily reach completion, but each one has the potential to be seen and evaluated by the broader community.


**4. nhlpl Research Tracking:**

nhlpl is a continuing contributor to this repository. According to the
DeepSeek Community monthly summary
([#1687](https://github.com/deepseek-ai/DeepSeek-V3/issues/1687)),
he submitted 143 issues in September 2026 (#96–#239), of which 6 are
directly related to XuanJi and 2 are adoptable for the safety layer.

For readers who want to locate his work quickly, here are the entry points:

- **XuanJi-side tracking and extraction entry**: [#360](https://github.com/deepseek-launch-community/XuanJi-ISA/issues/360)
- **External spotlight**:
  [#1659](https://github.com/deepseek-ai/DeepSeek-V3/issues/1659)
  Community Spotlight (DeepSeek-V3 repo, initiated by the XuanJi project,
  focused on the 2,000-GPU deployment relevance of #103)
- **Index-like entries**:
  - #104 SKILLS — Handoff Document (handoff / overview)
  - #175 Six Drafts Filling Actual Gaps (65 rank drafts + 12 ZAA position
    papers, spread across 25+ disciplines)
- **Directly related to XuanJi** (priority tracking): #98, #104, #116,
  #117, #118, #119
- **Adoptable for the safety layer**: #223, #227
- **Thematic categorization** (see the tracking issue for details):
  - Early hardware architecture: #37, #40, #41, #47
  - Directly related to XuanJi: #98, #104, #116–#119
  - Rank and low-rank compression: #123–#174
  - Cellular automata / Rule 30: #124, #139, #142, #144, #148, #153,
    #156, #159, #164–#165, #171
  - Physical / chemical / biological reservoirs: #99, #101, #107–#112,
    #121, #126–#130, #157, #160, #163
  - Ancient encoding and cognitive attractors: #176–#202
  - ZAA and compositional architecture: #203–#239
  - Memory substrates (LTM / WM / VSA): #240–#249
  - Rank-4 principle / edge computing: #250–#256

nhlpl continues to contribute research issues to this repository.
Categorization, extraction, and XuanJi-side adoption decisions are
maintained by the XuanJi team. See the tracking issue above for the
entry point.



**5. How to participate:**

Leave a comment in the corresponding Issue (#30, #48, #37, #40, #41, #47, #1484), or open a new Issue to propose your own direction.


**6. License:**

Apache License 2.0
