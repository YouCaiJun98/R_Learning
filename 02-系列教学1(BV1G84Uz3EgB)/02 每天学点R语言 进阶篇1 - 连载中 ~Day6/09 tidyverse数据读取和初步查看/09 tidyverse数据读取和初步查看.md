# 09 tidyverse数据读取和初步查看

2026/3/30

写在前面：暂无 : )

---

## tidyverse的补充说明
* 下面的情况是出现了命名空间冲突（`dplyr`包里有个`filter`和`lag`函数，和`R`base中的函数重名了）：
![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260330124254909.png)
* “dplyr::filter() masks stats::filter()”意味着`dplyr`中的`filter`函数覆盖了`R`base中的`filter`，这种情况下，调用`filter`函数会指向`dplyr`中的函数，而不是基础包里的。
* 如果想用基础包里的函数，同时避免歧义，可以在调用时指定命名空间：
    ```R
    dplyr::filter()
    stats::filter()
    ```

## tidyverse数据读取
* 用下面这个函数来读取csv文件：
    ```R
    data <- read_csv('./data_case_day20.csv') # 来自于readr这个包
    data_df <- read.csv('./data_case_day20.csv') # 来自于base R
    ```
* 读出来的数据略有差别：
![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260330125024934.png)
* 利用`class()`函数判断两个变量的类型：
    ```R
    class(data)
    class(data_df)  
    ```
* 用`read_csv()`读出来的数据是一种混合数据格式（以兼容`tidyverse`的其他功能），而用`read.csv()`读出来的数据是一个数据框：
![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260330125155956.png)

## tidyverse数据查看
* 使用`glimpse()`函数来查看数据：
    ```R
    glimpse(data)
    glimpse(data_df)
    ```
![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260330125447252.png)
* UP主在这里提到了几个数据类型，`chr`（字符型）、`dbl`（双精度浮点数，你可以理解成一个非常精确的、带有小数点的数）和`int`（整形数，全是整数）。
* 尽管`tidyverse`和`R`base的函数很大程度上可以互相兼容，但还是推荐统一到一种上去。


