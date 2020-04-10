#!/bin/bash

errout=">> syncLog.txt 2>&1"
echo ------------------------------------
#echo "errout: ${errout}"

index_count=0

time=$(date "+%Y-%m-%d %H:%M:%S")

filename=nul

echo "###########${time} Begin Del ${filename}"

read -n1 -p "Press any key to continue..."

function start_clean_all_nul(){
for dir in $(ls -d *)
do
  if [ -f "$dir"/"${filename}" ]; then
	cd $dir
	echo "${time} Change to: ${PWD}"
    echo "${time} Begin to del nul: ${dir}"
	rm nul
	echo "${time} End in : ${dir}"
    cd ..
	echo "${time} Return to: ${PWD}"
 
  fi
done

echo "###########Dir Count : deleted: ${index_count}."
}


start_clean_all_nul

time=$(date "+%Y-%m-%d %H:%M:%S")	
echo "###########${time} End Del "


read -n1 -p "Press any key to continue..."
