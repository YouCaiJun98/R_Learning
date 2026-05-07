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
* 我们之前完成的proj 01数据比较规整、简单，本课中，我们遇到的数据是一个真实的医疗系统数据，它的变量多、结构复杂、而且不干净（存在缺失值等）。
* 首先，我们还是先把数据读进来，并做一个简单的可视化：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260429122654569.png)
    能看出来这是一个8列的数据，每列数据的含义可以在`TidyTuesday`上找到：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260429122823096.png)

* 接下来，我们来检查数据中的缺失值：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260429123033228.png)

* 简单起见，我们直接剔除数据中的缺失值：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260429125213312.png)


* 简单总结 Step 1 的工作：首先加载数据，查看数据结构；接下来理解变量的含义（查看变量类型、理解变量的实际含义）；最后处理缺失值（直接剔除NA值）。

## Step 2 单变量分析
* 这个数据集中，最重要的因变量是 score，我们对 score 进行可视化：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260507124540390.png)
    我们发现 score 的**取值范围波动很大**！

* 这是因为这个数据中的 score 对应的**实际含义可以分为好几个类**！例如，对于 Emergency Department，它的 score 指的是在急诊室里等待的间，这个分数越低越好；对于 Colonoscopy care，它的 score 指的是接受适当随访筛查结肠镜检查建议的患者比例，这个分数越高越好。所在分析时，**需要把不同的情况分开分析**！

* 按照医疗场景分组后，score 的分布与数值范围就更正常一些了：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260507124738494.png)



* 简单总结 Step 2 的工作：在判断同一变量内的数据含义是否一致 / 是否可比

## Step 3 






## Step 4 





## Step 5 本课总结
* 本节课展示了真实**数据分析的基本流程**：① 看数据（结构） -> ② 清洗数据（NA / 类型）-> ③ 看分布（单变量） -> ④ 找关系（多变量） -> ⑤ 画图表达 -> ⑥ 写结论。
