library(tidyverse)

# 绘制散点图
## 基础图像
### 绘制单个变量的散点图
mtcars %>%
  mutate(idx = row_number()) %>%
  ggplot(aes(x = idx, y = wt)) +
  geom_point(size = 3, color = "steelblue") +
  labs(
    x = "Index",
    y = "Weight (wt)",
    title = "Scatter Plot of wt vs Index"
  ) +
  theme_minimal()

### 绘制两个变量的散点图
ggplot(mtcars, aes(x = mpg, y = cyl)) +
  geom_point()

### 绘制数据框两两变量之间的散点图
library(GGally)
ggpairs(mtcars)

## 改变散点图中点的设置
### 改变点的形状
ggplot(mtcars, aes(x = wt, y = disp)) +
  geom_point(shape = 17) +
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()

### 改变点的尺寸
ggplot(mtcars, aes(x = wt, y = disp)) +
  geom_point(shape = 17, size = 4) +
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()


### 改变点的颜色
ggplot(mtcars, aes(x = wt, y = disp)) +
  geom_point(shape = 17, size = 4, color = "tomato") +
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()


## 数值范围与文本显示
### 在图像中指定显示的数值范围
ggplot(mtcars, aes(x = wt, y = disp)) +
  geom_point(shape = 17, size = 4, color = "tomato") +
  coord_cartesian(ylim = c(100, 400)) +
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Scatter Plot of disp vs wt"
  ) +
  theme_minimal()

### 在图像中增加标题 - 略


# 绘制其他类型的图像
## 绘制折线图
### 基础折线图
mtcars %>%
  arrange(wt) %>%
  ggplot(aes(x = wt, y = disp)) +
  geom_line() +
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
  geom_line(linetype = "twodash") +
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
  geom_line(linetype = "dashed", linewidth = 2) +
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
  geom_line(linetype = "dashed", linewidth = 2) +
  geom_point(size = 3) +   # 加上点
  labs(
    x = "Weight (wt)",
    y = "Displacement (disp)",
    title = "Line Plot of disp vs wt with Points"
  ) +
  theme_minimal()

# 批量绘图
types <- c("p", "l", "b", "c", "o", "h", "s", "n")

# 复制数据并标记 type
df <- map_dfr(types, function(tp) {
  mtcars %>%
    arrange(wt) %>%
    mutate(type = tp)
})

# 额外补一个空面板，让 facet_wrap 凑成 3x3
blank_panel <- tibble(
  wt = NA_real_,
  disp = NA_real_,
  type = " "
)

df_all <- bind_rows(df, blank_panel)

ggplot(df_all, aes(x = wt, y = disp)) +
  # type p: points
  geom_point(
    data = ~ dplyr::filter(.x, type == "p")
  ) +
  
  # type l: line
  geom_line(
    data = ~ dplyr::filter(.x, type == "l")
  ) +
  
  # type b: both
  geom_line(
    data = ~ dplyr::filter(.x, type == "b")
  ) +
  geom_point(
    data = ~ dplyr::filter(.x, type == "b")
  ) +
  
  # type c: 在 ggplot2 中没有完全等价语义，这里用 line 近似
  geom_line(
    data = ~ dplyr::filter(.x, type == "c")
  ) +
  
  # type o: overplotted，线和点同时画
  geom_line(
    data = ~ dplyr::filter(.x, type == "o")
  ) +
  geom_point(
    data = ~ dplyr::filter(.x, type == "o")
  ) +
  
  # type h: vertical lines
  geom_segment(
    data = ~ dplyr::filter(.x, type == "h"),
    aes(xend = wt, y = 0, yend = disp)
  ) +
  
  # type s: steps
  geom_step(
    data = ~ dplyr::filter(.x, type == "s"),
    direction = "hv"
  ) +
  
  # type n: nothing, only axes/frame
  geom_blank(
    data = ~ dplyr::filter(.x, type == "n")
  ) +
  
  # 空白第九格
  geom_blank(
    data = ~ dplyr::filter(.x, type == " ")
  ) +
  
  facet_wrap(~ type, ncol = 3, drop = FALSE) +
  labs(x = "mtcars$wt", y = "mtcars$disp") +
  theme_classic() +
  theme(
    strip.background = element_blank(),
    strip.text = element_text(face = "bold"),
    panel.spacing = unit(1, "lines")
  )

