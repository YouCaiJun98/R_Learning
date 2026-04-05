# 04 nomogram列线图

2026/4/5

写在前面：暂无。

---

## 本课概览
* 目标：生成论文常见`nomogram`，并解释读图方法
* 核心内容：
    * `rms::lrm()`拟合
    * `datadist`的必要性：`dd <- datadist(data); options(datadist="dd")`
    * 画列线图：`nomogram()` + `plot()`
输出：一张`nomogram`图

## rms::lrm拟合步骤说明
* 下面这段代码是利用`rms::lrm`拟合logistic模型：
    ```R
    dd <- datadist(data_nom)
    options(datadist = "dd")

    fit_lrm <- lrm(
        TreatmentOutcome ~ AGE_AT_DIAGNOSIS + ER_STATUS + HER2_STATUS + TUMOR_STAGE,
        data = data_nom,
        x = TRUE, y = TRUE
    )

    print(fit_lrm)
    ```
    * 其中，`dd <- datadist(dat_nom)`是用`datadist()`计算`data_nom`数据集的分布、分位数等统计信息，是`rms`包建模的前置必要步骤；
    * `options(datadist = "dd")`是将全局选项`datadist`设置为刚才生成的`dd`对象，让`rms`包的函数能自动读取数据分布信息；
    * `fit_lrm <- lrm(...)`是用`lrm()`拟合多因素logistic回归模型，第一个传入参数（公式）和之前的`glm()`的完全一样，`data`参数的含义也和之前一样，`x = TRUE, y = TRUE`表示要求模型保存设计矩阵`x`和响应变量`y`，是后续绘制列线图、做模型验证的必要参数。
    * `print(fit_lrm)`是打印模型拟合结果，包含回归系数、OR 值、P 值、模型拟合优度等统计量。
* Q：为什么这里要用`lrm()`？它和之前的`glm()`有什么区别呢？
    * A：tl;dr: `glm()`是通用统计模型，`lrm()` 是专门为画图 / 列线图而生的增强版。做回归用`glm`，画列线图必须用`lrm`。
    * `glm`不提供绘制列线图需要的内部信息，而`lrm`是 `rms` 包设计好的、专门配合 `nomogram()` 的模型；
    * 在数学上，`glm()`属于广义线性模型，而`lrm()`是 Logistic 回归的最大似然估计，两者的系数、OR、P 值几乎一样，只是包装不同！
    * 更具体的区别如下：

    | 功能 | glm(..., binomial) | rms::lrm() |
    |------|-------------------|------------|
    | 来源 | base `R` 自带 | `rms` 包（临床预测模型专用） |
    | 画列线图 | 不支持 | 支持 |
    | 必须 datadist | 不需要 | 必须 |
    | 输出内容 | 系数、标准误、P值 | 系数、P值、拟合优度、预测指标 |
    | 主要用途 | 多因素回归、OR/P值 | 列线图、临床预测模型 |
    | 论文场景 | 单因素/多因素表 | 列线图、校准图、决策曲线 |

* 画图结果如下：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260405225048763.png)
    * 好像可以根据每个患者的标签来找到对应的分数，有点神奇🤔
