# 02-1 logistic回归 批量单因素

2026/4/4

写在前面：暂无。

---

## 本课概览
* 目标：批量单因素回归，输出 OR、95%CI、P 值
* 核心内容：
    * 建立模型：glm(y ~ x, family = binomial())
    * 得到OR与置信区间
    * 批量建模
* 输出：单因素OR表

## 建立模型
* UP主介绍了一个函数，`glm()`。这个函数是**广义线性模型**，可以用它做二分类结局的 Logistic 回归。它的作用是，分析某个因素会不会影响结局（算出 OR 值、95% CI、P 值）。
    * 基本的格式是，
        ```R
        glm(<结局> ~ <变量>, family = binomial(), data = <数据>)
        ```
        * `<结局>`：二分类变量（0/1，有效 / 无效）
        * `~`：“被谁影响” / “关于谁”
        * `<变量>`：你要分析的因素（性别、年龄、血糖、分期……）
        * `family = binomial()`：明确这是在做 Logistic 回归
        * `data`：你的数据
* 补充：什么是“binomial”？
    * binomial是指二项分布（Binomial Distribution），它的前提是独立同分布的伯努利试验（Bernoulli Trial），即
        * 单次试验只有两种互斥结果：成功（记为 1）/ 失败（记为 0）；
        * 每次试验成功的概率为固定值 $p (0<p<1)$
        * 各次试验相互独立
    * 若随机变量 $Y$ 服从参数为 $n,p$ 的二项分布，记为：
        $Y∼\text{Binomial}(n,p)$


## 得到OR与置信区间
* 补充：什么是OR值？什么是P值？
    * OR值（比值比）：忽略数学定义，含义是，自变量每变1单位，阳性结局的优势（Odds）变成原来的多少倍。临床上的三段判定如下： 
        * $OR>1$：危险因素，X 越大，阳性结局概率越高
        * $OR=1$：无关联，X 和结局没关系
        * $OR<1$：保护因素，X 越大，阳性结局概率越低
        举例：
        * $OR=2.3$：X 每升 1 级，发生阳性结局的优势是原来的 2.3 倍；
        * $OR=0.6$：X 每升 1 级，发生优势只剩原来 60%（降低风险）。
    * P值是统计学假设检验，含义是若 $H_0$ 真的成立，观测到当前 / 更极端数据的概率
        * $P<0.05$：拒绝原假设，即有统计学关联，这个变量显著影响结局；
        * $P≥0.05$：不拒绝原假设，即现有数据下，看不出有明确关联。
* 分析结果通常有四列：
    ```R
    Coefficients:
                                    Estimate Std. Error  z value    Pr(>|z|)    
    (Intercept)                    -2.803446   0.275350  -10.18   <2e-16 ***
    data_analysis$AGE_AT_DIAGNOSIS  0.051543   0.004521   11.40   <2e-16 ***
    ```
    * 其中，`(Intercept)`这一行是没啥用的；
    * 一般在英文论文里，只需要报告OR值（需要对`Estimate`进一步操作，用`exp(Estimate)`）和`Pr(>|z|)`这两列。
    * 95%置信区间可以通过`Estimate`与`Std.`这两列计算出来（具体方法没讲，后文有更简单的函数调用方式）
* （操作说明）可以在数据可视化窗口中，点击下图所示的按钮，将数据提取式打出来：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260404212102705.png)
* 调用`confint()`函数计算置信区间（默认为95%置信区间）：
    ```R
    confint(model_logistic) # 计算estimate的置信区间
    exp(confint(model_logistic)[2, ]) # 计算OR值的置信区间
    ```

## 批量建模
* UP主补充说，这节课的单因素分析是有**前提条件**的，必须所有参与分析的变量的都是二分变量或者连续型变量（这节课里的LATERALITY、ER_STATUS、HER2_STATUS、TUMOR_STAGE）
* 可以通过构建函数来批量建模，将已经写好的代码进行一定改造，让它适用于更广泛的场景。
* 但是，UP主实际上是用了循环来做这件事：
    ```R
    OR <- c(); OR_LCI = c(); OR_UCI = c()
    # 批量建模
    for (i in 3:7) {
    data_x <- data_analysis[,i] # 需要先转换成向量
    model_logistic <- glm(data_analysis$TreatmentOutcome ~ data_x, family = binomial())
    ## 计算OR值
    OR[i-2] <- exp(model_logistic[["coefficients"]][2])
    ## 计算estimate的置信区间
    confint(model_logistic)
    ## 计算OR值的置信区间
    OR_LCI[i-2] <- exp(confint(model_logistic)[2, ][1])
    OR_UCI[i-2] <- exp(confint(model_logistic)[2, ][2])
    }
    ```
* 这里，UP主又介绍了一个函数，`colnames()`，它的功能是查看 / 修改 数据框的列名，
    * 查看：`colnames(数据)`
    * 修改：`colnames(数据) <- 新名字`
* 当然，我们也可以自己尝试写一个函数来处理：
    ```R
    OR_ <- c(); OR_LCI_ = c(); OR_UCI_ = c(); P_ <- c()
    ### 首先，定义一个函数
    model_logistic_func <- function(data, idx) {
    data_x <- data[,idx] # 转换成向量
    model_logistic <- glm(data$TreatmentOutcome ~ data_x, family = binomial())
    OR_[idx-2] <<- exp(model_logistic[["coefficients"]][2]) # 计算OR值
    confint(model_logistic) # 计算estimate的置信区间
    OR_LCI_[idx-2] <<- exp(confint(model_logistic)[2, ][1]) # 计算OR值的置信区间下界
    OR_UCI_[idx-2] <<- exp(confint(model_logistic)[2, ][2]) # 计算OR值的置信区间上届
    P_[idx-2] <<- summary(model_logistic)$coefficients[2, 4] # 计算P值
    }

    ### 接下来，循环调用
    for (i in 3:7) {
    model_logistic_func(data_analysis, i)
    }
    results_func <- data.frame(Variable = colnames(data_analysis)[3:7],
                            OR_, OR_LCI_, OR_UCI_, P_)
    ```
    * 注意，这里的`<<-`的含义是向**函数体外部赋值**，这其实背离的函数定义的初衷！理论上，应该让一个变量来接收这样的赋值！
