# Proj 03 Patient Risk Profiles

2026/5/14  

写在前面：
　　这节课是我们项目实战的第三节课，我们还是使用`tidytuesday`这个[github项目](https://github.com/rfordatascience/tidytuesday)中的开源数据。
　　在前面的项目中，我们从学习`R`语法逐渐过渡到数据分析。在 Proj 02 中，我们开始面对更真实、更复杂的数据，并学习了如何完成一次相对完整的 EDA（探索性数据分析）流程。
　　本项目更进一步，将从之前简单的数据描述推进到风险分析。在这个项目中，我们将使用 `tidytuesday` 的 Risk Profiles 数据集，进行风险分析与统计建模训练。我们会学习如何识别 risk factor、如何理解多个变量之间的关系，以及为什么真实研究中需要使用 logistic regression 来分析风险。
　　整个项目的主线是 “ **EDA→风险分析→Logistic Regression→模型解释** ” ，希望你能够建立 statistical modeling 思维，而不仅仅是学会调用模型函数。😉

---

## Step 0 本项目数据介绍
* 本项目使用的数据是TidyTuesday 2023 年第 43 周（发布时间 2023-10-24）的[主题数据集](https://github.com/rfordatascience/tidytuesday/tree/main/data/2023/2023-10-24)，核心围绕患者风险画像（Patient Risk Profiles） 展开，由 Jenna Reps 为庆祝 R/Pharma 大会专门整理发布，是医疗数据分析、风险建模的练习数据集。
* 数据来源是基于真实世界大型医疗数据集训练的逻辑回归模型，**生成**了 100 条模拟患者的完整数据。数据还原了临床场景中 “**患者病史特征 + 疾病风险预测**” 的典型数据形态，适合用于数据清洗、特征工程、风险建模。数据集未做列名标准化清洗，需要我们自己做字段处理、数据规整。
* 数据集的结构为 100 行 × 100 列，100行对应了 100 位独立模拟患者，100 列分为三大类核心字段，患者唯一标识字段（1 列）、患者特征字段（85 列，二分类 0/1 变量）、疾病风险预测字段（14 列，0-1 连续数值）。字段的详细说明如下：
    * 患者唯一标识，1个，整数，每位模拟患者的唯一 ID，无重复值
    * 患者特征字段，85 个二分类字段，1 代表患者符合该特征 / 有该病史 / 有该用药史，0 代表不符合 / 无，具体分为以下子类：
        * 年龄分组特征 20 个，覆盖全年龄段的 5 岁间隔分组，包括 `age group: 0 - 4`、...、`age group: 90 - 94`；
        * 性别特征，2 个，`Sex = FEMALE` & `Sex = MALE`分别表示患者为女 / 男；
        * 既往病史与疾病特征，40 个，覆盖了循环系统、呼吸系统、消化系统、内分泌系统、神经系统、精神类疾病等全科室常见疾病；
        * 用药与治疗史特征，18 个，覆盖了常见处方药、抗生素、激素类药物的暴露史；
        * 生活习惯与其他特征，5 个，包括吸烟史、饮酒史等健康相关行为特征。
        * 疾病风险预测字段，14 个，所有风险字段均为 0-1 之间的连续数值，代表基于患者当前特征，模型预测的未来 1 年发生该结局的概率，0=0% 概率，1=100% 概率。

## Step 1 数据理解与变量探索
### 数据理解
* 之前我们已经尝试了做基础 EDA、看变量分布、做简单多变量分析，这些都是在描述数据长什么样，我们关心的是数据怎么分布、指标有什么特征。在这个项目中，我们将接触患者风险数据，更关心的是哪些变量是真正重要的（是潜在的风险因素）、哪些变量只是伴随出现、哪些变量可能彼此相关，以及如何从数据中提出风险假设。

* 接下来，还是按照之前的数据理解流程，读入数据、理解数据、清洗数据。
    * （这里我们就直接看工作区里的变量了）
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515212016975.png)

    * 在拿到数据时，需要考虑一个变量是连续变量还是分类变量、它的数值类型是什么、它可能是 risk factor 还是 outcome，它的实际意义是什么、可能和哪些变量相关等。

    * 因为这个数据集是逻辑回归模型生成的数据集，所以没有缺失值。

* 如 Step 0 所示，我们可以对这100列变量进行分组，除了第 1 列的序号外，大致可以分成三类：
    * 第一组是人口学变量，例如 `age group:  65 -  69`、`Sex = FEMALE`，这些变量的特点是 0/1 编码。某个年龄组为 1，表示这个人属于该年龄组；Sex = FEMALE 为 1，表示这个人是女性。
    * 第二组是既往一年中的健康状态、疾病、用药或暴露，例如 `Hypertension in prior year`，这些变量也是 0/1 编码，它们不是连续指标，而是是否发生过/是否存在过的标记。
    * 第三组是预测风险变量，例如 `predicted risk of Pulmonary Embolism`，这些数据不是实际发生的疾病结局（原始临床 outcome），而是由某种模型给出的预测风险。我们在后续做 logistic regression 之前，需要明确后续如何构造 outcome，而不是直接把它当成真实疾病发生结果（比如，我们可以用一个阈值来截取数据）。

### 数据检查
* 检查 0/1 类型的指示变量
    * 我们可以挑几个 0/1 取值的指示变量来观察：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515215645029.png" width="50%" height="auto">
    </div>

    * 这里的“0” / “1”就是一个分类变量，表示是否符合某个条件。它的和自然是100（样本总量）。

* 检查人口学变量是否合理
    * 理论上这个项目中的人口学变量应该是 one-hot 编码：一个人应该只属于一个年龄组、性别组
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515220101316.png" width="50%" height="auto">
    </div>

    * 这里我们对每个样本都按年龄 / 性别求和，求和的结果是 `n_age_group`，因为一个人应该只属于一个年龄组、性别组，所以它的结果是1。（反之，如果不是1，那么一个人就对应了多个年龄 / 多个性别，那数据就出错了！）

* 探索既往疾病与用药特征
    * 我们可以挑选一些 prior year 变量，查看这些特征在样本中的出现比例：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515220541372.png" width="50%" height="auto">
    </div>

    * 可以发现，0/1 编码的变量不仅可以用 `count()`计数，也可以用 `mean()` 来计算它在样本中的比例。

* 探索预测风险（predicted risk）变量
    * 接下来可以观察几个 predicted risk 的分布（注意，我们可以把这些 predicted risk 改造成outcome!）
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515221151675.png" width="50%" height="auto">
    </div>

    * 这些风险值通常会很小，而且分布可能很偏。这在医学风险预测中很常见，因为很多疾病事件本身就是低发生率事件。但是，即使 0.02 这样的预测风险，也可能已经代表相对较高的风险。

### 本节小结
* 这一小节我们检查了数据，这份数据由人口学 one-hot 变量、prior year 的疾病/用药/暴露指示变量，以及多个 predicted risk 变量共同组成。我们先建立对数据结构的正确理解，弄清楚哪些变量是特征、哪些变量是预测风险、哪些变量可以被构造成 outcome，后面才可以做多变量 EDA、风险画像和 logistic regression。

## Step 2 多变量 EDA 与风险画像
* 本项目中的变量大多数是 0/1 指示变量，每一列代表某种人口学特征、既往疾病、用药或暴露，每个样本还对应了多个预测风险值。我们在分析时，已经不能一个指标一个指标地看数据了，这和实际情况也是对应的：现实中的患者特征往往是组合出现的。例如，某个患者可能同时属于高年龄组、有高血压、有糖尿病、有心衰、使用过某些药物。这要求我们不能只看单个变量，而是需要考虑**变量之间的协同关系** / 多个变量同时作用下的风险画像。

* 我们可以提出许多问题，例如：
    * 多个风险变量之间是否存在关联？
    * 哪些疾病经常共同出现？
    * 不同年龄组的风险模式是否不同？
    * 哪些特征与高 predicted risk 相关？

### 特征组合
* 我们可以选择若干风险变量，观察它们之间的关联。我们通过计算两两变量之间的相关性来描述它们的关联程度：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515232353671.png" width="80%" height="auto">
    </div>

    * 可以通过热力图的形式展示不同变量之间的关联程度，它反映了这些特征是否倾向共同出现。

### 疾病共现
* 除了风险因素可能彼此相关外，疾病也可能关联出现，这应该是比较符合现实中医学分析的，我们关心的可能不仅仅是单个疾病，而是共病（comorbidity）。我们可以很自然地提出问题，比如：
    * 高血压与糖尿病是否经常同时存在？
    * 某些疾病组合是否特别常见？
* 以高血压和二型糖尿病为例，我们观察它们的频次：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260515233103581.png" width="80%" height="auto">
    </div>

    * 在所有的 24 个病例中，同时患有高血压（对应`Hypertension in prior year`取值为1）和二型糖尿病（对应`Type 2 Diabetes Mellitus (DM), with no type 1 or secondary DM in prior year`取值为1）的病人有3位，看起来是一个比较高的比例了。

### 年龄组与风险模式
* 某些疾病的发生应该和年龄有很大的关系，我们还可以探究不同年龄组的疾病发生风险模式，也就是**风险分层**。
    * 我们以痴呆症为例，它在人群中发生的均值（注意，我们在这里只是简单地在这 100 个样本中，对发生风险取了平均值）是：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516083943741.png" width="40%" height="auto">
        </div>

    * 我们把样本按照年龄分组，再检查不同年龄组人群发生痴呆症的风险：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516084402838.png" width="40%" height="auto">
        </div>
        可以看出，痴呆症发生的风险和年龄增长还是有比较明显的正相关性的。



### 哪些特征与 predicted risk 更相关（单因素风险探索）
* 我们已经探索了风险因素之间的关联、疾病之间的关联、年龄组和疾病风险的关联，下一步，我们可以把“年龄组”进行推广，探索风险因素和疾病风险之间的关联。

    * 例如，我们可以探索，有高血压史的病人，他们发生肺栓塞的可能性会不会更高？
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516085515342.png" width="40%" height="auto">
        </div>
        可以看出，有高血压史的病人，他们发生肺栓塞风险的概率中位数要更高一点，但总体很难看出有多大的关联性。
    
    * 我们可以多看几组风险因素和疾病风险概率的关系，画出小提琴图：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516090106796.png" width="70%" height="auto">
        </div>
        看起来，我们这次挑选的因素和肺栓塞的关联都比较明显。

    * 当然，因为这组数据中没有真实的医疗结果（outcome），所以我们分析的都是特征与预测风险的关系。

### 单变量分析的局限
　　经过上述的单因素风险探索，我们发现一项疾病可能与许多风险因素关联，也就是风险变量是混杂（confounding）的。当多个变量彼此相关时，简单比较可能误导。所以，我们需要考虑这些因素之间的混杂效应，也就是为什么我们需要logistic regression。

### 本节小结
* 在这一小节中，我们第一次开始分析“风险画像”。相比上一小节中对单个变量的理解，我们这一小节更关心的是不同特征之间如何共同出现，不同患者群体的 predicted risk 是否存在差异，以及多个 prior year 特征是否可能共同影响风险。
* 在这个过程中，我们开始接触一些概念，比如共病（comorbidity）、风险分层（risk stratification）、特征共现（co-occurrence）和混杂（confounding）。
* 我们意识到，简单的单变量分析已经越来越难回答复杂问题，这就引出了下一小节的问题，“如果多个变量会同时影响 risk，我们能不能用一个 statistical model，统一分析这些变量？”

## Step 3 构造 Outcome 与 Logistic Regression 入门
* 在前两个小节中，我们分别进行了patient risk profiles 数据理解和多因素EDA。我们之前的分析都是一个变量一个变量地看，而现实中的风险往往是多个因素共同作用的。我们想知道，能不能用一个统一的模型同时分析这些变量？这也就是这一小节要引入的Logistic Regression。
* 我们在这一小节要解决的问题有；
    * 什么是 outcome、如何构造binary outcome；
    * logistic regression 在解决什么问题。

### 什么是outcome & 构造binary outcome
* 这个项目中的疾病风险数据都是 `predicted risk of ...`，这些变量不是真实疾病是否发生（不是临床结局 outcome），而是某种模型预测出的风险值。为了做Logistic Regression，我们必须自己构造 outcome。

* 我们可以这样构造一个二元结局，将 `predicted risk of Pulmonary Embolism`排名前 10% 的样本标记为高风险：
    ```R
    threshold <- quantile(
        risk$`predicted risk of Pulmonary Embolism`,
        0.9
    )

    risk <- risk %>%
        mutate(
            high_pe_risk =
            if_else(
                `predicted risk of Pulmonary Embolism`
                >= threshold,
                1,
                0
            )
    )
    ```

* 很多医学问题本质上都在回答某件事会不会发生，例如，患者是否属于高风险人群、是否进入风险最高的群体、是否需要进一步干预，这类问题有一个共同特点，即 outcome 只有两种状态，也就是我们这里构造的二元结局（Binary Outcome）。

### logistic regression
* logistic regression 在做什么：Logistic Regression 本质上在回答，当给定某些特定条件的时候，某件事发生的概率是多少。也就是说，它是**基于选定的条件，建立某事发生的概率模型**。
* 我们可以建立一个简易的模型：
    ```R
    model <- glm(
    high_pe_risk ~
        `Heart failure in prior year`,
    family = "binomial",
    data = risk
    )
    ```
* 再使用 `summary(model)` 来检查这个模型：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516111518923.png" width="70%" height="auto">
    </div>
    对于这个模型的解释，我们下一小节再做展开！

### 本节小结
* 之前的探索中，简单的 EDA 虽然能够帮助我们观察数据、发现趋势、提出问题，但当多个变量开始共同影响风险时，仅靠简单比较已经越来越难真正回答问题。
* 在这一小节中，我们开始尝试用一个统一的 statistical model 同时分析多个特征，并预测某个患者是否属于高风险群体。我们构造了二元的结局变量，并引入了 logistic regression。
* 我们会在下一小节中解释 Logistic Regression 的结果😎

## Step 4 单因素 Logistic Regression
* 我们在上一节中第一次建立了一个 statistical model 模型，这一小节中，我们开始解释这个模型，对应了风险解释（risk interpretation）。我们在这一小节中将会解释 Logistic Regression 中的若干变量：
    * coefficient 是什么意思；
    * 什么是 odds；
    * 什么是 odds ratio（OR）；
    * p-value 在回答什么；
    * CI 为什么重要；
    * 为什么统计显著不等于现实重要。

### coefficient - 影响的方向
* coefficient 代表了影响的方向：
    * coefficient > 0 表示变量更容易进入高风险组；
    * coefficient < 0 表示风险可能降低。

* 在当前的模型里，`Heart failure in prior year` 系数为正，看起来与更高风险相关。
* 但是，这个建模结果合理吗？各个变量对结局的影响有多显著？

### Odds - 相对可能性
* 回答上述问题以前，我们先介绍 Odds，它表示了一种“相对可能性”，它的实际含义是，事件发生的概率与不发生的概率的比值。
* 例如，100个样本中，80 个属于高风险，20 个属于低风险，那么
    $$\rm{odds} = 80 / 20 = 4$$
    也就是说，高风险的可能性，是低风险的 4 倍。

### Odds Ratio - 变量让 Odds 改变的程度
* Logistic Regression 关心的是某个变量会让 odds 改变多少，例如，`OR = 2`表示高风险的 odds变成原来的 2 倍，而`OR = 0.5`意味着odds 降低一半。

* 在当前模型中，`Heart failure coefficient = 1.31` 表示有心衰既往史的人更容易进入我们标定的高风险组。我们可以根据这个建模结果进一步计算 OR 值：
    ```R
    exp(coef(model))
    ```
    * 计算结果如下：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516111823705.png" width="70%" height="auto">
        </div>
        这意味着，有心衰既往史的人，进入高风险组的 odds 大约是其他人的 3.7 倍。
    
    * 然而，尽管心衰的效应大小（effect size）非常大（OR值接近4），但我们**不能将它描述为统计显著**，这是因为当前模型中，心衰的`Std. Error = 0.683`，这意味着模型对这个效应的估计不够稳定。这可能是因为样本量太小、high risk 人群太少、心衰本身较少见、数据波动较大等。

### p-value - 证据的强弱程度
* p-value 本质上是在问，如果这个变量实际上没有效果（原假设为真），我们观测到当前这样的系数（或更极端结果）的概率有多大。
它反映了“变量效应是随机噪声导致”的可能性，p值越小，说明“这种效应是偶然出现”的概率越低，我们拒绝“变量无效应”的证据越强；
反之，p值越大，说明当前数据不足以排除“效应只是随机波动”的可能，我们对变量是否真的存在效应的信心不足。

### Confidence Interval - 置信区间
* 真实数据永远存在随机性，所以 OR 不可能是一个绝对真值。统计学需要给出一个可能的范围。对于我们建立的模型，计算出来的置信区间为：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516111956750.png" width="70%" height="auto">
    </div>

* 还是以心衰为例，它的 OR 值是1.318，对应的p值是0.0537，这只是对真实总体 OR 的一个点估计。而 95%CI 区间我们计算出来是0.950~14.774，它的含义是，我们有 95% 的信心认为，真实的总体 OR 值在 0.950 到 14.774 之间。
* CI 通常比单独 p 值更重要，这是因为：
    * p 值只告诉你是否显著，但不告诉你效应有多大（需要搭配 OR 值）、不确定性如何；
    * CI 同时包含效应大小（区间中心）、不确定性（区间宽度，宽度越大越不稳定）。

### 本节小结
* 在上一小节中，我们发现建模的重要性，而在这一小节里，我们解释了模型中变量的含义。我们探索了coefficient、OR 值（优势比）、p-value等模型系数的含义，结合数据背景与统计不确定性去理解这些结果。
* 在下一小节中，我们将进一步探索，如果多个变量之间彼此相关，模型结果会发生什么变化。

## Step 5 多因素 Logistic Regression
* 在上一小节中，我们解释了 Logistic Regression 的结果，并掌握了coefficient等模型描述的概念。我们还开始思考，为什么某些变量效应很大却不显著、为什么某些结果会不符合直觉等。
* 但是，我们只是对结果进行一定解释，并没有区分出变量之间的相互影响：现实中的**变量，往往不是独立存在的**。例如，有心衰的患者，可能也更容易高龄、有高血压、糖尿病等。换句话说，我们看到的效应本身，究竟是这个变量单独的作用，还是与它共同出现的其他特征导致的（即Confounding）？我们在这一小节中将进一步探索，当多个变量彼此相关时，模型结果会发生什么变化。
* 在这一小节里，我们将会：
    * 进一步解释 confounding 和 adjustment；
    * 引入独立效应（Independent Effect）。

### 从单因素 Logistic Regression 到多因素 Logistic Regression
* 根据我们之前的分析结果（Heart failure OR ≈ 3.7），有心衰既往史的人，进入高风险组的 odds 大约是其他人的 3.7 倍，（这里不考虑样本数量较少、方差较大的问题）看起来是心衰一个非常强的风险因素。但是，这一效应真的只是心衰这个单独的变量产生的吗？还是说，这里其实也部分掺杂了其他影响因素产生的效应？

* 我们可以考虑引入其他的风险因素，比如年龄。年龄几乎影响所有慢病，进而会影响大多数风险模型。如果不控制年龄，年龄的效应会混入其他风险变量的效应里（也就是confounding），所以我们修改我们的单因素 Logistic Regression 模型，把它改造成一个多因素 Logistic Regression 模型：
    ```R
    model_multi <- glm(
    high_pe_risk ~
        `Heart failure in prior year` +
        `age group:  80 -  84` +
        `Hypertension in prior year`,
    family = "binomial",
    data = risk
    )
    ```

### Confounding 与 Adjustment
* 我们接着查看多因素 Logistic Regression 模型的 OR 值，如下图所示：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516115205885.png"width="70%" height="auto">
    </div>

* 可以发现，加入年龄这一风险因素后，心衰的 OR 值从 3.736 降低至 3.502，这说明，之前单因素模型中心衰的效应是混杂的（confounding），它一部分来源于年龄的影响。而加入年龄后，模型开始控制年龄，心衰的影响也被重新估计，也就是Adjustment。

* 需要注意的是，哪怕做了调整（Adjustment），模型依然可能因为有遗漏变量、有 measurement bias、有 hidden confounding而存在偏差！多变量模型能够减少部分 confounding，但无法保证完全消除 bias！

### 独立风险因素
* 多变量模型想回答的问题是，在其他条件相同（年龄相近、慢病情况相近）的人中，某一因素（如心衰）是否是风险因素。如果我们把其他因素的效应都排除了（把这些因素引入模型），发现心衰的 OR 值还是大于1，就说明它是一个独立风险因素。

### 模型预测
* 我们在拿到这个多因素模型后，可以用这个模型去预测样本在风险因素的组合下，发生危险的可能。
    * 我们可以预测原始数据上各个样本高风险的可能性：
        ```R
        predict(model_multi, type = "response")
        ```
        结果如下所示，每个样本都会对应一个分数（概率）：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516151558725.png"width="90%" height="auto">
        </div>

    * 当然，我们也可以构造一个新的样本出来，用模型来预测这个新样本高风险的概率：
        ```R
        new_patient <- data.frame(
        check.names = FALSE,
        `Heart failure in prior year` = 1,
        `age group:  80 -  84` = 1,
        `Hypertension in prior year` = 0
        )

        predict(model_multi, newdata = new_patient, type = "response")
        ```
        预测结果如下所示：
        <div align="center">
            <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516151736067.png"width="90%" height="auto">
        </div>

### 本节小结
* 我们在这一小节中遇到了多个变量对模型结果的影响。我们发现，单因素 OR 与多因素 OR 会不同，进一步了解了confounding 和 adjustment，并接触了Independent Effect。应该意识到，模型中的效应往往不是某个变量天然的影响，而是在控制其他变量后，重新估计得到的。

## Step 6 模型局限性
* 到目前为止，我们已经建立 Logistic Regression 并做了单因素与多因素分析。但是，我们经常会遇到模型结果不合理的问题。例如，为什么 adjustment 后 OR 没有明显变化？为什么某些变量看起来 effect 很大，但不显著？这是因为，我们建立的模型只是对现实的一种近似描述。在这一小节中，我们要去正确理解模型。

### 模型结果异常（稀疏数据）
* 我们把上一小节中的多因素模型进行简单修改，把年龄分组换成`85-89`岁：
    ```R
    model_multi <- glm(
    high_pe_risk ~
        `Heart failure in prior year` +
        `age group:  85 -  89` +
        `Hypertension in prior year`,
    family = "binomial",
    data = risk
    )
    ```
    我们发现，这个模型直接炸了，它的 OR 值出现了一个极低的小值：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516122535308.png"width="70%" height="auto">
    </div>

* 这可能是因为**数据太稀疏**。这个项目中样本的总量是100，同时符合高风险组+年龄组的样本可能非常少。这时，模型会尝试极端地分离这部分样本，这就会导致 coefficient 非常极端，OR 接近 0 或无限大，出现不稳定估计的问题。
* 这个现象在临床分析中应该非常常见，医学数据往往不是大量均匀数据，比如，某些疾病很少见、某些年龄组人数很少、某些风险 outcome 本身就稀少。此时，模型中的很多变量组合几乎没有样本，这时再进行 Logistic Regression 结果就会非常不稳定。

### p-value是万能的吗
* 回到我们之前的单因素模型。模型的描述参数为：
<div align="center">
    <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516122937410.png"width="70%" height="auto">
</div>

* 我们之前下的结论是，虽然心衰的效应大小（OR值）很大，而且p值很低，但是我们不能将它描述为统计显著，这是因为当前数据样本量不大、outcome 稀少、方差很大。即使 OR 很高，模型仍然可能不够确定。总结起来，**统计显著和效应大小是两件事情**。

### 真实模型不一定符合直觉
* 我们可以再构造一个多因素模型出来：
    ```R
    model <- glm(
    high_pe_risk ~
        `Hypertension in prior year` +
        `Heart failure in prior year` +
        `Type 2 Diabetes Mellitus (DM), with no type 1 or secondary DM in prior year`,
    family = "binomial",
    data = risk
    )
    ```

* 检查它的结果，发现高血压对应的 OR 值小于1，它居然是一个保护因素：
    <div align="center">
        <img src="https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260516125523450.png"width="70%" height="auto">
    </div>

* 这可能是受到了混杂、稀疏数据、当前 outcome 的定义方式等因素的影响。尤其是，当前的 outcome 本来就是从 predicted risk 构造出来的，它不是真实疾病发生。
* 我们可以产生一种认识，即**模型结果本来就不一定符合现实医学常识，它必须结合数据来源理解**。

### 关联性不等于因果性
* 我们在分析中发现心衰的 OR 值约等于3.7（先不考虑样本数量等其他因素），这也不代表心衰一定导致高风险。这是因为，一方面，我们的数据本身是观测数据，而且结局变量还是基于风险预测的结果派生的。**模型只能说明关联性，不能代表因果性**。

### 本节小结
* 在这一小节中，我们对建模的局限性进行了分析。应当产生这样一种认知，真实模型的结果往往并不完美，它永远只是对现实的一种近似描述。重要的不是相信模型，而是理解模型为什么会得到这样的结果，以及这些结果可能受到哪些因素影响（数据背景、变量关系、数据质量、样本结构等）。


## 项目总结
* 在 Proj 03 中，我们进行了一次完整的真实风险分析：从理解风险数据、提出风险问题，到分析多个变量之间的关系，再到建立并解释 logistic regression model。
* 在这一过程中，我们学习了 OR、CI、p-value、confounding、adjustment 等医学统计中的概念。我们应该能产生一种认知，即统计模型并不是自动生成答案的机器，而是一种帮助我们理解现实的工具。
* 我们发现，现实中的风险因素往往不是单独存在的。变量之间会彼此关联，单变量分析也可能受到 confounding 的影响。因此，在做数据分析时，我们需要做的并不仅仅是发现关系，而是不断思考：这个关系是否可靠、是否受到其他变量影响、是否可能被误解。
* 在接下来的 Proj 04 中，我们会继续面对更加复杂、更接近真实公共卫生与流行病学场景的数据，并进一步学习如何把数据分析组织成一个完整、合理、具有解释性的分析故事！😎

