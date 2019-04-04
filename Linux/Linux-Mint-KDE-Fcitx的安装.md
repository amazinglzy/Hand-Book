# Linux Mint KDE Fcitx的安装

1. 先删除ibus
```sh
sudo apt-get remove ibus
```
2. 安装fcitx
```sh
sudo apt-get install qt4-qtconfig
sudo apt-get install fcitx
sudo apt-get install kde-config-fcitx
sudo apt-get install fcitx-frontend-qt4
sudo apt-get install qt4-qtconfig
```
3. 运行qtconfig-qt4，将界面标签页选择fcitx
4. 安装
```sh
sudo apt-get install fcitx-frontend-qt4 fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt5
```
5. 使用im-config来配置系统输入法
