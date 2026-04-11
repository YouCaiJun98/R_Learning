# 1、导入stock.xlsx，并命名成stock_2
# 2、在stock_2数据集中新增一个变量class。SH_closing_price值小于25000，
# class对应的值是1，SH_closing_price在25000和35000之间，class对应的值是2
# SH_closing_price大于等于35000，class对应的值是3。
# 3、提取出stock_2的 SH_closing_price、class这两列
# 4、基于stock_2数据集绘制散点图，横坐标是SH_closing_price，
# 纵坐标是HSCI_closing_price。将class类别映射到不同颜色。