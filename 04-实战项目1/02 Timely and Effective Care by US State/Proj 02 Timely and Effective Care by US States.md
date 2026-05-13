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
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260507124540390.png" width="60%" height="auto">
    </div>

    我们发现 score 的**取值范围波动很大**！

* 这是因为这个数据中的 score 对应的**实际含义可以分为好几个类**！例如，对于 Emergency Department，它的 score 指的是在急诊室里等待的间，这个分数越低越好；对于 Colonoscopy care，它的 score 指的是接受适当随访筛查结肠镜检查建议的患者比例，这个分数越高越好。所在分析时，**需要把不同的情况分开分析**！

* 按照医疗场景分组后，score 的分布与数值范围就更正常一些了：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260507124738494.png" width="60%" height="auto">
    </div>

* 当然，我们也可以和 proj 01 里做过的那样，观察其他自变量的分布。例如，我们可以观察州的分布频数：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260507185056436.png" width="60%" height="auto">
    </div>
    
    * 不同州出现的频数不一样，说明不同州的数据收集存在差异。

* 简单总结 Step 2 的工作：检查自变量/因变量的数据分布，查看是否存在异常。需要特别注意的是，有时需要**判断同一变量内的数据含义是否一致 / 是否可比**。

## Step 3 多变量分析
* 接下来，我们可以考虑分析多个变量之间的关系。对于这个数据集，我们可以提出很多问题，例如：
    * Q1：不同州的医疗表现有没有差异？
    * Q2：同一个州，在不同医疗指标上的表现是否一致？

* 对于Q1，我们需要在同一个 measure（同一个指标）下进行比较
    * 我们首先需要从已有数据中筛选出来我们关心的指标，这里，我们选择评估每个州急诊接待时间，看看它们的分布差异。
    
    * 我们先过滤原始数据，从中选择 condition 为 Emergency Department 的数据，
        ```R
        cond_1 <- "Emergency Department"

        care_ed <- care_clean %>%
            filter(condition == cond_1)
        ```
        我们发现，哪怕在同一个医疗场景（Emergency Department）下，score 对应的物理含义都是不一样的：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260509171129106.png)
    
    * 所以，我们需要对样例进行进一步限制，确保我们收集的数据的物理含义是一致的：
        ```R
        cond_1 <- "Emergency Department"
        cond_2 <- "OP_18"

        care_ed2 <- care_clean %>%
            filter(condition == cond_1, str_detect(measure_id, cond_2))
        ```
        过滤之后，我们发现，哪怕 measure_id 都限定为了包含 "OP_18"，这些数据的物理含义还是有差异：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260509172652722.png)
        * "OP_18b"指的是急诊科通用患者的离院等待时间（面向所有急诊患者，统计他们从就诊到离开的耗时）
        * "OP_18c"指的是急诊科精神 / 心理健康患者的离院等待时间（专门面向精神 / 心理健康问题的患者）
        * 后缀"_LOW_MIN"指的是低百分位等待时间，代表等待时间较短的患者群体的水平（比如第 25 百分位）

    * 所以，我们要把样例的过滤条件设置得更详细一些，我们只看“急诊科通用患者的离院等待时间中位数”：
        ```R
        cond_1 <- "Emergency Department"
        cond_2 <- "OP_18c"

        care_ed3 <- care_clean %>%
            filter(condition == cond_1, measure_id == cond_2)
        ```

    * 最后，我们可视化不同州急诊科通用患者的离院等待时间中位数：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260511121946239.png" width="60%" height="auto">
        </div>
        
        从这张图中，我们可以得出一些结论，比如：
        * 在同一个医疗指标下（急诊科通用患者的离院等待时间），不同州之间存在明显差异。
        * 这可能是因为各州的医疗资源、人口密度、医院负荷不同导致的。
        * 但是，这个结论只能说“**相关**”，不能说“**因果**”，因为单纯靠数据分析只能得到相关性的结果，不能把它当成因果性的证据！

* 对于Q2，我们可以在同一个 state（同一个州）下比较不同的 measure 。
    * 我们还是以急诊为例，查看同一个州的不同 measure：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260512123514722.png" width="60%" height="auto">
        </div>
        
        * 可以看出，在同一个系列的指标（OP_18c / OP_18b）下，指标排布的顺序是可以解释的（按照百分位的不同，对应不同的接诊时长）
        * 但是，不同的指标在这张图里没有可比性！比如，OP_23的实际含义是“因卒中症状前往急诊科的患者中，在到达后 45 分钟内获得脑部扫描结果的患者百分比”，它和急诊患者接待时间 / 离院时间放在一起就完全没有可比性！（我们在这里只是展示一下可能的分析口径，这张图在这个场景下确实是没什么太大意义的！）
    * 我们可以对上面的图进行修改，将两个州的不同的 measure 进行对比：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260512125115957.png" width="60%" height="auto">
        </div>

        * 可以看出，在急诊科中，AK州的指标都要比AL州的指标稍好一些，这或许能反映出两个州医疗条件的差异！

* 简单总结 Step 3 的工作：对数据进行简单筛选，并观察不同变量之间的相关关系（设置不同的自变量，观察因变量的变化情况）。在这里，我们还是要注意对齐数据的含义，避免出现不可比的情况！

## Step 4 将分析组织成故事
* 在这一节，我们把之前碎片化的观察给组织起来，拼凑出来一个完整的结论。

* 与之前的步骤2、步骤3不同的是，刚才我们是根据数据找解释、下结论，这一节中，我们是带着结论找支撑。我们提出的主问题是，“美国不同州的急诊系统表现是否存在明显差异？”

* 第一步，我们要先定义什么叫“急诊系统表现”。我们限定 condition 为 Emergency Department，限定 measure 为急诊等待时间（这一步和 Step 3 中的 Q1 对应）：
    ```R
    cond_1 <- "Emergency Department"
    cond_2 <- "OP_18c"

    care_ed <- care_clean %>%
    filter(condition == cond_1, measure_id == cond_2)
    ```

* 第二步，我们先看整体分布。我们暂时先不关心哪个州最好，哪个州最差。我们先聚焦于整体上，急诊等待时间大概是什么水平。我们可以检查急诊等待时间集中在哪个区间、有没有极端值。通过这一步，我们对筛选后的数据**建立起背景认识**：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260513125556376.png" width="60%"height="auto">
    </div>

    * 可以看出来，数据主要分布在 200-300 这个区间，此外，还有 >400、>500 的离群数据。

* 第三步，进入核心比较，也就是故事的主体。我们按州比较急诊等待时间的差异（沿用Step 3的图）：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260511121946239.png" width="60%"height="auto">
    </div>

    * 可以看出来，有的州（比如PR）急诊等待时间明显高，有的州（比如SD）急诊等待时间非常短，差距可能有数倍。我们可以初步得到结论：**不同州之间，急诊等待时间差异非常明显**。

* 第四步，我们对差异的来源进行解释。和 Step 3 一致，我们可以按照人口密度、医疗资源、医院负荷、城市化程度等角度进行解释。
    * 同样，需要注意，我们现在只能提出可能解释，**不能证明因果关系**！

* 第五步，我们对图进行一些微调，让它服务于我们的结论：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260513130455336.png" width="60%"height="auto">
    </div>

* 当然，我们也可以让AI帮忙解释这一现象。
    > 请根据这张图，总结美国不同州急诊等待时间的特点。你可以按照人口密度、医疗资源、医院负荷、城市化程度等角度进行分析解释。
    
    > 从这张美国各州急诊科等待时间的条形图，我们可以清晰看到州际差异极大，整体呈现 “两头分化” 的特征。
    > 一、整体数据特征
    > * 等待时间跨度极大：从 SD（南达科他州）的～140 分钟，到 PR（波多黎各）的近 500 分钟，相差超过 3 倍。
    > * “高等待” 州集中分布：东北部（MD、DC、DE）、部分西部州（CA、AZ）等待时间明显更长；而中西部、部分山区州（SD、ND、NE、KS）等待时间普遍更短。

    > 二、多维度原因分析
    > 1. 人口密度与城市化程度
    > * 高密度 / 高城市化州等待时间普遍更长
    像 DC（华盛顿特区）、MD（马里兰州）、CA（加州）、NY（纽约州）这些城市化水平高、人口密度大的地区，急诊科面临的患者基数更大、就诊高峰更集中，排队等待的压力自然更高。
    > * 低密度 / 低城市化州等待时间更短
    中西部平原州（SD、ND、NE）人口分散，急诊患者流量低，医院的接诊压力小，因此等待时间普遍更短。
    > 2. 医疗资源分布与供给
    > * 资源紧张地区等待时间更长
    人口密集的大城市（如 DC、巴尔的摩所在的 MD 州），医疗资源的增长跟不上人口和患者需求的增长，急诊科床位、医护人员长期处于饱和状态，直接推高了等待时间。
    > * 资源相对充足地区等待时间更短
    部分人口少的州，人均医疗资源（急诊医生、床位）反而更充足，例如 SD、IA（爱荷华州），急诊接诊效率更高，等待时间更短。
    > 3. 医院负荷与运营压力
    > * 高负荷州：长期处于 “超饱和” 状态
    像波多黎各（PR）、DC、MD 这些地区，急诊科室长期处于高负荷运转，患者排队、检查、诊疗流程的每个环节都容易出现延误，最终体现在整体等待时间上。
    > * 低负荷州：运营压力小，流程更顺畅
    人口较少的州，急诊科室的患者流量相对平稳，很少出现 “挤兑” 情况，流程延误少，等待时间自然更短。

    > 三、补充视角：数据解读的注意点
    > * 这张图展示的是中位数等待时间（对应 OP_18b 指标），但它无法反映 “极端长等待” 的情况（比如OP_18b_HIGH_MIN代表的高百分位等待时间）。
    > * 像 PR、DC 这类等待时间特别长的地区，很可能同时存在医疗资源不足 + 患者流量集中 + 运营效率低的多重问题。

    > 总结
    美国各州急诊等待时间的差异，本质上是人口密度、医疗资源供给、城市化水平和医院运营负荷共同作用的结果：
    > * 人口密度高、城市化程度高、资源紧张的州（如 DC、MD、CA） → 等待时间显著更长
    > * 人口密度低、医疗资源相对充足、医院负荷低的中西部州（如 SD、ND、NE） → 等待时间普遍更短

* 简单总结 Step 4 的工作：梳理了数据分析工作的思路，① 提出问题 -> ② 限制比较范围 -> ③ 建立证据 -> ④ 给出解释 -> ⑤ 形成结论


## Step 5 本课总结
* 本节课展示了**描述性数据分析的基本流程**：① 看数据（结构） -> ② 清洗数据（NA / 类型）-> ③ 看分布（单变量） -> ④ 找关系（多变量） -> ⑤ 画图表达 -> ⑥ 写结论 + 给解释。
* 在这节课里，我们已经学会了如何处理复杂数据、如何判断可比性、如何完成一次 EDA 分析，但到目前为止，我们做的分析仍然是**描述性分析**。在下一个项目里，我们将开始预测（建模）数据！