code_repo_list=(
'repo-1'
'repo-2'
'repo-3'
)

index_count=0

prefix_url_osc='https://github.com/somerepo/'
target_repo='abc|xyz'

time=$(date "+%Y-%m-%d %H:%M:%S")

echo "###########${time} Begin Add Remote Repo"

function add_remote_repo(){


target_repo_url="${prefix_url_osc}${1}.git"

git remote | grep -i -E $target_repo > nul &&  echo "${time} target repo found in ${PWD}" && return

if [ -Z $target_repo ]; then
    echo "###Repo ${target_repo_url} will be added ###"
	git remote add osc $target_repo_url
	let index_count+=1
fi

}


###main loop start to sync all code repo
function start_to_add_repo(){

echo "###########Repo Count : ${#code_repo_list[@]} in Total"

for repodir in ${code_repo_list[@]}
do
if [ -d "${repodir}" ]; then
	cd "${repodir}"
	time=$(date "+%Y-%m-%d %H:%M:%S")
#	echo "${time} Begin Handle remote For Repo: ${repodir}"
	add_remote_repo $repodir
	cd ..
	time=$(date "+%Y-%m-%d %H:%M:%S")
#	echo "${time} Finished add remote repo ,Return to: ${PWD}"

fi
done

let skiped_cout=${#code_repo_list[@]}-index_count

echo "###########Repo Count : ${#code_repo_list[@]}, Added: ${index_count} skiped ${skiped_cout}."

}

start_to_add_repo

time=$(date "+%Y-%m-%d %H:%M:%S")	
echo "###########${time} Finished to Add Remote Repo"

read -n1 -p "Press any key to continue..."
