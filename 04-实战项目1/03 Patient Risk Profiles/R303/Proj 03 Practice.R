library(tidyverse)
library(ggplot2)
library(reshape2)

# 1 数据理解与变量探索
## 数据导入
risk <- read_csv("./data/patient_risk_profiles.csv")

## 数据检查


## 检查缺失值


## 数据探索 1 - 检查 0/1 变量
## 随便挑选一个 0/1 类型的变量（比如Psychotic disorder in prior year），统计 0/1出现的次数


## 数据探索 2 - 检查人口学变量是否合理
## 对每一个样本都统计不同年龄段、性别变量（分组）下出现“1”的次数，确保它是一个独热向量


## 数据探索 3 - 探索既往疾病与用药特征
## 随便挑选若干既往疾病与用药特征变量，统计它们出现的均值


## 数据探索 4 - 探索预测风险变量
## 探索predicted risk of Dementia变量的分布，查看均值、查看最大值/最小值，
## 并绘制 histogram。


# 2 多变量 EDA 与风险画像
## 年龄组与风险模式
## 请比较不同年龄组的 dementia risk


## 单因素风险探索
## 请比较Non-hemorrhagic Stroke in an inpatient setting in prior year、
## Occurrence of neuropathy in prior year、
## Sleep apnea in prior year、
## Major depressive disorder, with NO occurrence of certain psychiatric disorder in prior year
## 与 dementia risk 的关系，并绘制小提琴图。


# 3 构造 Outcome 与 Logistic Regression 入门
## 构造binary outcome
## 将predicted risk of Dementia排名前 10% 的样本定义为high_dementia_risk = 1，
## 其余定义为high_dementia_risk = 0。


## 构造单因素 Logistic Regression
## 请分析Non-hemorrhagic Stroke in an inpatient setting in prior year是否与
## high_dementia_risk有关



# 4 单因素 Logistic Regression
## 分析coefficient


## 分析 OR 值与 p-value


## 分析CI


# 5 多因素 Logistic Regression
## 构造多因素 Logistic Regression
## 在之前的单因素模型中加入age group:  80 -  84和Sleep apnea in prior year，
## 判断 age 是否可能是 confounder，观察adjustment 后 OR 是否变化。


## 模型预测
## 请预测一个有 stroke 历史、属于 80-84 岁、有 sleep apnea 的新患者，
## 其 high dementia risk 概率


