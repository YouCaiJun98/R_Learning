# 实战项目2说明

2026/5/18  

---

## 写在前面
　
抱歉瑞晴，我本来规划在这一部分找几篇糖尿病领域的经典文章，结合公开数据集帮你做一份真实科研场景下的`R`语言实战教学的，但是我最近因为各种原因耽误了这件事，最终也没能做起来，或许以后有机会再做吧。
　　
我可以把我的思路给你说一下，这条思路经过了AI的调整，如果你有时间（虽然不太可能），可以自己尝试一下。

这一部分大概分成两个部分，第一部分是复现你导师发表的文章，我找到了你导师近期发表的两篇文献，放在了 ref 目录下。第二部分是结合开源数据集 + 糖尿病领域的顶刊文章做复现。

## 第一部分思路
* 因为我毕竟不是你们这个领域的，所以以下内容大幅参考了AI，可能不一定对。
* 第一篇偏临床试验 / RCT / endpoint analysis / algorithm evaluation，第二篇则偏观察性研究 / 回归分析 / 队列分析 / 生存分析。
* 我找到的你导师发表的第一篇文献是《A Randomized Clinical Trial for Meal Bolus Decision Using Learning-based Control in Adults With Type 2 Diabetes》，本质上是一个随机对照临床试验（RCT），它的核心结构非常典型，包括：
    * 两组随机分配（AP-A vs physician）
    * 主要终点（TIR）
    * 安全性终点（TBR）
    * 基线特征表（Table 1）
    * 非劣效性检验
    * CGM指标分析
    * 箱线图/时间趋势图
    * logistic / 随机化检验 / CI 分析
    * 算法推荐与医生决策一致性分析

    这篇文章适合拿来做：
    1. Table 1 基线特征表复现
    2. CGM 指标统计（TIR/TAR/TBR）
    3. 箱线图 + 中位数/IQR 可视化
    4. 临床 trial workflow 图
    5. 非劣效性分析思路
    6. Bland-Altman 一致性图
    7. 医学论文风格结果表整理

    尤其是 Fig 1 的 trial flow、Fig 2/3 的 endpoint comparison、Fig 4 的 agreement analysis，这些都很像医学统计课程里的经典案例。

* 第二篇《Preserved C-peptide is common and associated with higher time in range in Chinese type 1 diabetes》则是非常标准的“临床观察性研究 + 回归分析”范式。它里面几乎把医学统计论文中最常见的内容全覆盖了：
    * 横断面分析
    * 纵向队列分析
    * logistic regression
    * Cox regression
    * CGM 指标分析
    * 分组比较
    * OR + CI + P value
    * Table 1 基线表
    * Figure 1 流程图
    * Figure 2 分组可视化

    比如：
    * preserved vs low C-peptide 两组比较
    * diabetes duration 与 C-peptide 的关系
    * logistic regression 的 OR 表
    * Cox regression 分析 β-cell function
    * TIR/TAR 与 C-peptide 的关联分析

* 通过这两篇文章的复现，应该能锻炼你组织 clinical table、做统计检验、表达效应大小、画论文风格图像、把回归结果整理成可以发表的形式的表格、写出医学论文里的结果分析逻辑的能力。当然，因为你现在也在投稿，或许实战对你来说效果更好。


## 第二部分思路
* 第二部分的思路是找一些开源数据集，对照顶刊文章的思路进行分析。当然，现在很多顶刊都要求开源数据，说不定也能找到带数据的顶刊文章。
* 可以参考的开源数据集包括：
    * **NHANES**（美国国家健康与营养调查），它的特点是完全公开、样本量巨大、糖尿病变量非常丰富、有大量指标（比如HbA1c、BMI、血脂、饮食、运动、死亡随访）、顶刊大量使用，`R` 支持极其成熟。很多 NEJM / JAMA / Diabetes Care 风格的分析，都能在 NHANES 上仿制。你可以用它做logistic regression、Cox regression、survey-weighted analysis、subgroup analysis、restricted cubic spline、forest plot、publication table。而且，NHANES 是真实世界数据，会有缺失值、偏态、异常值、复杂抽样，这和真实科研非常接近。
    * MIMIC-IV，它是 ICU 临床数据库，层次更高，但难度也大很多。它的优点是顶刊使用极多、临床真实感极强、可以做 survival / ICU outcome / sepsis / diabetes complication，缺点是 SQL 门槛高、数据清洗极复杂、更像临床数据工程。
    * CGM / diabetes 开源数据集，比如OhioT1DM Dataset、OpenAPS Data Commons、Tidepool、Jaeb Center datasets，它们适合做TIR/TAR/TBR、glucose trajectory、time series visualization、glucose variability，但它们比较偏偏 engineering / device / time-series。
* 当然，现在有的顶刊也会要求提供数据，比如Nature Medicine、BMJ、PLOS Medicine、Diabetes Care、Lancet Digital Health，你可以看看有没有带公开数据的 Diabetes Care / BMJ / Lancet Digital Health 论文，做部分结果复现。

