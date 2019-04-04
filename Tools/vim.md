参考博客[1](https://segmentfault.com/a/1190000003962806), [2](http://blog.csdn.net/jeff_liu_sky_/article/details/53955888)

## 安装 spacevim
**Linux**
```sh
curl -sLf https://spacevim.org/install.sh | bash
```
**windows**
```
https://spacevim.org/install.cmd
```

## 安装 apt-vim
```sh
curl -sL https://raw.githubusercontent.com/egalpin/apt-vim/master/install.sh | sh
```

## 安装 Vundle
```sh
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## 配置目录 NERDTree
```sh
apt-vim install -y https://github.com/scrooloose/nerdtree.git
```

## 使用 ctags

在需要搜索的目录运行
```sh
ctags -R *
```

然后在 `.vimrc` 目录下添加
```sh
set tags+=xxx
```
## Python 补全
```sh
#shell-python
wget https://github.com/rkulla/pydiction/archive/master.zip
unzip -q master
mv pydiction-master pydiction
mkdir -p ~/.vim/tools/pydiction
cp -r pydiction/after ~/.vim
cp pydiction/complete-dict ~/.vim/tools/pydiction
```
```sh
#.vimrc-python
filetype plugin on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
```

## Problems
1. 打开 gb2312 文件乱码

    ```sh
    :edit ++enc=gb18030
    ```