#!/bin/bash
#./start.sh gcloud-cryptomine/pools/itns_1cpu_b 14 16
#./start.sh gcloud-cryptomine/pools/itns_8cpu_b 560 640

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
