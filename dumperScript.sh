#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#mydate=$(date)
echo "Dumper Script"
passedStartTime=$1
echo "fileName is "
fileName=$2
echo $passedStartTime
echo $fileName
passedEndTime=$(($1+600))
echo $passedStartTime
echo $passedEndTime
sleep 2m
#mydate=$(echo $mydate | sed s/./0/15)
#mydate=$(echo $mydate | sed s/./0/16)
#mydate=$(echo $mydate | sed s/./0/18)
#mydate=$(echo $mydate | sed s/./0/19)
#echo $mydate

#thisHour=$(date -d "${mydate}" +"%s")
#previousHour=$((thisHour-3600))

#echo $thisHour
#echo $previousHour
#today=`date +%Y-%m-%d.%H:%M:%S`

IFS=

echo "scan 'live_upd_format_1',{STARTROW=>\"$passedStartTime\", ENDROW=>\"$passedEndTime\"}" | mvn clean package exec:java -Dbigtable.projectID="platform-dev-blp" -Dbigtable.instanceID="blp-dev-bt" >> /home/krishnas_thali/backup/quickstart/thali.csv
echo "File appended$fileName.csv"

