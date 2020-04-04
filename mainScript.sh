#!/bin/bash

zero=0
echo "Main Script"

thisHour=$1
previousHour=$((thisHour-1800))
write=$previousHour
echo $previousHour
passthisHour=
	while [ $previousHour -lt $thisHour ]
	do
		# passthisHour=$((prevoiusHour+600))
		 echo "calling another script"
		 nohup bash /home/krishnas_thali/backup/quickstart/dumperScript.sh "$previousHour" "$thisHour"
		 previousHour=$((previousHour+600))
		 #echo $previousHour
		 sleep 10
	 done
	 echo "End of loop"
	 count=$(ps -ef | grep dumperScript | grep -v grep | wc -l)
	 echo $count

	 while [ $count -gt $zero ]
	 	do
		 count=$(ps -ef | grep dumperScript | grep -v grep | wc -l)
		 echo $count
		 sleep 3
		done
		echo "********************going to grep***************************"

today=`date +%Y-%m-%d.%H:%M:%S`
while read siteFileName
do
 site=`echo $siteFileName | sed 's/\\r//g'`
 declare -a siteArray
 declare -a assetArray
 declare -a tagArray
 #unset siteArray
 #unset assetArray
 #unset tagArray
 IFS=","
 while read f1 f2 f3
      do
       siteArray+=($f1)
       assetArray+=($f2)
       tagArray+=($f3)
       done < $site
						  
       echo "fileReading is done"
       IFS=
			     
       filteredSite=
       filteredAsset=	
       filetredTag=
       tag=

       for site in "${siteArray[@]}"
	   do
	    filteredSite="${site// /}"
	    grepSite="#$filteredSite#"
	    fileName=${site}_${write}_${thisHour}
	    echo "TIMESTAMP,SITE,ASSET,TAG,COUNT">>/home/krishnas_thali/backup/quickstart/$fileName.csv
					         
	    for asset in "${assetArray[@]}"
	        do 
	         filteredAsset="${asset// /}"
		 grepAsset="#$filteredAsset#"
	         for tag in "${tagArray[@]}"
	             do
	             filteredTag=`echo $tag | sed 's/\\r//g'`
		     grepTag=":$filteredTag,"
		     echo $grepSite
		     echo $grepAsset
		     echo $grepTag
 # countResult="$(grep -F "#${filteredSite}#" /home/krishnas_thali/backup/quickstart/thali.csv | grep "#${filteredAsset}#" | grep -F ":${filteredTag}," | wc -l)"

 countResult="$(grep $grepSite /home/krishnas_thali/backup/quickstart/thali.csv | grep $grepAsset | grep $grepTag | wc -l)"
 	 	     finalvalue="$today,$site,$asset,$tag,$countResult"
		     #"$today,$site,$asset,$tag,$countResult"
                      echo "${finalvalue}" >> /home/krishnas_thali/backup/quickstart/$fileName.csv
		       #unset countResult
		      #unset grepTag
		      #unset filteredTag
		      #unset finalvalue
                     done
		     #unset grepAsset
		    #unset filteredAsset
	         done
		 #unset grepSite
		 #unset filteredSite
		 sleep 10
	     done
	echo "******************************"
  gsutil cp /home/krishnas_thali/backup/quickstart/$fileName.csv gs://platform-dev-blp-archive-rowcount
  rm -rf /home/krishnas_thali/backup/quickstart/$fileName.csv

  unset siteArray[@]
  unset assetArray[@]
  unset tagArray[@] 
  #unset site
done < /home/krishnas_thali/backup/quickstart/allFileNames.csv
rm -rf /home/krishnas_thali/backup/quickstart/thali.csv
