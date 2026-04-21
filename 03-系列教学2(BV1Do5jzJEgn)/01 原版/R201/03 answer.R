# 1、将1,2,3，...,12构成两个3*4的矩阵，矩阵A是按列输入，矩阵B是按行输入。
A <- matrix(1:12, nrow=3, ncol=4, byrow=FALSE)
B <- matrix(1:12, nrow=3, ncol=4, byrow=TRUE)

# 2、将矩阵B的第一列的元素都改成100.
B[,1] <- 100

# 3、创建数据框将它命名成wtdata，要求第一、三列的数据类型是数值型的，第二列数据类型是字符型的
wtdata <- data.frame(
  col1 = c(1,2,3),         # 第1列：数值型
  col2 = c("a","b","c"),   # 第2列：字符型
  col3 = c(4,5,6)          # 第3列：数值型
)

# 4、返回数据框wtdata第一、三行的信息
wtdata[c(1,3), ]

# 5、创建一个列表，将它命名成wtlist，列表的长度是3，
# 列表的第1个元素是矩阵A，
# 列表的第2个元素是矩阵B，
# 列表的第3个元素是wtdata
wtlist <- list(
  A,        # 第1个元素：矩阵A
  B,        # 第2个元素：矩阵B
  wtdata    # 第3个元素：数据框wtdata
)

# 6、返回列表wtlist第1个元素的信息。
wtlist[[1]]
