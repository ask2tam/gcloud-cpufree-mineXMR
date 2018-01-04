#!/bin/bash
#gcloud-cryptomine/start.sh gcloud-cryptomine/pools/itns_1cpu_b 14 16
#gcloud-cryptomine/start.sh gcloud-cryptomine/pools/itns_8cpu_b 560 640

CONFIG_FILE=$1
min=$2
max=$3

sudo sysctl -w vm.nr_hugepages=128

while true
do
for i in `seq 1 30`
do
	if [ "` top -b -n 1 | grep xmr-stak-cpu | awk '{ print $1 }' `" = "" ]
	then 
	nohup cpulimit -l $max gcloud-cryptomine/bin/xmr-stak-cpu $CONFIG_FILE &
	fi
	sleep 30
	top -b -n 1 | grep xmr-stak-cpu | awk '{ print $1 }' | while read pid
	do
	cpulimit -l $((RANDOM % ($max-$min+1)+$min)) -p $pid &
	done
done	
top -b -n 1 | grep xmr-stak-cpu | awk '{ print $1 }' | xargs kill
sleep 30
done
