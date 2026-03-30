# 08 tidyverse管道符

2026/3/30

写在前面：暂无 : )

---

## 安装tidyverse
* 在`R`中直接运行`install.packages(tidyverse)`会报错，所以我们要手动安装这个包。
* 注意，在安装前需要保证`RTools`已经安装完毕。
* 运行以下命令安装`tidyverse`的依赖：
    ```R
    install.packages(c('broom', 'conflicted', 'dbplyr', 'dplyr', 'dtplyr', 'forcats', 'googledrive', 'googlesheets4', 'haven', 'hms', 'lubridate', 'modelr', 'readr', 'readxl', 'reprex', 'rvest', 'tidyr'))
    ```
* 接下来，手动安装tidyverse_2.0.0.tar.gz这个离线安装包（已放置在本课目录下）

## 管道符
* 符号形式（在R Studio中可以按Ctrl+Shift+M快捷打出来）：
    ```R
    %>%
    ```
 * 作用是依次对某个变量采取某些处理，避免大量括号堆积，例如，下面的函数调用是等价的：
    ```R
    sum(a)
    a %>% sum()
    ```
 * 当然，管道符也可以堆叠起来，这样可以看清楚数据的流动：
    ```R
    a %>% sum() %>% log() %>% exp()
    ```
* `R`语言自带的管道符是`|>`：
    ```R
    sum(a)
    a |> sum()
    ```






