# 1、把数据集tianmaoTV.xlsx导入，把生成的数据框命名成tianmao
library(readxl)
library(jiebaR)
tianmao <- read_excel('./data/tianmaoTV.xlsx', skip=1)

# 2、把tianmao数据集内变量description里的数字删除掉。
description <- gsub('\\d', '', tianmao$description)

# 3、将“大内存”，“全面屏”这两个词加入到用户字典里。
# 把tianmao数据集的变量description进行分词。
# 把分词结果保存在变量descword里
edit_dict()
mixseg <- worker()
descword <- segment(description, mixseg)

# 4、查看分词结果中是否有“大内存”，“全面屏” 这两个词汇
# 这里没有是因为前面有G!
'大内存' %in% descword
'全面屏' %in% descword

# 5、统计分词结果descword的词频，将结果保存到变量descfreq
descfreq <- table(descword)

# 6、画出descfreq的词云图
library(wordcloud2)
wordcloud2(descfreq)
