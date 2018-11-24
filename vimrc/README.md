**centOS下安装vim8**

# 1. Python3,pip3安装
## Python3

``` sh
yum -y install epel-release
yum -y install python36 python36-devel
```

## pip3
``` sh
yum -y install python36-setuptools
easy_install pip
```
另一种方式
``` sh
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python3 get-pip.py
```

# 2. VIM配置PYTHON开发环境

## 安装vim8(支持python)

``` sh
# 卸载自带vim
rpm -qa|grep vim
rpm -e {vim-minimal-7.4.160-1.el7.x86_64, vim-common-7.4.160-4.el7.x86_64, vim-enhanced-7.4.160-4.el7.x86_64, vim-filesystem-7.4.160-4.el7.x86_64}
yum install ncurses-devel
wget https://github.com/vim/vim/archive/master.zip

yum -y install lua lua-devel


unzip master.zip
cd vim-master
cd src/
#./configure --with-features=huge -enable-pythoninterp --enable-python3interp --with-python-config-dir=/u/usr/lib64/python2.7/config/ -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/sudo make
# --enable-python3interp -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/
# 只能支持一个python版本，不能同时支持
./configure --with-features=huge \
        --enable-rubyinterp \
        --enable-luainterp \
        --enable-python3interp=yes \
        --enable-pythoninterp=yes

sudo make
sudo make install
echo "export PATH=/usr/local/bin:$PATH" >> ~/.bashrc

# python补全
pip3 install jedi
# python语法检查
pip3 install flake8
# pip3 install pylint 语法检查过于严苛
```

## 安装tags

``` sh
yum -y install ctags cscope
```

## .VIMRC配置

本配置使用的插件管理器是 [vim-plug](https://github.com/junegunn/vim-plug)。需要事先安装 `vim-plug` ，具体看官网介绍。

编辑vimrc配置文件并输入[.vimrc](https://github.com/Tianer1123/config/blob/master/vimrc/.vimrc)文件中的内容。
``` sh
vim ~/.vimrc
```

## 安装插件
进入`vim`执行
``` vim
:PluginInstall
```
