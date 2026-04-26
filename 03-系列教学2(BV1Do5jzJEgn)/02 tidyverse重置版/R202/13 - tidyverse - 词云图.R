# 加载数据
library(readxl)
tianmao <- read_excel('./data/tianmaoTV.xlsx', skip=1)


# 进行分词 + 按照词频保留分词结果
library(jiebaR)
library(tidytext)
library(tidyverse)
## 自定义分词函数（让 tidytext 支持中文）
wk <- worker()

segment_zh <- function(text) {
  segment(text, wk)
}

word_freq <- tianmao %>%
  # 逐行对 name 列分词，返回列表
  mutate(
    word_list = map(name, ~segment(.x, wk))
  ) %>%
  # 展开列表，一行一个词
  unnest(word_list) %>%
  # 重命名列
  rename(word = word_list) %>%
  # 清洗无意义词
  filter(
    str_length(word) >= 2,
    !str_detect(word, "[0-9]"),
    !word %in% c("吋")
  ) %>%
  # 统计词频
  count(word, sort = TRUE) %>%
  slice_head(n = 60)

# 绘制词云图
library(ggwordcloud)
ggplot(word_freq, aes(label = word, size = n, color = word)) +
  geom_text_wordcloud(
    family = "SimHei",  # Windows用黑体，Mac改成"PingFang SC"
    shape = "circle"
  ) +
  scale_size_area(max_size = 20) +
  theme_minimal() +
  labs(title = "商品名称词云图") +
  theme(plot.title = element_text(hjust = 0.5))

