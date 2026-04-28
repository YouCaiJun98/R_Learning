# Proj 02 Timely and Effective Care by US States

2026/4/28  

写在前面：这节课是我们项目实战的第二节课，我们使用了`tidytuesday`这个[github项目](https://github.com/rfordatascience/tidytuesday)中的开源数据。这节课中，我们将对更复杂、更接近真实的数据进行分析，希望你可以学会一套标准的 EDA（探索性数据分析）流程。😎

---

## Step 0 TidyTuesday与本课数据介绍
### TidyTuesday
* [TidyTuesday（#TidyTuesday）](https://github.com/rfordatascience/tidytuesday) 是由 Data Science Learning Community（DSLC，原 R4DS 社区） 组织的全球性、每周一次的数据实践社区活动，核心是用真实数据集练手数据清洗、可视化与分析，主打 `R` 语言 `tidyverse` 生态，也支持 `Python`/`Julia` 等编程语言。
* TidyTuesday 的设立初衷是降低数据分析入门门槛，帮助初学者通过真实数据反复练习数据的**获取 — 清洗 — 整理 — 可视化**全流程。
* TidyTuesday 的核心规则是，每周二在 GitHub 发布 1 个真实、开源、干净度适中 的数据集（CSV/Excel），附数据字典、来源与背景说明。数据主题广泛，包含社会、经济、体育、环境、历史、娱乐等，多来自公开政府 / 媒体 / 研究数据。
* TidyTuesday 鼓励自由探索与可视化，参与者可使用 `R`（`tidyverse`：`dplyr`/`ggplot2`/`tidyr`）、`Python`、`Julia` 等工具做清洗、分析、可视化、建模、报告或 Shiny 应用。无标准答案，鼓励创意表达、技术练习、审美提升，重在过程而非结论。

### 本课数据介绍
* 本课数据是 TidyTuesday 2025 年第 14 周（2025-04-08） 的官方数据集：[Timely and Effective Care by US State](https://github.com/rfordatascience/tidytuesday/tree/3ad70e7afef15ddd0ed3d69379156fc74e3df9d9/data/2025/2025-04-08)（美国各州及时有效医疗服务数据），源自美国 CMS（医疗保险和医疗补助服务中心），聚焦全美各州医院的急诊等待、诊疗效率、质量指标，非常适合做医疗可视化、州际对比、时间趋势分析。
* 本课数据收录在`care_state.csv`文件中，它的数据规模是 1232 行 × 8 列，数据主题是美国各州按病种 / 指标的医疗服务及时性与有效性评分，可以用来分析急诊等待时长、州间差异、病种效率对比等。
    * 数据覆盖 6 大类疾病 / 服务：急诊、心脏病、肺炎、手术、卒中、预防保健等；
    * 数据包含 21 项质量 / 时效指标：如急诊等待时间、给药及时率、救治达标率；
    * 可用来探索以下问题：哪些州急诊等待最长 / 最短？哪些病种 / 指标耗时最久？州人口与等待时间是否相关？

## Step 1 数据理解与清洗
* 我们之前完成的proj 01数据比较规整、简单，本课中，我们遇到的数据是一个真实的医疗系统数据，它的变量多、结构复杂、而且不干净（存在缺失值等）

## Step 2 

## Step 3 


## Step 4 



## Step 5 本课总结
* 本节课展示了真实**数据分析的基本流程**：① 看数据（结构） -> ② 清洗数据（NA / 类型）-> ③ 看分布（单变量） -> ④ 找关系（多变量） -> ⑤ 画图表达 -> ⑥ 写结论。
