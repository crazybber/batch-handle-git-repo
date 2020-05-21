#!/bin/bash

errout=">> syncLog.txt 2>&1"
echo ------------------------------------
#echo "errout: ${errout}"

index_count=0

time=$(date "+%Y-%m-%d %H:%M:%S")

## file name to remove
filename= 

echo "###########${time} Begin Del ${filename}"

function start_clean_all_nul(){
for dir in $(ls -d *)
do
  if [ -f "$dir"/"${filename}" ]; then
	cd $dir
	echo "${time} Change to: ${PWD}"
    echo "${time} Begin to del nul: ${dir}"
	rm nul
	let index_count+=1
	echo "${time} End in : ${dir}"
    cd ..
	echo "${time} Return to: ${PWD}"
 
  fi
done

echo "###########Dir Count : deleted: ${index_count}."
}

start_clean_all_nul

time=$(date "+%Y-%m-%d %H:%M:%S")	
echo "###########${time} End "


read -n1 -p "Press any key to continue..."
