# 加载数据
library(readxl)
tianmao <- read_excel('./data/tianmaoTV.xlsx', skip=1)

# 进行分词 + 按照词频保留分词结果
library(jiebaR)
library(tidytext)



# 绘制词云图
library(ggwordcloud)
