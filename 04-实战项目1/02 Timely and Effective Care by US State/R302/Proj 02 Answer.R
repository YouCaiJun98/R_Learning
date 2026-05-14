# Step 1 数据理解与清洗
## 读取数据
library(readr)
library(dplyr)
library(tidyverse)

care <- read_csv("./data/care_state.csv")

## 检查数据
head(care)

## 检查数据缺失值
colSums(is.na(care))

## 剔除数据缺失值
care_clean <- care %>%
  filter(!is.na(score))
colSums(is.na(care_clean))


# Step 2 单变量分析
## 对因变量score做可视化
ggplot(care_clean, aes(x = score)) +
  geom_histogram(bins = 40, fill = "steelblue")

## 按照measure_id进行分组后，对因变量score做可视化
ggplot(care_clean, aes(x = score)) +
  geom_histogram(bins = 30, fill = "steelblue") +
  facet_wrap(~measure_id, scales = "free")

## 挑选一个自变量 / 描述性变量进行分析，例如对measure_id进行计数，画出条形图
## 从结果中应该可以看出不同指标的记录完备程度
care_clean %>%
  count(measure_id) %>%
  ggplot(aes(x = reorder(measure_id, n), y = n)) +
  geom_col() +
  coord_flip()

# Step 3 多变量分析
## 3.1 分析不同州 “严重脓毒症 / 感染性休克患者中，接受完整规范救治的比例”
##（对应measure_id 为 SEP_1）
cond <- "SEP_1"

care_filtered <- care_clean %>%
  filter(measure_id == cond)

care_filtered %>%
  ggplot(aes(x = reorder(state, score), y = score)) +
  geom_col(fill = "steelblue") +
  coord_flip()

## 3.2 对某个州做单独分析，可视化这个州内所有脓毒症（对应 condition 为 Sepsis Care）
## 相关的指标。
state_1 <- "IA"
cond <- "Sepsis Care"

care_clean %>%
  filter(state == state_1, condition == cond) %>%
  ggplot(aes(x = reorder(measure_id, score), y = score)) +
  geom_col(fill = "tomato") +
  coord_flip()

## 3.3 对比三个州的脓毒症相关指标
states <- c("IA", "LA", "OK")
cond <- "Sepsis Care"

data_compare <- care_clean %>%
  filter(
    state %in% states,
    condition == cond,
  )

ggplot(data_compare, aes(
  x = reorder(measure_id, score),
  y = score,
  fill = state
)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  coord_flip() +
  scale_fill_manual(
    values = c("IA" = "tomato", "LA" = "steelblue", "OK" = "orange"),
    name = "State"
  ) + 
  labs(
    x = "指标ID",
    y = "Score",
    title = "IA vs LA vs OK 脓毒症治疗指标得分对比"
  ) +
  theme_minimal()

## 3.4 对比某个州和全美平均医疗水平
## 我们在3.1一节发现，PR州的脓毒症治疗水平低得离谱。我们接下来想看一下，这个州
## 它的平均医疗水平和全美医疗水平比起来怎么样。注意，我们要把越高越好的指标
## 和越低越好的指标分开画。
### 先保留独特的measure_id和measure_name
care_clean %>%
  select(measure_id, measure_name) %>%  # 只保留这两列
  distinct() %>%                        # 去重，每个指标只出现一次
  arrange(measure_id) %>%               # 按ID排序，更整齐
  print(n = Inf)                        # 全部打印出来

### 按照越高越好和越低越好的指标进行分组
measure_lower_is_better <- c("OP_18b", "OP_18b_HIGH_MIN", "OP_18b_LOW_MIN", "OP_18b_MEDIUM_MIN", "OP_18b_VERY_HIGH_MIN",
                             "OP_18c", "OP_18c_HIGH_MIN", "OP_18c_LOW_MIN", "OP_18c_MEDIUM_MIN", "OP_18c_VERY_HIGH_MIN",
                             "OP_23")
measure_higher_is_better <- c("HCP_COVID_19", "IMM_3", "OP_22", "OP_29", "OP_31",
                              "SAFE_USE_OF_OPIOIDS", "SEP_1", "SEP_SH_3HR", "SEP_SH_6HR", "SEV_SEP_3HR", "SEV_SEP_6HR")

### 在两张图里分别绘制PR和全美平均水平
plot_data <- care_clean %>%
  filter(state %in% c("PR", state.abb)) %>%  # state.abb 包含所有美国州缩写，不含PR
  group_by(measure_id) %>%
  mutate(
    is_pr = ifelse(state == "PR", "波多黎各（PR）", "全美其他州"),
    score_national = mean(score[state != "PR"], na.rm = TRUE)
  ) %>%
  ungroup() %>%
  filter(state == "PR") %>%
  select(measure_id, score_PR = score, score_national) %>%
  pivot_longer(
    cols = c(score_PR, score_national),
    names_to = "group",
    values_to = "score"
  ) %>%
  mutate(
    group = recode(group, "score_PR" = "波多黎各（PR）", "score_national" = "全美平均"),
    direction = case_when(
      measure_id %in% measure_lower_is_better ~ "越低越好（等待时间）",
      measure_id %in% measure_higher_is_better ~ "越高越好（达标率）"
    )
  ) %>%
  filter(!is.na(direction))

ggplot(plot_data, aes(
  x = reorder(measure_id, score),
  y = score,
  fill = group
)) +
  geom_col(
    position = position_dodge(width = 0.8),
    width = 0.7
  ) +
  coord_flip() +
  facet_wrap(~direction, scales = "free", ncol = 2) +
  scale_fill_manual(
    values = c("波多黎各（PR）" = "tomato", "全美平均" = "steelblue"),
    name = "组别"
  ) +
  labs(
    title = "波多黎各（PR）急诊医疗质量指标 vs 全美平均",
    x = "指标ID",
    y = "得分"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    strip.text = element_text(size = 12, face = "bold")
  )





