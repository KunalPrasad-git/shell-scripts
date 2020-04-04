#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
mydate=$(date)
echo $mydate
thisHourCopyInEpoch=$(date -d "${mydate}" +"%s")
echo $thisHourCopyInEpoch
echo "jfdksvldslfv"
mydate=$(echo $mydate | sed s/./0/15)
mydate=$(echo $mydate | sed s/./0/16)
mydate=$(echo $mydate | sed s/./0/18)
mydate=$(echo $mydate | sed s/./0/19)
echo $mydate
echo "kunal"
thisHourInEpoch=$(date -d "${mydate}" +"%s")
echo $thisHourInEpoch
nextCallTime=$((thisHourInEpoch+3600))
echo $nextCallTime
waitTime=`expr $nextCallTime - $thisHourCopyInEpoch`
echo "wait time is :"
echo $waitTime
while true;
	do
	nohup bash /home/krishnas_thali/backup/quickstart/mainScript.sh "$thisHourInEpoch" &
	thisHourInEpoch=$((thisHourInEpoch+3600))
	#sleep $waitTime
	sleep 3600
	done
