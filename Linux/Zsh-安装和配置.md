#Zsh安装和配置
安装Zsh

    sudo apt-get install zsh

安装oh-my-zsh

```sh
#通过curl安装
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
#通过wget安装
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
```

选择主题

```sh
#打开配置文件
vim ~/.zshrc\
#修改主题
  ZSH_THEME="avit"
```

可以在[这里](https://github.com/robbyrussell/oh-my-zsh/wiki/themes)查看主题预览
