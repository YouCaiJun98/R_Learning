# 数据导入
library(tidyverse)
library(rms)
library(pROC)
data = read.csv("./data/metabric_cleaned_1500.csv")

# 核心变量选择 & 分类与连续变量处理
data_analysis <- data %>% select(PATIENT_ID, TreatmentOutcome, AGE_AT_DIAGNOSIS,
                                 LATERALITY, ER_STATUS, HER2_STATUS, TUMOR_STAGE) %>% 
  mutate(TreatmentOutcome = factor(TreatmentOutcome),
         LATERALITY = factor(LATERALITY),
         ER_STATUS = factor(ER_STATUS),
         HER2_STATUS = factor(HER2_STATUS),
         TUMOR_STAGE = factor(TUMOR_STAGE))

# 数据清理 - 删除含有NA的行
data_analysis <- data_analysis %>% drop_na(LATERALITY, HER2_STATUS, TUMOR_STAGE)

# 只保留建模需要的变量
data_nom <- data_analysis %>%
  select(
    TreatmentOutcome,
    AGE_AT_DIAGNOSIS,
    ER_STATUS,
    HER2_STATUS,
    TUMOR_STAGE
  ) %>%
  drop_na()  # 显式去除缺失

# 拟合logistic模型（rms::lrm）
dd <- datadist(data_nom)
options(datadist = "dd")

fit_lrm <- lrm(
  TreatmentOutcome ~ AGE_AT_DIAGNOSIS + ER_STATUS + HER2_STATUS + TUMOR_STAGE,
  data = data_nom,
  x = TRUE, y = TRUE
)

# 预测概率
dat_nom$pred_prob <- predict(fit_lrm, type = "fitted") # 概率

# ROC对象
roc_train <- roc(
  response = data_nom$TreatmentOutcome,  # 0/1
  predictor = data_nom$pred_prob,
  ci = TRUE,                # AUC置信区间
  direction = "<"           # 概率越大越倾向于1
)

# 输出AUC及95%CI
auc_val <- auc(roc_train)
auc_ci <- ci.auc(roc_train)

cat("Training AUC =", round(as.numeric(auc_val), 3), "\n")
cat("95% CI =", paste(round(as.numeric(auc_ci), 3), collapse = "-"), "\n")

# 绘图
fpr <- 1 - roc_train$specificities
tpr <- roc_train$sensitivities

plot(
  fpr, tpr,
  type = "l",
  lwd = 3,
  col = "#2C7FB8",
  xlim = c(0, 1),
  ylim = c(0, 1),
  xaxs = "i",
  yaxs = "i",
  xlab = "False Positive Rate (1 - Specificity)",
  ylab = "True Positive Rate (Sensitivity)",
  main = "ROC Curve (Training Set)"
)
abline(a = 0, b = 1, lty = 2, col = "gray50")

# 可选：最佳截断点（Youden index）
best_cut <- coords(
  roc_train, x = "best", best.method = "youden",
  ret = c("threshold", "sensitivity", "specificity")
)
print(best_cut)
