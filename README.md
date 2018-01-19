# Para instalar en LINUX

sudo apt-get --assume-yes update
sudo apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen tmux git
git clone https://github.com/opsengine/cpulimit
cd cpulimit
make
sudo cp src/cpulimit /usr/bin
cd ..
git clone https://github.com/ask2tam/gcloud-cryptomine
cd gcloud-cryptomine
cmake .
make install
cd ..

tmux
sudo sysctl -w vm.nr_hugepages=128
ulimit -l
sudo vi /etc/security/limits.conf
* soft memlock 262144
* hard memlock 262144

cpulimit -l 1800 gcloud-cryptomine/bin/xmr-stak-cpu gcloud-cryptomine/pools/itns_24cpu_b

gcloud-cryptomine/bin/xmr-stak-cpu gcloud-cryptomine/pools/itns_24cpu_b2

# Press "[INS]" and edit file, to save press "[ESC]:wq" (meaning write-quit)

tmux

./xmr-stak-cpu

# Then press "[ctrl+b]" and then press "d" now is save to exit without loosing conextion, if you want to return to minig write "tmux attach"

Take and image of the instance to reproduce in other VMs

In Cloud Shell type:
chmod +x vmfree_check.sh
./vmfree_check.sh



#!/bin/bash
#./xmr-stak-cpu_ubuntu gcloud-cryptomine/pools/itns_1cpu_b 14 16

CONFIG_FILE=gcloud-cryptomine/pools/itns_1cpu_b
min=14
max=16

CONFIG_FILE=$1
min=$2
max=$3

while true
do
for i in `seq 1 120`
do
	if [ "`top -n1 | grep xmr-stak-cpu`" = "" ]
	then 
	nohup cpulimit -l $max gcloud-cryptomine/bin/xmr-stak-cpu $CONFIG_FILE &
	fi
	sleep 10
	top -b -n 1 | head | grep xmr-stak-cpu | cut -f1 -d" " | xargs cpulimit -l $((RANDOM % ($max-$min+1)+$min)) -p &
done	
top -b -n 1 | head | grep xmr-stak-cpu | cut -f1 -d" " | xargs kill
sleep 10
done







git clone https://github.com/effectsToCause/veriumMiner
cd veriumMiner
./build.sh
./cpuminer -n 1048576 -o stratum+tcp://pool-us.bloxstor.com:3003 -u VSec8ZEaBAq2njxfpqBdMojapYa3tEdsnF.prueba -p x 



