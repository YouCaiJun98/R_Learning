# 11 tidyverse修改与新增变量

2026/3/30

写在前面：暂无 : )

---

## tidyverse修改变量
* 使用`mutate()`函数对现有的变量进行操作：
    ```R
    mutate(<待修改的变量>, <新增部分的方式>)
    ```
* 当然，这个函数对变量的操作是非常灵活的，比如你可以通过修改它的`if_else`参数来实现复杂功能：
    ```R
    mutate(age_idx = if_else(condition = age_idx < 1000, true=1000, false=age_idx))
    ```
    * `if_else`中，`condition`是原列中待判断的条件，如果为真就按`true`后面的元素赋值，否则就按`false`后面的元素赋值。
    * 这里，`if_else`是`dplyr`包里的函数，不是`R`base中的`ifelse`！
        ```R
        function (condition, true, false, missing = NULL, ..., ptype = NULL, 
        size = deprecated()) 
        {
            check_dots_empty0(...)
            if (!is_missing(size)) {
                lifecycle::deprecate_warn(when = "1.2.0", what = "if_else(size = )", 
                    id = "dplyr-if-else-size")
            }
            vec_if_else(condition = condition, true = true, false = false, 
                missing = missing, ptype = ptype, error_call = current_env())
        }
        <bytecode: 0x000001706e9436f8>
        <environment: namespace:dplyr>
        ```
* 如果`mutate()`里面出现了原向量没有的列，那就是新加一列；如果出现原向量中已有的列，那就是对这个列进行修改。
* `tidyverse`的好处之一在于可以将复杂的向量操作写到一句话里
    * 但是，代价是可读性会变差