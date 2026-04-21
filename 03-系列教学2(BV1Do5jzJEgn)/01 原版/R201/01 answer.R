# 1、填空题：一般 R 在等待输入命令时，在控制台一行的开始会显示一个符号（>）
# 这是 R 在提示你输入命令，因此他被称为提示符。
# 2、填空题：使用（Tab）键可以得到某个函数或文件名可能的补全列表。
# 3、判断题：给对象命名时，对象的名字能以数字开头。（×）
# 4、操作题：将 2 赋值给对象 x，在这行代码后面加上注释，“x 是 2”。
# 5、下载包 colorspace
# 6、加载 colorspace ，运行以下代码，看一下输出效果。hcl_palettes(plot = TRUE)

# 4. 操作题
x <- 2 # x 是 2

# 5. 下载包
install.packages("colorspace")

# 6
library(colorspace)
hcl_palettes(plot = TRUE)