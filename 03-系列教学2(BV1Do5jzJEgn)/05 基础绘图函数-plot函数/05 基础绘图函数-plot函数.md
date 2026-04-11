# 05 基础绘图函数-plot函数

2026/4/11

写在前面：**很不建议看这节课的教学视频！** 这节课讲的主要是`R`里内置的绘图函数，`plot()`。我们在上个系列里已学过`tidyverse`包了，似乎没有必要再学一个其他的绘图函数了。🤔

---

## 本课课纲
* 简介`plot()`函数，介绍不同类型曲线的绘制方法。
* 介绍绘图函数的若干参数。

## plot函数
* `plot()`函数是`R`里最基础、最万能的画图函数，用来快速绘制散点图、折线图，它的基本语法如下：
    ```R
    plot(x, y, type='p'...)
    ```
    其中，
    * `x`是横坐标数据；
    * `y`是纵坐标数据。
    * `type`是图类型，常见的类型包括`p`（点）,`l`（线）,`b`（点+线）,`h`（竖线）。
* 在本课展示的示例中，函数中的参数`y`也可以不指定，比如直接绘制一个数据框：
    ```R
    plot(mtcars)
    ```
    绘制结果如下所示：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260411202544109.png)
    这张图里包括11*11=121张子图，是数据框每两列分别当x-y画出来的。
* UP主提到了一个“高级绘图函数”和“低级绘图函数”的概念，在她的概念里，“高级绘图函数”是能自己生成一幅图的函数，而“低级绘图函数”是在已有的图幅上进行修改的函数。

## 绘图的参数设置 - type
* 除了在`plot()`函数内部修改参数外，还可以在`par()`函数内修改；前者的作用范围为当前这张图像，而后者的作用范围是全局。`par()`函数的基本语法如下：
    ```R
    par(mfrow = c(行数, 列数), col="red", lwd=2,  pch=16, ...)
    ```
    以上是常用的一些设置参数，其中：
    * `mfrow`的作用是一页画多张图；
    * `col`的作用是设置全局颜色；
    * `lwd`的作用是设置全局线条粗细；
    * `pch`的作用是设置全局点样式。
* 用到了`order()`函数，这个函数是排序专用函数，它会返回元素从小到大排列的位置序号，基本语法如下：
    ```R
    order(向量)
    # 举例
    x <- c(5, 2, 8)
    order(x)  # 返回 2 1 3
    ```
    * 这个函数最常用的用法是给数据框排序，例如本课给出的例子：
    ```R
    mtcars <- mtcars[order(mtcars$wt),] # 按照mtcars$wt从小到大的顺序，给mtcars按行重新排序
    ```
    这个例子有点绕，你可以这么理解，`order(mtcars$wt)`先给出了按照`mtcars$wt`排序之后的排序向量，例如`c(3,4,1,2)`，然后再用这个向量去构造一个`mtcars`的子集，顺序是按`mtcars$wt`从小到大排列。又因为`mtcars$wt`的行数和`mtcars`完全一样，所以得到的子集就是`mtcars`本身，只不过顺序换了。
* 给了一个批量绘图的例子，逻辑是用一个for循环迭代不同的图像类型，并绘制
    ```R
    par(mfrow=c(3, 3)) # 绘制三行三列的子图，按行排列
    # 批量绘图
    for (i in c('p', 'l', 'b', 'c', 'o', 'h', 's', 'n')) {
    plot(mtcars$wt, mtcars$disp, type = i, main = paste('type', i))
    }
    ```
    绘图结果如下：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260411204958050.png)

## 散点图的参数设置 - pch & cex
* `pch`参数控制的是散点图中点的形状，不同的数值对应了不同的点的形状：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260411205313911.png)
* `cex`参数是控制散点图中点的大小。默认大小为1，参数设置多少，就是让点变成原来的多少倍。

## 折线图的参数设置 - lty & lwd
* `lty`参数控制的是折线图中线的形状，不同的数值对应了不同的线形：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260411205907784.png)
* `lwd`参数控制的是折线图中线的粗细，默认大小为1，参数设置多少，就是让线的粗细变成原来的多少倍。

## 颜色控制
* `R`语言中常见的颜色值为RGB形式或16进制形式。
* 以下五种写法是等价的：
    ```R
    plot(mtcars$wt, mtcars$disp, type='l', col='blue')  # 颜色名称
    plot(mtcars$wt, mtcars$disp, type='l', col=4)  # 颜色编号
    plot(mtcars$wt, mtcars$disp, type='l', col='#0000FF')  # 颜色十六进制数值
    plot(mtcars$wt, mtcars$disp, type='l', col=rgb(0, 0, 1))  # RGB形式
    plot(mtcars$wt, mtcars$disp, type='l', col=hsv(h=240/360, s=1, v=1))  # HSV形式
    ```
    补充：
    * HSV和RGB类似，都是一种颜色空间。你可以理解成从不同维度对颜色进行拆分，RGB是从“红、绿、蓝”三种颜色基向量/基底对颜色进行“拆分”（或者说“分解”），而HSV是从H（Hue）色相、S（Saturation）饱和度、V（Value）明度进行分解。

## x/y轴取值范围限制
* 通过`xlim`/`ylim`这两个参数进行截距的设置，每个参数都应该传入一个二维向量，例如`xlim=c(1,4)`的意思就是，x轴的取值范围为[1, 4]。

## 图像文本添加
* 有两种方式，一种是在绘图函数内设置：
    * 主标题 - `main`参数
    * 副标题 - `sub`参数
    * x/y轴 - `xlab` / `ylab`参数
    * 示例如下：
        ```R
        plot(mtcars$wt, mtcars$disp, xlim=c(2,4), ylim=c(100,400),
            main='Motor Trend Car Road Tests', sub='2026-4-11',
            xlab='wt', ylab='disp')
        ```
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260411211458938.png)
* 一种是在绘图函数外设置：
    ```R
    plot(mtcars$wt, mtcars$disp, xlim=c(2,4), ylim=c(100,400),
        ann = F)
    title(main='Motor Trend Car Road Tests', sub='2026-4-11',
        xlab='wt', ylab='disp')
    ```


