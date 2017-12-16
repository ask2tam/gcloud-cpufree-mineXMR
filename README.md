# Para instalar en LINUX

sudo apt-get --assume-yes update

sudo apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen tmux git

git clone https://github.com/ask2tam/gcloud-cpufree-mineXMR.git

cd gcloud-cpufree-mineXMR

cmake .

make install

cd bin

vi config.txt

# Press "[INS]" and edit file, to save press "[ESC]:wq" (meaning write-quit)

cd gcloud-cpufree-mineXMR/bin

tmux

./xmr-stak-cpu

# Then press "[ctrl+b]" and then press "d" now is save to exit without loosing conextion, if you want to return to minig write "tmux attach"


Create new instance 
cd gcloud-cpufree-mineXMR/bin
tmux
./xmr-stak-cpu

#!/bin/bash

PROJECT="mmgr-geocoder-proyect"
ZONE="us-central1-c"
CLIENT_SNAPSHOT="cpufree-xmr"
MTYPE="f1-micro"
DISK_SIZE="10"
NUM=32

for i in `seq 1 $NUM`
do
  INSTANCE="Ensayo_a-$i"
  echo Creating $INSTANCE
  gcloud compute --project $PROJECT disks create ${INSTANCE} --size $DISK_SIZE --zone $ZONE --source-snapshot $CLIENT_SNAPSHOT --type "pd-standard"
  
  gcloud beta compute --project $PROJECT instances create $INSTANCE --zone $ZONE --machine-type $MTYPE --subnet "default" --maintenance-policy "MIGRATE" --service-account "182484721108-compute@developer.gserviceaccount.com" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --min-cpu-platform "Automatic" --disk "name=${INSTANCE}-boot" "device-name=${INSTANCE}-boot" "mode=rw" "boot=yes" "auto-delete=yes"
done

gcloud beta compute --project "mmgr-geocoder-proyect" instances create "instance-3" --zone "us-central1-c" --machine-type "f1-micro" --subnet "default" --maintenance-policy "MIGRATE" --no-service-account --no-scopes --min-cpu-platform "Automatic" --image "debian-9-stretch-v20171213" --image-project "debian-cloud" --boot-disk-size "10" --boot-disk-type "pd-standard" --boot-disk-device-name "instance-3"


