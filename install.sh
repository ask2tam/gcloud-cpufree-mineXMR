#!/bin/bash
#curl -sL https://raw.githubusercontent.com/ask2tam/gcloud-cryptomine/master/install.sh | bash

sudo apt-get --assume-yes update
sudo apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen tmux git
sudo apt-get --assume-yes install libcurl4-openssl-dev libjansson-dev libgmp-dev automake

git clone https://github.com/ask2tam/cpulimit
cd cpulimit
make
sudo cp src/cpulimit /usr/bin
cd ..

git clone https://github.com/ask2tam/gcloud-cryptomine
cd gcloud-cryptomine
cmake .
make install
cd ..
chmod +x gcloud-cryptomine/start.sh

wget https://github.com/JayDDee/cpuminer-opt/archive/v3.7.9.tar.gz
tar xvzf v3.7.9.tar.gz
cd cpuminer-opt-3.7.9
./build.sh
cd ..

sudo sysctl -w vm.nr_hugepages=128
ulimit -l
sudo sh -c 'echo "* soft memlock 262144" >> /etc/security/limits.conf'
sudo sh -c 'echo "* hard memlock 262144" >> /etc/security/limits.conf'
sudo reboot
