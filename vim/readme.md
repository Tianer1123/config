# 1. VIM配置PYTHON开发环境

## 安装vim8(支持python)

``` sh
# 卸载自带vim
rpm -qa|grep vim
rpm -e {vim-minimal-7.4.160-1.el7.x86_64, vim-common-7.4.160-4.el7.x86_64, vim-enhanced-7.4.160-4.el7.x86_64, vim-filesystem-7.4.160-4.el7.x86_64}
yum install ncurses-devel
wget https://github.com/vim/vim/archive/master.zip
unzip master.zip
cd vim-master
cd src/
#./configure --with-features=huge -enable-pythoninterp --enable-python3interp --with-python-config-dir=/u/usr/lib64/python2.7/config/ -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/sudo make
# 只能支持一个python版本，不能同时支持
./configure --with-features=huge --enable-python3interp -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/

sudo make
sudo make install
echo "export PATH=/usr/local/bin:$PATH" >> ~/.bashrc
```

## .VIMRC配置
[vimrc_python](https://github.com/Tianer1123/config/blob/master/vim/vim_python.vim)
