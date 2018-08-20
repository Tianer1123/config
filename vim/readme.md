# 1. VIM配置PYTHON开发环境

## 安装vim8(支持python)

``` bash
# 卸载自带vim
1. rpm -qa|grep vim
2. rpm -e {vim-minimal-7.4.160-1.el7.x86_64, vim-common-7.4.160-4.el7.x86_64, vim-enhanced-7.4.160-4.el7.x86_64, vim-filesystem-7.4.160-4.el7.x86_64}
3. yum install ncurses-devel
4. wget https://github.com/vim/vim/archive/master.zip
5. unzip master.zip
6. cd vim-master
7. cd src/
#./configure --with-features=huge -enable-pythoninterp --enable-python3interp --with-python-config-dir=/u/usr/lib64/python2.7/config/ -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/sudo make
# 只能支持一个python版本，不能同时支持
8. ./configure --with-features=huge --enable-python3interp -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/

9. sudo make
10. sudo make install
11. echo "export PATH=/usr/local/bin:$PATH" >> ~/.bashrc
```
