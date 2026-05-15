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
* 数据集的结构为 100 行 × 100 列，100行对应了 100 位独立模拟患者，100 列分为三大类核心字段，患者唯一标识字段（1 列）、患者特征字段（85 列，二分类 0/1 变量）、疾病风险预测字段（14 列，0-1 连续数值）。

## Step 1 数据理解与风险变量探索


## Step 2 多变量 EDA 与风险画像


## Step 3 构造 Outcome 与 Logistic Regression 入门


## Step 4 单因素 Logistic Regression


## Step 5 多因素 Logistic Regression


## Step 6 模型解释、可视化与局限性

## 项目总结
* 在 Proj 03 中，我们进行了一次完整的真实风险分析：从理解风险数据、提出风险问题，到分析多个变量之间的关系，再到建立并解释 logistic regression model。
* 在这一过程中，我们学习了 OR、CI、p-value、confounding、adjustment 等医学统计中的核心概念。更重要的是，我们开始意识到：统计模型并不是自动生成答案的机器，而是一种帮助我们理解现实的工具。
* 我们逐渐发现，现实中的风险因素往往不是单独存在的。变量之间会彼此关联，单变量分析也可能受到 confounding 的影响。因此，真正的数据分析并不仅仅是发现关系，而是不断思考：这个关系是否可靠、是否受到其他变量影响、是否可能被误解。
* 因此，Proj 03 的重点并不只是学习 logistic regression 的语法，而是尝试建立一种 **statistical modeling** 思维，从单纯地描述数据转为解释风险。
* 在接下来的 Proj 04 中，我们会继续面对更加复杂、更接近真实公共卫生与流行病学场景的数据，并进一步学习如何把数据分析组织成一个完整、合理、具有解释性的分析故事！😎

