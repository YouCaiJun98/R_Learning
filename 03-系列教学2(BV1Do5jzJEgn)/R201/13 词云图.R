# 安装jiebaR
library(devtools)
install_github("qinwf/jiebaRD")
install_github("qinwf/jiebaR")

# 加载jiebaR
library(jiebaR)
worker()
?worker
mixseg <- worker() # 保留分词引擎设置
segment('我们在学习R语言', mixseg)
## 测试停用词词表
mixseg_new <- worker(stop_word = './data/ChineseStopWords.txt')
segment('我们在学习R语言', mixseg_new)

## 加载数据
library(readxl)
tianmao <- read_excel('./data/tianmaoTV.xlsx', skip=1)
tianmaoword_1 <- segment(tianmao$name, mixseg_new)
'吋' %in% tianmaoword_1

show_dictpath()
edit_dict() # 修改用户词典
'超高清' %in% tianmaoword_1

gsub('a', 'A', 'abcA')
gsub('\\d', '', '1234jklm99')
word_new <- gsub('\\d', '', tianmao$name)
tianmaoword_3 <- segment(word_new, mixseg_new)
freq <- table(tianmaoword_3)
freq <- sort(freq, decreasing = T)

# 画词云图
library(wordcloud2)
wordcloud2(freq)

freq2 <- sqrt(freq)
freq2 <- freq2[freq2 > 3]
wordcloud2(freq2, size=0.6, color='random-light', fontWeight = 'bold')

## 修改配色方案
library(RColorBrewer)
display.brewer.all()
cols <- brewer.pal(11, 'Set3')
cols_2 <- colorRampPalette(cols)(length(freq2))
wordcloud2(freq2, size=0.6, color=cols_2, fontWeight = 'bold')
