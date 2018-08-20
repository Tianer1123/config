yum install ncurses-devel
wget https://github.com/vim/vim/archive/master.zip
unzip master.zip
cd vim-master
cd src/
./configure --with-features=huge -enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config
sudo make
sudo make install
export PATH=/usr/local/bin:$PATH
