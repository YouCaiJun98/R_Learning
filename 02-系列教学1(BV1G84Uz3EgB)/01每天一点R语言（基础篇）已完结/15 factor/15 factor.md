# 15 factor

2026/3/26

写在前面：暂无 : ) 

---

## 什么是factor
* 你可以把`factor`（因子）理解成`R`里**专门存放“分类 / 分组信息”**的一种特殊数据类型，不是普通数字、也不是普通文本：
    * 下图的例子，`factor`将Group中的"A"/"B"变成了两个**标签**，分别对应这两种情况：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260326124533339.png)
* 和普通文本的区别在于：
    * 普通文本（character）：只存文字，没有顺序
    * 因子（`factor`）：存**分类标签**，自带有限个固定类别，还能设置顺序
    * 例如，常见的场合：
        * 性别：男、女
        * 等级：低、中、高
        * 颜色：红、绿、蓝
        * 成绩：A、B、C、D
* `factor`有什么用呢？
    * 统计分类非常方便，它的输出多了一行`Levels`（水平 / 类别），非常直观；
    * 画图自动分组，柱状图、箱线图、分组分析，`R`只认`factor`当分组变量；
    * 可以设置有序分类，例如，
        ```R
        # 无序 factor
        level1 <- factor(c("低","中","高"))
        # 有序 factor
        level2 <- ordered(c("低","中","高"), levels = c("低","中","高"))
        ```
        这样，`R`就知道：“低 < 中 < 高”，排序、分析都会正确。
    * 节省存储空间，`factor`内部不存重复文本，只存数字编号+标签，大数据时更高效。

## factor的常用传入参数
* `ordered`：分组的顺序；
* `levels`：有几个分组；
* `labels`：重命名这几个标签。
    * 例如，通过传入c("M", "W")的`labels`标签，可以将`factor`的分组重新命名。
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260326125452290.png)
