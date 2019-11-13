code_repo_list=(
'abcdee'
'12345'
)

index_count=0

prefix_url='https://github.com/abc/'

time=$(date "+%Y-%m-%d %H:%M:%S")

echo "###########${time} Begin Pull Repo Code"

function pull_remote_repo(){

#echo "###Repo ${1} is going###"
courrentrepo="${prefix_url}${1}.git"
echo "Clone repo: ${courrentrepo} in: ${PWD}"
git clone $courrentrepo
testbranch=$(git branch -a | grep develop | sed 's/ //g')
if [ -n "${testbranch}" ] ;then
	git checkout -b develop origin/develop
fi
let index_count+=1
}


###main loop start to sync all code repo
function start_to_pull_repo_from_remote(){

echo "###########Repo Count : ${#code_repo_list[@]} in Total"

for repodir in ${code_repo_list[@]}
do
if [ ! -d "$repodir" ]; then
    mkdir $repodir
	cd "$repodir"
	time=$(date "+%Y-%m-%d %H:%M:%S")
#	echo "${time} Begin Handle remote For Repo: ${repodir}"
	pull_remote_repo $repodir
	cd ..
	time=$(date "+%Y-%m-%d %H:%M:%S")
#	echo "${time} Finished add remote repo ,Return to: ${PWD}"
fi

done

let skiped_cout=${#code_repo_list[@]}-index_count

time=$(date "+%Y-%m-%d %H:%M:%S")

echo "###########Repo Count : ${#code_repo_list[@]}, Pulled: ${index_count} skiped ${skiped_cout}."

}

start_to_pull_repo_from_remote

time=$(date "+%Y-%m-%d %H:%M:%S")
echo "###########${time} Finished to Pull Repo Code"

read -n1 -p "Press any key to continue..."
