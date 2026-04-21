library(tidyverse)

# 绘制散点图
## 基础图像
### 绘制单个变量的散点图
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

### 绘制两个变量的散点图
ggplot(mtcars, aes(x = mpg, y = cyl)) +
  geom_point() +
  labs(
    x = "Miles Per Gallon (mpg)",
    y = "Number of Cylinders (cyl)",
    title = "Scatter Plot of mpg vs cyl"
  ) +
  theme_minimal()

### 绘制数据框两两变量之间的散点图
library(GGally)
ggpairs(mtcars)


## 改变散点图中点的设置
### 改变点的形状
ggplot(mtcars, aes(x = wt, y = disp)) +
  geom_point(shape = 17) +  # 修改点形状
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()

### 改变点的尺寸
ggplot(mtcars, aes(x = wt, y = disp)) +
  geom_point(shape = 17, size = 4) +  # 调整点形状 + 放大尺寸
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()


### 改变点的颜色
ggplot(mtcars, aes(x = wt, y = disp, color = factor(cyl))) +
  geom_point(shape = 17, size = 4) +
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    color = "Cylinders",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()

## 数值范围与文本显示
### 在图像中指定显示的数值范围
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

### 在图像中增加标题 - 略（在上面已经通过title实现了！）


# 绘制其他类型的图像
## 绘制折线图
### 基础折线图
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

### 改变线的类型
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


### 改变线的粗细
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


## 绘制点线图
mtcars %>%
  arrange(wt) %>%
  ggplot(aes(x = wt, y = disp)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(size = 3, color = "darkred") +
  theme_minimal()

# 批量绘图
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


