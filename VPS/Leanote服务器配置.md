# Leanote 服务器配置
[Leanote 教程集](http://leanote.leanote.com/post/Leanote-manual-project)
## Leanote 部署到服务器
### 1. 下载二进制包
前往[Leanote 开源官网](http://leanote.org/)下载二进制文件

```sh
#解压
cd ~/software
tar -xzvf leanote-linux-amd64-v1.3.1.bin.tar.gz
```

### 2. mongodb
安装mongodb

```sh
sudo apt-get install mongodb
```

简单使用mongodb

```sh
mkdir ~/.../data
#开启mongodb
mongod --dbpath ~/.../data
```

导入初始数据

```sh
mongorestore -h localhost -d leanote --dir ~/leanote/mongodb_backup/leanote_install_data/
```

### 3. 配置
修改conf/app.conf
运行leanote

```sh
bash ~/leanote/bin/run.sh
# vps端可以用
screen ~/leanote/bin.run.sh
# 然后用<C-a> + d保存screen 然后执行其他应用
```

现在就已经可以从网页上打开并使用了，不过不能导出为pdf，原因是没有安装相应的软件。
安装wkhtml(不能直接用apt安装，会有问题)
[wkhtml官网-下载地址](http://wkhtmltopdf.org/downloads.html)
解压安装包

```sh
tar -vxf *(下载的安装包)
```

记录wkhtmltopdf的位值，并用admin进入你搭好的leanote里，找到管理后台配置wkhtmltopdf路径
如果导出的pdf文档存在空白或者方框，是因为缺少中文字体的原因，只用安装中文字体就可以解决（可见Ubuntu Markings）

## Leanote 遇到的问题
**使用Evolution initial theme 代码格式混乱，具体是每行最前的空白符显示不出来。**
Edit主题文件，打开style.css方件(不排除名字不同)，该文件是用于描述博客文章的格式的样式文件。
找到描述pre或code的内容，找到
```css
pre code {
  white-space: nowrap;
}
```
将其注释掉就好了。

**显示博客文章的块级元素太窄，发现其是随着博客内容变化的，比如随着标题变长而变长**
发现，对于html块级元素，如果设置了float的属性，就要设置最小的宽度，否则它会尽可能的窄

```
min-width: 70%;
```

# How to Install Leanote Server on Ubuntu 17.04

This guide focused on how to install leanote server on Ubuntu 17.04.

Leanote is cross-platform notebook web application. You can access it's service established by ourselves through web or client on windows, android or ios after we installed the leanote server on our own VPS. It provide markdown editors with three kinds of writing mode including rich text, vim and emacs. We can publish our note as a blog easily.

##  Install Leanote Server

### Step 1: Download the binary file of Leanote

Download the file through [here](http://leanote.org/) or using:

```sh
wget -O leanote.tar.gz https://sourceforge.net/projects/leanote-bin/files/2.5/leanote-linux-amd64-v2.5.bin.tar.gz/download
```

Extract the file to the directory you want to place like:

```sh
tar -xzvf leanote.tar.gz
```

### Step 2: Install mongodb

You need to install mongodb which is the database of Leanote.

```sh
apt-get install mongodb mongo-tools
```

You can configure mongodb like like this or more:

```sh
mkdir data
mongod --dbpath data
```

### Step 3: Import initial Leanote data


  mongorestore -h localhost -d leanote --dir ./leanote/mongodb_backup/leanote_install_data/


## Step 4: Configure Leanote

You can edit the file:


  ./leanote/conf/app.conf


to configure Leanote.

You can choose to set the port 80 for Leanote as 80 is the default port for a web site.


  http.port=80

  site.url=http://localhost # or http://x.com:8080, http://www.xx.com:9000


### Step 5: Run Leanote

You can choose `screen` to run leanote conveniently


  screen sh ./leanote/bin/run.sh
  # Press <C-a> + d to return to shell to do other work leaving leanote running backgound

> **Attention!!!!!**
>
> Please note that you run `Mongodb` with no `auth` option which mentioned in this paper, if your server is exposed to the internet, anyone can access and modify and delete it!!!!!! So it's very dangerous to run `Mongodb` in this way. You must add user and password to `Mongodb` and run it with `auth` option.

## Install Wkhtml

If you need to export the note as a pdf file, you should need to install wkhtml for leanote.

### Step 1: Download the binary file

You can download it from [here](https://wkhtmltopdf.org/downloads.html) or like this:

```sh
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
```

Extract the file to the directory you want to place like:
```sh
tar -vxf ./wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
```

### Step 2: Configure Leanote for wkhtml

You should sign in the website of leanote by user admin, find Export PDF in the Configureation from admin page to apply the address of wkhtml you installed.
