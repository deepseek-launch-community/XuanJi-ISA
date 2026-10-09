[中文](README.md) | [English](README-EN.md)

---

# 璇玑执行模型 (XuanJi Execution Model) —— 基于栈机的 AI 推理探索

璇玑是一个探索性项目，关注一个问题：如果不用现有的通用芯片架构（x86、ARM、GPU），能不能为AI推理设计一种更简单、更直接的硬件路径？

我们的方向是：用栈机作为执行模型，用ROM存储权重替代HBM读取，用树形多核替代总线结构。栈机的指令集不是预设固定的，而是在运行时由字典自举生长（Forth风格）。目标是减少指令解码的冗余、减少数据搬运的开销、减少对昂贵内存的依赖。


**一、来源说明：**

璇玑执行模型的核心理念（栈机、树形结构、感知-符号分离、指令集动态自举）来源于社区公开讨论，特别是以下贡献者的设计思路：
- **qwas982**：在DeepSeek-V3仓库的 #1174、#1188、#1243、#1254、#1289 等 Issue 中提出的栈机、树形结构和神经符号框架等核心理念。
- **nhlpl**：在璇玑仓库的 #37、#47 等 Issue 中提交的硬件架构设计，包括：
  - ACME‑NEURO‑90（#37）：256×256 忆阻器交叉阵列的声学神经形态加速芯片，90nm CMOS 工艺，能效 25 fJ/MAC。
  - AxiomLiquid ISA（#47）：16 位自适应指令集架构，计算精度可按 fp16/bf16/int8/int4 动态变形，支持运行时自重构。
  - Aether‑Rack（#40）：单机架量子声学计算机，基于 GKP 编码声子态，1024 逻辑量子比特。
  - Huygens‑Box（#41）：桌面级芯片制造系统。
本项目是对这些公开思想的工程化整理和验证，而非独立原创架构。

璇玑和DeepSeek正在推进的自研推理芯片关注同一个技术方向——用更少的指令、更少的数据搬运、更直接的执行方式来优化推理效率。璇玑不依附于DeepSeek的官方架构，也不代表官方立场，但两者的技术关切是重叠的。这意味着参与璇玑的工作，本身是在探索一个与工业界前沿方向对齐的问题空间。


**二、目前正在推进的具体事情：**
- **栈机模拟器**（#30）：基于Forth风格的可扩展指令字典，已在Python上完成原型验证，正在进行字典自举机制的扩展测试。指令集不是固定的9条，而是可从最小内核动态生长的。适合对仿真器或编译器有兴趣的人参与。
- **树形多核结构讨论**（#48）：正在探索多核之间的通信和控制流分布。适合对并行架构或片上网络有兴趣的人参与。
- **硬件设计参考**（#37、#40、#41、#47）：社区成员 nhlpl 已提交多个硬件架构设计，涵盖神经形态加速、自适应指令集、量子计算和桌面芯片制造等方向。适合对数字电路、FPGA 或新型计算范式有兴趣的人参与。
- **编译器集成讨论**（#1484）：讨论如何在现有架构上通过编译器优化推理延迟。适合对MLIR或编译优化有兴趣的人参与。


**三、参与璇玑的工作可能通向的方向：**
- 模拟器开发 → 编译器设计 / 硬件验证
- 架构讨论 → 技术报告 / 论文
- 硬件设计 → FPGA原型 / 芯片验证项目 

这些方向不一定都能走到终点，但每一个方向都有被外部看到和评估的可能。


**四、nhlpl 研究追踪：**

nhlpl 是本仓库的持续贡献者。据 DeepSeek Community 月度总结
（[#1687](https://github.com/deepseek-ai/DeepSeek-V3/issues/1687)），
他在 2026 年 9 月提交 143 条 Issue（#96–#239）。

为便于阅读者快速定位，这里给出入口：

- **璇玑侧追踪与提取入口**：
  [#360](https://github.com/deepseek-launch-community/XuanJi-ISA/issues/360)
- **对外曝光**：[#1659](https://github.com/deepseek-ai/DeepSeek-V3/issues/1659)
  Community Spotlight（DeepSeek-V3 仓库，璇玑项目发起，聚焦 #103 的 2000-GPU 部署相关性）
- **归类性质入口**：
  - [#104](https://github.com/deepseek-launch-community/XuanJi-ISA/issues/104) SKILLS — Handoff Document
  - [#175](https://github.com/deepseek-launch-community/XuanJi-ISA/issues/175) Six Drafts Filling Actual Gaps

**标签说明**

| 标签 | 含义 |
|---|---|
| `xuanji:usrable` | 可直接采纳为璇玑组件 |
| `xuanji:related` | 方向直接相关，但为规格/提案/约束/观察，待验证 |

**xuanji:usrable（可直接采纳，共 10 条）**

| Issue | 标题 |
|---|---|
| #30 | Chinese Stack Machine v0.1 |
| #57 | cf-hash-embedded |
| #87 | Self-Summarizing LLM "Zero-KV" Cache |
| #93 | "Drowning" Life Jacket Hydrostatic Triggers |
| #94 | Haptic Reality |
| #116 | Software-executable validation of blueprints |
| #118 | Self-Optimizing Runtime via Runtime ISA Growth |
| #172 | The Effective Rank of a Chemical Library Depends on the Fingerprint Encoding |
| #223 | Adversarial Robustness and Verification of ZAA |
| #227 | The Atom Classifier in ZAA |

**主题归类（#1–#267 全量）**

- v0.1 核心基线：#30
- 早期硬件架构：#37、#40、#41、#47
- 系统架构 / AI 加速器：#2、#3、#4、#5、#16、#17
- 自定义 ISA / 处理器设计：#23、#24、#28、#38
- 声学超表面系列：#29、#31–#35
- 90nm 半导体制造：#36、#37
- 家庭制造 / 量子硬件：#6–#15、#18、#19、#21、#22、#26
- 压缩与记忆：#95、#96、#97、#107
- 栈机与编译：#98、#101、#102、#116–#119
- 化学计算与方法论：#99、#104、#105、#133
- 延迟线 TCTN 系列：#106、#108–#112
- 密码学与安全：#113、#114、#115、#192、#193
- Physarum 系列：#126–#130、#141
- CA 规则空间与混沌：#123、#124、#139、#142、#144、#148、#153、#156、#159、#164、#165、#171
- 秩与特征分析：#125、#131、#132、#134–#136、#143、#145–#147、#150、#154、#155、#158、#161、#168–#170、#173、#174
- 优化与决策：#120、#121、#122、#137、#138、#140、#149、#151、#152
- 古代编码与认知吸引子：#176–#202
- ZAA 与组合架构：#203–#239
- 记忆基质（LTM / WM / VSA）：#240–#249
- 秩-4 原理 / 边缘计算：#250–#256
- 综合与部署：#257
- XuanJi ISA 直接测试床：#258
- 训练动力学与表示：#259–#261
- 组合与量化：#263–#264、#266–#267
- 波域原语：#265

nhlpl 持续在本仓库贡献研究 Issue。归类、提取与璇玑侧采纳判断由璇玑团队维护，
入口见上方追踪 Issue [#360](https://github.com/deepseek-launch-community/XuanJi-ISA/issues/360)。



**五、如何参与：**
可以在对应的Issue下留言（#30、#48、#37、#40、#41、#47、#1484），也可以新建Issue提出自己的方向。


**六、许可证：**
Apache License 2.0




