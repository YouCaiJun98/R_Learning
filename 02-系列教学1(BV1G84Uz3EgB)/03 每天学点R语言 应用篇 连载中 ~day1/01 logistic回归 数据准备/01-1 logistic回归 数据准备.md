# 01-1 logistic回归 数据准备

2026/4/3

写在前面：暂无。

---

## Rmd介绍
* `Rmd`是一种文件格式，是`R`语言+`Markdown`语法的文件形式（这个文件，"01 logistic回归 数据准备.md"就是个普通`Markdown`文件！），可以把「代码 + 文字 + 图片 + 表格」自动生成报告，导出为 PDF / Word / HTML / PPT形式。
* `Rmd`文件的一个好处是，可以在`R Studio`中运行代码，并得到结果。
* UP主紫薯没有把他的`Rmd`文件放到网盘里，我就照着视频里的部分抄了一些，你可以在`R103`项目下找到它。

## 数据准备
* 因为UP主没有提供数据，也没有交代具体的数据来源，只提到这个数据是公开的乳腺癌数据，我找到了两个最可能的来源：
    * [Breast Cancer (METABRIC, Nature 2012 & Nat Commun 2016)](https://www.cbioportal.org/study/clinicalData?id=brca_metabric&utm_source=chatgpt.com)，我把
        * 原始数据放到了`./R103/data/brca_metabric_clinical_data.tsv`这里，
        * 并且提供了一个数据清洗脚本`./R103/data/clean_metabric_to_csv.R`，
        * 和清洗后的数据`./R103/data/metabric_cleaned_1500.csv`。
    * The Cancer Genome Atlas 的乳腺癌数据（BRCA），它的[下载地址](https://portal.gdc.cancer.gov/projects/TCGA-BRCA?utm_source=chatgpt.com)你可以在markdown文件里找到。但是我下载下来之后发现它和UP主的数据版本出入较大，就没进一步处理，你有需要的话可以看看怎么利用起来。我把它放到了`./R103/data/clinical.project-tcga-brca.2026-04-03.tar.gz"`
* 数据清洗的逻辑是：
    * 保留原文件中和视频里最像的22个原始字段；
    * 把列名统一改成视频里的风格；
    * 把`GRADE`从`1/2/3`改成`I/II/III`；
    * 把`TUMOR_STAGE`粗化成`I-II`、`III-IV`，更像截图里的形式；
    * 把`OS_STATUS`从`"0:LIVING"`/`"1:DECEASED"`改成`0/1`；
    * 新增`TreatmentOutcome = OS_STATUS`；
    * 导出一个1500行版本，尽量贴近UP主视频里的规模。
* 但是，这个1500行版本**不能保证100%和UP主用的对齐**了，但是应该足够接近😉
![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260403223427813.png)

## 数据分析
* 在分析之前，需要对数据进行预处理，将**分类变量转换为factor**，以满足logistic回归的要求。
* 步骤可以分为：数据导入 -> 核心变量选择 -> 分类与连续变量处理 -> 缺失值处理 -> 分组描述


