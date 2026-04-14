# 1、将R中的颜色名称包含'green'的都找出来，
# 并利用条形图将其可视化的表现出来。
all_cols <- colors()
green_cols <- grep("green", all_cols, value=T, ignore.case = TRUE)

n <- length(green_cols)

barplot(height = rep(1, n), col=green_cols, names.arg = green_cols, horiz = T,
        las=1, cex.names = 0.5, xaxt='n')


# 2、画出mtcars数据集变量carb的饼图，可以利用我们上节课讲过的配色来美化饼图。
library(RColorBrewer)
# 统计carb的频数
carb_count <- table(mtcars$carb)
# 选择配色（用Set2定性配色）
pie_col <- brewer.pal(length(carb_count), "Set2")
# 绘制饼图
pie(carb_count, 
    labels = names(carb_count),
    col = pie_col,
    main = "mtcars 变量carb的分布饼图",
    clockwise = TRUE)

# 3、导入数据集stock.xlsx，生成的数据框命名成stock。画出变量SH_closing_price
# 并查看异常值还有五数统计量（下限、下四分位数、中位数、上四分位数、上限）
library(readxl)
stock <- read_excel("./data/stock.xlsx")
y <- boxplot(stock$SH_closing_price)
y$out
y$stats
