install.packages("devtools")
library("devtools");
# 这个需要下载exe安装
# install.packages("Rtools")
install.packages("bluster")

# 设置本地代理（需要先挂梯子）
## 设置HTTP代理
Sys.setenv(http_proxy = "http://127.0.0.1:7897")
## 设置HTTPS代理
Sys.setenv(https_proxy = "http://127.0.0.1:7897")
library(usethis)


install_github("Danko-Lab/BayesPrism/BayesPrism")

library(BayesPrism)
