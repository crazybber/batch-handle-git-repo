#!/bin/bash

code_repo_list=(
'abc'
'123'
)

index_count=0

time=$(date "+%Y-%m-%d %H:%M:%S")

echo "###########${time} Begin Sync Code"

###pull & push One repo
function pull_push_repo(){

current_branch_name=$(git symbolic-ref --short -q HEAD)
remote_source_repo_branch='develop'
echo "###Repo ${1} :current branch is [${current_branch_name}]###"
#echo "###Repo ${1} :current branch is [${current_branch_name}]###" >> ../syncLog.txt 2>&1
git reset --hard >> ../errorLog.txt 2>&1	
if [ $current_branch_name != develop ];then
	echo "###Repo ${1} : will check branch [develop]###"
#echo "###Repo ${1} :checkout branch [develop]###" >> ../syncLog.txt 2>&1
#it checkout develop >> ../syncLog.txt 2>&1
#develop branch first
	remote_source_repo_branch=$(git branch | grep -i -E 'develop' | sed 's/* //g')
	if [ -n "$remote_source_repo_branch" ];then
		echo "branch develop found: ${remote_source_repo_branch}"
		git checkout develop
	else
	#point to current
	remote_source_repo_branch="master"
	echo "###Repo ${1} : no [develop] found, will handle [${remote_source_repo_branch}]###"
	fi	
fi

echo "###Repo ${1} :start to pull [${remote_source_repo_branch}] from remote[origin]###"
#echo "###Repo ${1} :start to pull ${remote_source_repo_branch} from remote[origin]###" >> ../syncLog.txt 2>&1

#git fetch origin >> ../syncLog.txt 2>&1
#git fetch origin
#git pull origin develop >> ../syncLog.txt 2>&1
git pull origin ${remote_source_repo_branch}
#	git merge origin/develop >> ../syncLog.txt 2>&1
remote_target_repo=$(git remote | grep -i -E "osc|gitee")


echo "###Repo ${1} :start sync to remote [${remote_target_repo}]###"
#echo "###Repo ${1} :start sync to remote [${remote_target_repo}]###" >> ../syncLog.txt 2>&1	

#git push $remote_target_repo ${remote_source_repo_branch} ../syncLog.txt 2>&1
git push $remote_target_repo ${remote_source_repo_branch} --force-with-lease --recurse-submodules=check

let index_count+=1
}

###main loop start to sync all code repo
function start_to_sync_repos_from_config(){

echo "###########Repo Count : ${#code_repo_list[@]} in Total"

for repodir in ${code_repo_list[@]}
do
if [ -d "$repodir"/.git ]; then
    cd $repodir
	echo "${time} Change to: ${PWD}"
    echo "${time} Begin Pull Code For Repo: ${repodir}"
	pull_push_repo $repodir
	echo "${time} End Sync Code in Repo: ${repodir}"
    cd ..
	echo "${time} Return to: ${PWD}"
fi
done

echo "###########Repo Count : ${#code_repo_list[@]}, synced: ${index_count}."

}

function start_to_sync_repos_in_dir(){
for dir in $(ls -d */)
do
  if [ -d "$dir"/.git ]; then
	cd $dir
	echo "${time} Change to: ${PWD}"
    echo "${time} Begin Pull Code For Repo: ${dir}"
	pull_push_repo $dir
	echo "${time} End Sync Code in Repo: ${dir}"
    cd ..
	echo "${time} Return to: ${PWD}"
 
  fi
done

echo "###########Repo Count : ${#code_repo_list[@]}, synced: ${index_count}."
}

start_to_sync_repos_from_config
#start_to_sync_repos_in_dir

time=$(date "+%Y-%m-%d %H:%M:%S")	
echo "###########${time} End Sync Code"


read -n1 -p "Press any key to continue..."
