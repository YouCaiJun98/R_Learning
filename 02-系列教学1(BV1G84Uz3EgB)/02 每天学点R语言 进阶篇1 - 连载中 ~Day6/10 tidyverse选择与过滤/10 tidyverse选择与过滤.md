# 10 tidyverse选择与过滤

2026/3/30

写在前面：暂无 : )

---

## tidyverse数据选择
* 方法1 - 使用`select()`函数选择数据：
    ```R
    select(<变量名>, <待选择的列>)
    ```
* 方法2 - 搭配管道符使用：
    ```R
    <提取的变量> <- <被提取的变量> %>% select(<某些想提取的列>)
    data_sub <- data %>% select(PID) # 举个例子
    ```

## tidyverse数据过滤
* 使用`filter()`函数进行数据过滤：
    ```R
    dplyr::filter(<待过滤的变量>, <过滤条件>) # 为避免命名冲突，还是要带上"dplyr::"
    ```
* 当然，也是可以配合管道符用的：
    ```R
    data_sub2 <- data_sub %>% dplyr::filter(Age <= 40) # 例子
    ```

