# 05 (tidyverse) 基础绘图函数-plot函数

2026/4/20

写在前面：从本节课开始我们将使用`tidyverse`包对这个系列中的教学内容进行重置，AI交互与代码编写可以看视频，编程结果在Rproj中，笔记里是对用到的api（函数接口）进行简要介绍，**HAVE FUN!** 😉

---



## 本课课纲
* 介绍如何使用`tidyverse`画出Base `R`（对应原版第五节课，基础绘图函数-plot函数）中的图。
* 介绍绘图函数的若干参数。

## 绘制散点图
### 基础图像
* 绘制单个变量的散点图
    * 代码如下：
        ```R
        mtcars %>%
        mutate(idx = row_number()) %>%  # 创建索引列
        ggplot(aes(x = idx, y = wt)) +
        geom_point() +
        labs(
            x = "Index",
            y = "Weight (wt)",
            title = "Scatter Plot of mtcars$wt"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232240321.png)

* 绘制两个变量的散点图
    * 代码如下：
        ```R
        ggplot(mtcars, aes(x = mpg, y = cyl)) +
        geom_point() +
        labs(
            x = "Miles Per Gallon (mpg)",
            y = "Number of Cylinders (cyl)",
            title = "Scatter Plot of mpg vs cyl"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232328354.png)

* 绘制数据框两两变量之间的散点图
    * 代码如下：
        ```R    
        library(GGally)
        ggpairs(mtcars)
        ```

    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232448276.png)

### 改变散点图中点的设置
* 改变点的形状
    * 代码如下：
        ```R
        ggplot(mtcars, aes(x = wt, y = disp)) +
        geom_point(shape = 17) +  # 修改点形状
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            title = "Scatter Plot of disp vs wt"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232558135.png)
* 改变点的尺寸
    * 代码如下：
        ```R
        ggplot(mtcars, aes(x = wt, y = disp)) +
        geom_point(shape = 17, size = 4) +  # 调整点形状 + 放大尺寸
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            title = "Scatter Plot of disp vs wt"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232650152.png)

* 改变点的颜色
    * 代码如下：
        ```R
        ggplot(mtcars, aes(x = wt, y = disp, color = factor(cyl))) +
        geom_point(shape = 17, size = 4) +
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            color = "Cylinders",
            title = "Scatter Plot of disp vs wt"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232713784.png)

### 数值范围与文本显示
* 在图像中指定显示的数值范围
    * 代码如下：
        ```R
        ggplot(mtcars, aes(x = wt, y = disp, color = factor(cyl))) +
        geom_point(shape = 17, size = 4, alpha = 0.8) +
        coord_cartesian(ylim = c(100, 400)) +
        scale_color_brewer(palette = "Set1") +
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            color = "Cylinders",
            title = "Scatter Plot of disp vs wt"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232731904.png)

* 在图像中增加标题 - 略（上述图像绘制时已经实现了）

## 绘制其他类型的图像
### 绘制折线图
* 基础折线图
    * 代码如下：
        ```R
        mtcars %>%
        arrange(wt) %>%  # 按 wt 排序
        ggplot(aes(x = wt, y = disp)) +
        geom_line(color = "steelblue", linewidth = 1) +
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            title = "Line Plot of disp vs wt"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232812938.png)

* 改变线的类型
    * 代码如下：
        ```R
        mtcars %>%
        arrange(wt) %>%
        ggplot(aes(x = wt, y = disp)) +
        geom_line(color = "steelblue", linewidth = 1, linetype = "dashed") +
        geom_point(size = 3, color = "darkred") +
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            title = "Line Plot of disp vs wt (Dashed Line)"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232841315.png)

* 改变线的粗细
    * 代码如下：
        ```R
        mtcars %>%
        arrange(wt) %>%
        ggplot(aes(x = wt, y = disp)) +
        geom_line(
            color = "steelblue",
            linetype = "dashed",
            linewidth = 2   # 加粗线条
        ) +
        geom_point(size = 3, color = "darkred") +
        labs(
            x = "Weight (wt)",
            y = "Displacement (disp)",
            title = "Line Plot of disp vs wt (Thicker Dashed Line)"
        ) +
        theme_minimal()
        ```
    * 绘制结果如下：
        ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232904460.png)

### 绘制点线图
* 代码如下：
    ```R
    mtcars %>%
    arrange(wt) %>%
    ggplot(aes(x = wt, y = disp)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(size = 3, color = "darkred") +
    theme_minimal()
    ```
* 绘制结果如下：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232934573.png)

## 批量绘图
* 代码如下：
    ```R
    types <- c("p", "l", "b", "c", "o", "h", "s", "n")

    df <- map_dfr(types, ~ mtcars %>%
                    arrange(wt) %>%
                    mutate(type = .x))

    ggplot(df, aes(x = wt, y = disp)) +
    
    # p: points
    geom_point(data = ~ filter(.x, type == "p")) +
    
    # l: line
    geom_line(data = ~ filter(.x, type == "l")) +
    
    # b: both (points + line)
    geom_line(data = ~ filter(.x, type == "b")) +
    geom_point(data = ~ filter(.x, type == "b")) +
    
    # c: line without points（近似）
    geom_line(data = ~ filter(.x, type == "c"), linetype = "dashed") +
    
    # o: overplotted (line + point)
    geom_line(data = ~ filter(.x, type == "o")) +
    geom_point(data = ~ filter(.x, type == "o")) +
    
    # h: histogram-like vertical lines
    geom_segment(
        data = ~ filter(.x, type == "h"),
        aes(xend = wt, y = 0, yend = disp)
    ) +
    
    # s: step
    geom_step(data = ~ filter(.x, type == "s")) +
    
    # n: nothing（只保留坐标轴）
    geom_blank(data = ~ filter(.x, type == "n")) +
    
    facet_wrap(~ type, ncol = 3) +
    labs(x = "mtcars$wt", y = "mtcars$disp") +
    theme_minimal()
    ```
* 绘制结果如下：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260421232958941.png)