library(readxl)
# 1、导入数据集stock.xlsx，将其命名成stock
stock <- read_excel("./data/stock.xlsx")

# 2、导入数据集returndaily.xlsx，将其命名成returndaily
returndaily <- read_excel("./data/returndaily.xlsx")

# 3、将stock数据集中的投资者信心指数（investor_confidence_index），
# returndaily数据集中上证指数日收益率（SH_return_daily）画到一张图中。

# 先画投资者信心指数（左轴）
plot(stock$time, stock$investor_confidence_index, 
     type = "l", col = "blue", lwd = 2,
     main = "投资者信心指数 vs 上证指数日收益率",
     xlab = "时间", ylab = "投资者信心指数",
     ylim = range(stock$investor_confidence_index, na.rm = TRUE))

# 叠加日收益率（右轴）
par(new = TRUE)
plot(returndaily$time, returndaily$SH_return_daily, 
     type = "l", col = "red", lwd = 2,
     axes = FALSE, xlab = "", ylab = "",
     ylim = range(returndaily$SH_return_daily, na.rm = TRUE))
axis(side = 4)  # 添加右侧坐标轴
mtext("上证指数日收益率", side = 4, line = 3)

# 添加图例
legend("topleft", 
       legend = c("投资者信心指数", "上证指数日收益率"),
       col = c("blue", "red"), lty = 1, lwd = 2)