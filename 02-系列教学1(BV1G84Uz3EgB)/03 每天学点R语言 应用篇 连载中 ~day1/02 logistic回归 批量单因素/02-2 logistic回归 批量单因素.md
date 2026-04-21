# 02-2 logistic回归 批量单因素

2026/4/4

写在前面：暂无。

---

## 本课概览
* 用`tidyverse`风格重塑上节课的内容

## 建立模型
* UP主补充说，使用`glm()`分析之前，哪怕不去`NA`也是没问题的，因为这个函数会自动帮你忽略掉有NA的部分。
* 手工去掉`NA`可以用`drop_na()`这个函数：
    ```R
    data_analysis %>% drop_na()
    ```
    * 这个包是`tidyr`包的函数，专门用来删除含缺失值`NA`的行，它的基本用法如下：
    ```R
    # 删所有含 NA 的行
    数据 %>% drop_na()

    # 只在指定列里检查 NA，其他列不管
    数据 %>% drop_na(列名1, 列名2)
    ```
* 这里又用到了一个函数，`map_dfr()`，这个函数的功能是**循环+自动把结果拼成一个数据框**，可以理解为一种高级的`for`循环。它对很多列 / 很多变量做同一件事，每次返回一行 / 一个小数据框，最后自动`rbind`绑成一张大表。这也是它名字的来源（map=循环，也就是对每个元素做同一件事；d=data，输出数据结构；r=row，结果按行拼接；f=frame，最终变成数据框）
* 用到了一个函数，`as.formula()`，它的作用是 把“字符串文字”变成`R`能识别的“公式公式（formula）”。
    * 对于这节课的例子，`glm(y ~ x, family = binomial())`中的`y ~ x`就是一个公式（formula）。
    * 但是，如果你想在函数里、循环里动态生成公式，就必须用`as.formula()`
    * 用代码来进一步说明：
        ```R
        # 字符串（文字，R 看不懂这是公式）
        str <- "TreatmentOutcome ~ age"

        # 变成真正的公式
        f <- as.formula(str)

        # 现在可以直接丢进 glm 里用！
        glm(f, family = binomial(), data = data_analysis)
        ```
* 豆知识：`paste`和`paste0`的区别在于，`paste0`粘贴中间没有连接符，`paste`默认为一个空格（之前的课程提到过哦）
* 又用到`broom`包中的一个函数，`tidy()`，这个函数的作用是把 glm / lm 模型的一堆杂乱结果，提取成标准表格格式，这个表格中包括系数、标准误、统计量、P 值，运行的结果会非常直观、漂亮：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260404230851779.png)
    * 这个函数有两个比较重要的参数，`conf.int`和`exponentiate`：
        ```R
        tidy(
        model,            # 你的 glm 模型
        conf.int = TRUE,  # 输出 95% 置信区间
        exponentiate = TRUE  # 自动 exp 变成 OR！不用自己算！
        )
        ```
* 结果分析：
    * 下图左侧为UP主的运行结果，右侧为我们的运行结果：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260404231248995.png)
    * Q：为什么有的变量右面被加了“Right”（比如“LATERALITYRight”），有的被加了“Positive”（比如“HER2_STATUSPositive”）？A：因为这几个都是二分变量，它们的基线是“Left” / “Negative”，这里显示的是相对于基线得到的OR值，所以这里出现了一个标注；如果是三变量，则会有两行（分别相对于基线的OR值）
    * Q：为什么我们这里是6行，UP主是7行？A：因为我们的“TUMOR_STAGE”变成了两行，这是因为原始数据中多了一个“0”的类型，所以这里成了上述三变量的情形，基线是“0”。

## 核心函数回顾
* 这次我们采用由外到内的方式来解析这个函数：
    ```R
    map_dfr(predictors, \(x){
        f <- as.formula(paste0("TreatmentOutcome ~ ", x))
        fit <- glm(f, family = binomial(), data=data_analysis)
        
        broom::tidy(fit, conf.int=T, exponentiate=T) %>% filter(term != "(Intercept)")
    })
    ```
    * 最外层：`map_dfr(predictors, \(x){ ... })`。最外层的函数调用是`map_dfr()`，它的作用是对predictors里的每个元素循环执行函数，最后把所有结果按行拼成一个数据框。这个函数第一个传入参数是predictors，意思是要对这个向量进行处理；第二个传入参数是一个**匿名函数**（我们在第一节课中遇到过），它的写法是`\(x){ ... }`，它等价于`function(x){ ... }`，其中`x`表示当前循环到的自变量名（比如"age"）
    * 第一行：`f <- as.formula(paste0("TreatmentOutcome ~ ", x))`。最外层是调用了`as.formula()`这个函数，并把它的返回结果（一个`formula`类型的变量）赋值给变量f，如前所述，这个函数的作用是字符串转换成`R`能识别的公式对象，以解决循环里动态生成公式的问题。`as.formula()`的传入参数是一个`paste0`的返回结果，它返回的是一个字符串，就是将`TreatmentOutcome ~ `与`x`（对应的字符串）拼在一块。
    * 第二行：`fit <- glm(f, family = binomial(), data=data_analysis)`。这行比较简单，就是通过`glm()`函数建模，这里的传入参数`f`取代了之前的公式`data_analysis$TreatmentOutcome ~ data_x`，同时，因为指定了`data=data_analysis`，所以`$`之前的`data_analysis`也不用加了。
    * 第三行：`broom::tidy(fit, conf.int=T, exponentiate=T) %>% filter(term != "(Intercept)")`。管道符前半行的意思是用`broom::tidy()`函数对分析得到的结果`fit`进行整理，同时指定生成置信区间（`conf.int=T`），且计算指数的形式（`exponentiate=T`）；管道符后半的意思是，将名称为"(Intercept)"的行删除。

