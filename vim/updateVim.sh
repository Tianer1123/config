# 卸载自带vim
rpm -qa|grep vim

rpm -e {
vim-minimal-7.4.160-1.el7.x86_64
vim-common-7.4.160-4.el7.x86_64
vim-enhanced-7.4.160-4.el7.x86_64
vim-filesystem-7.4.160-4.el7.x86_64
}

yum install ncurses-devel
wget https://github.com/vim/vim/archive/master.zip
unzip master.zip
cd vim-master
cd src/
./configure --with-features=huge -enable-pythoninterp --enable-python3interp --with-python-config-dir=/u/usr/lib64/python2.7/config/ -with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/sudo make
sudo make install
export PATH=/usr/local/bin:$PATH
