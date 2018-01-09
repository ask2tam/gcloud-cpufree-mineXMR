#!/bin/bash

rm -f replist
gcloud projects list | awk '{ print $1 }' | tail -n +2 | while read project; do
gcloud compute instances list --project $project | awk -v txt=$project '{ print txt, $1, $2 }' | tail -n +2 >> replist
done

rm -f reporte_vm_micro.txt
cat replist | while read PROJECT INSTANCE ZONE
do {
  echo Checking $INSTANCE
    for tt in `seq 1 5`
	  do
	  [ "`gcloud compute --project $PROJECT ssh --zone $ZONE $INSTANCE --command "echo ok && exit"`" = "ok" ] && break
	  echo "Waiting for server startup script to finish"
	  sleep 2
	  done
  rm -f tmp
  gcloud compute scp --project $PROJECT --zone $ZONE $INSTANCE:~/reportme tmp
  cat tmp | grep Totals: | awk '{ print $3 }' | while read hs; do
  echo $INSTANCE $PROJECT $ZONE $hs
  done >> reporte_vm_micro.txt
} < /dev/null; done

exit
