# 条形图
barplot(1:5)

x <- table(mtcars$gear)
barplot(x, names.arg = c('齿轮数-3', '齿轮数-4', '齿轮数-5'),
        ylim=c(0,20),) #width=c(1, 2, 3))
## 堆叠条形图
x1 <- table(mtcars[c('vs', 'gear')])
barplot(x1)
barplot(x1, beside=T, col=c('yellow', 'red'),
        legend.text = c('vs-0', 'vs-1'))

## 绘制颜色条形图
red <- grep('red', colors(), value = T, ignore.case = T)
length(red)
barplot(height = rep(1, 27), col=red, names.arg = red, horiz = T,
        las=1, cex.names = 0.5, xaxt='n')

# 饼图
a <- 1:4
pie(a)
names(a) <- LETTERS[1:4]
pie(a)
pie(a, labels = letters[1:4])
pie(a, labels = letters[1:4], clockwise = T) # 顺时针
pie(a, labels = letters[1:4], clockwise = T,
    col=c('red', 'green', 'blue', 'yellow')) # 改变颜色
pie(a, labels = letters[1:4], clockwise = T,
    col=c('red', 'green', 'blue', 'yellow'), border = 'white') # 边框颜色
pie(a, labels = letters[1:4], clockwise = T,
    col=terrain.colors(4), border = 'white') # 调色板颜色
pie(rev(a), labels = rev(letters[1:4]), clockwise = T,
    col=terrain.colors(4), border = 'white') # 改变排布

# 箱线图
r <- rnorm(50, 0, 1)
b <- c(r, 5, 6, -5, -6)
y <- boxplot(b)
y$stats
y$out
## 按照不同类别画箱线图
r2 <- c(rnorm(50, 0, 1), rnorm(50, 10, 1))
r3 <- c(rep(c('class1', 'class2'), times=c(50, 50)))
rand_data <- data.frame(r2, r3)
boxplot(r2 ~ r3, data=rand_data)
