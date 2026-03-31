# 12 tidyverse分组与汇总

2026/3/31

写在前面：下面介绍的这些具体的函数，比如`paste()`、`round()`等，它们具体的用法其实不用记，你只要知道有这个函数就行，剩下的可以直接问AI😉

---

## tidyverse数据分组
* 使用`group_by()`函数进行数据分组：
    ```R
    group_by(<分组变量>)
    data_result <- data %>% group_by(pCR) # 举个例子
    ```
    * 运行之后，得到的结果和之前的在形式上是一致的，只有在`summarize()`的时候分组才会生效：
    ```R
    data_result <- data %>% group_by(pCR) %>% summarize(N = n())
    ```
    * 上面这句话最后的`summarize(N = n())`，它的含义是，创建一个新的向量（列），名称叫“N”，它是调用了`n()`这个函数生成的，是对`group_by(pCR)`进行计数：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260331122318556.png)
    * 也可以**进一步按分组进行操作**，例如计算不同分组的年龄平均值：
    ```R
    data_result2 <- data %>% group_by(pCR) %>%  summarize(N = n(), Age_mean=mean(Age))
    ```
* 介绍了`paste()`这个函数：
    * 是`R`里用来把多个字符串、变量、数字拼接成一段文本的函数。
    * 例如，直接把多个内容用逗号隔开，就能拼在一起。默认输出时中间会自动加一个空格：
    ```R
    # 拼接字符串
    > paste("你好", "R语言")
    > "你好 R语言"
    ```
    * 可以用`sep =`设置中间的分隔符，例如：
    ```R
    # 用 - 连接
    > paste("2026", "03", "31", sep = "-") 
    > "2026-03-31"
    ```
    * 可以用`collapse =`把一整组向量拼成一个字符串，例如：
    ```R
    # 向量
    > fruits <- c("苹果", "香蕉", "橙子")
    # 用 、 拼成一句话
    > paste(fruits, collapse = "、")
    > "苹果、香蕉、橙子"
    ```
* 还讲了一个`round()`函数：
    * 是`R`里专门用来对数字进行四舍五入的函数，用来控制小数点后保留几位。
    * 基本用法如下：
        ```R
        round(x, digits = 0)
        ```
        * x：要四舍五入的数字
        * digits：保留几位小数（默认 0，即取整）
    * 例如，
        ```R
        round(3.14159)   # 结果：3
        round(3.6)       # 结果：4
        round(3.14159, 2)  # 结果：3.14
        round(5.678, 2)    # 结果：5.68
        ```
    
