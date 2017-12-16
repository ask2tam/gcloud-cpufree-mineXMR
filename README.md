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

tmux

./xmr-stak-cpu

# Then press "[ctrl+b]" and then press "d" now is save to exit without loosing conextion, if you want to return to minig write "tmux attach"

Take and image of the instance to reproduce in other VMs

In Cloud Shell type:

PROJECT="mmgr-geocoder-proyect"
ZONE="us-central1-c"
CLIENT_SNAPSHOT="cpufree-xmr"
MTYPE="f1-micro"
DISK_SIZE="2"
NUM=10

for i in `seq 1 $NUM`
do
  INSTANCE="Ensayo_a-$i"
  echo Creating $INSTANCE
  
  gcloud compute --project $PROJECT disks create ${INSTANCE} --size $DISK_SIZE --zone $ZONE --source-snapshot $CLIENT_SNAPSHOT --type "pd-standard"
  
  gcloud beta compute --project $PROJECT instances create $INSTANCE --zone $ZONE --machine-type $MTYPE --subnet "default" --metadata "startup-script=#! /bin/bash\u000acd gcloud-cpufree-mineXMR/bin\u000a./xmr-stak-cpu" --maintenance-policy "MIGRATE" --no-service-account --no-scopes --min-cpu-platform "Automatic" --disk "name=${INSTANCE}-boot" "device-name=${INSTANCE}-boot" "mode=rw" "boot=yes" "auto-delete=yes"
done

