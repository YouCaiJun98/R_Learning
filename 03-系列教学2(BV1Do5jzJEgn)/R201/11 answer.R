# 1、mtcars新添加一个变量class，当变量wt小于等于3时，class的值是1；
# 当变量wt在3和5之间时，class的值是2；
# 当wt的值大于等于5的时候，class的值是3。
library(dplyr)
mtcars$class <- case_when(
  mtcars$wt <= 3 ~ 1,
  mtcars$wt < 5 ~ 2,
  TRUE ~ 3
)

# 2、查看mtcars数据集里的变量wt、disp、class的情况
head(mtcars[, c("wt", "disp", "class")])

# 3、画出气泡图，要求横坐标是变量qsec，纵坐标是变量wt，
# 圆圈的面积与变量disp相关。圆圈的颜色与class相关。
# 可以使用现成的配色方案来美化图像。
library(RColorBrewer)
x <- mtcars$qsec          # 横坐标：qsec
y <- mtcars$wt            # 纵坐标：wt
class_col <- brewer.pal(3, "Set2")[mtcars$class]  # 按class配色

symbols(
  x = x,                  # 横坐标：qsec
  y = y,                  # 纵坐标：wt
  circles = mtcars$disp,  # 气泡大小由 disp 决定
  inches = 0.4,           # 控制气泡最大尺寸（防止太大）
  bg = class_col,         # 气泡填充色（按class）
  fg = "black",           # 气泡边框色
  main = "气泡图：qsec ~ wt",
  xlab = "qsec",
  ylab = "wt"
)