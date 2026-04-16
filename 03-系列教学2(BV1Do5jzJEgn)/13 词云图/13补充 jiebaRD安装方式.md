# jiebaRD本地安装方式

2026/4/16

写在前面： 没想到想用这个包还有点小麻烦，但是问题不大😉

---

* 因为直接用`install_github()`大概率会遇到网络问题，所以我们用本地源文件安装的方式来安装这个`jiebaRD`包！
* （复杂的原因，可以不看😉）但是，这个仓库（jiebaRD / jiebaR）比较老（2019），而且很多文件是在 Windows + 非 UTF-8 （这个编码我们在之前的课程里提到过！）环境生成的，且没有显示声明`Encoding`字段，和新版本的`R`不兼容！
* 所以要做以下修改：
1. 在DESCRIPTION在文件末尾加一行`Encoding: UTF-8`：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260416233633978.png)
2. 随后，将这个文件保存为 UTF-8 编码：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260416233724953.png)
3. 安装这个包！
    ```R
    install_local('./jiebaRD-master/') # 注意路径！现在是把jiebaRD-master放到了R201文件夹下面！
    ```
4. 安装效果展示：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260416233852905.png)
* `jiebaR`的安装方式就很简单啦，我们之前装过`RTools`，所以直接这么安装就好：
    ```R
    install_local('./jiebaR-master/') 
    ```
    安装时会提醒你更新部分包，直接回车就可以！
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260416234039159.png)
    安装后的效果如下：
    ![](https://raw.githubusercontent.com/YouCaiJun98/MyPicBed/main/imgs/20260416234109522.png)