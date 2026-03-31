# 13 tidyverse排序与抽样

2026/3/31

写在前面：暂无。

---

## tidyverse数据排序
* 使用`arrange()`函数来排序：
    ```R
    arrange(<待排序向量>, <排序依据>)
    data %>% arrange(Age) # 例如，将data向量按照Age排序
    ```
    * 默认按照**升序**排列，如果需要降序排列，要这么写：
    ```R
    data %>% arrange(desc(Age))
    ```
    * 如果想**多变量排序**，就在`arrange()`中用逗号隔开几个排序依据：
    ```R
    data %>% arrange(Stage, desc(Age)) %>% head() # 多变量排序，先按Stage升序排，再按Age降序排
    ```
* 介绍了一个`head()`函数，它的作用是打印出来一个向量的前几行：
    ```R
    > data %>% arrange(Age) %>% head()
    # A tibble: 6 × 5
    PID     pCR   Age Stage Subtype 
    <chr> <dbl> <dbl> <chr> <chr>   
    1 P171      0  30.1 I     HR-HER2+
    2 P112      0  30.3 III   HR+HER2+
    3 P193      1  30.8 II    HR+HER2+
    4 P047      0  31.4 I     HR+HER2+
    5 P083      0  31.4 I     HR+HER2+
    6 P040      1  31.8 III   HR+HER2+
    ```

## tidyverse数据抽样
* UP主提到在医学里，验证集可以分为“内部验证集”与“外部验证集”，这两个在计算机领域分别对应“验证集”与“测试集”。
* `tidyverse`抽样有两个函数，分别是`sample_frac()`和`sample_n()`：
    * `sample_frac()`：按比例抽样，例如：
    ```R
    data_sub <- data %>%  sample_frac(0.3) # 从data中抽30%的数据
    ```
    * `sample_n()`：按个数抽样
    ```R
    data_sub2 <- data %>%  sample_n(50) # 按数量抽样
    ```
