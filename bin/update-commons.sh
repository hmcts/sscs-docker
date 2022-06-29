ticket=$1
version=$2

echo ${ticket}
echo ${version}

cd ../..

for value in sscs-hearings-api
do
    cd ${value}

    git checkout master

    git reset --hard

    git pull

    git switch -c ${ticket}-${version}-Commons-Upgrade

    sed -i "s/sscsCommon: [^ ]*/sscsCommon: '${version}',/" build.gradle

    git add .

    git commit -m "${ticket} Updating Commons Version to ${version}"

    git push --set-upstream origin ${ticket}-${version}-Commons-Upgrade

    gh pr create --title " ${ticket}-${version}-Commons-Upgrade" --body "https://tools.hmcts.net/jira/browse/${ticket}"

    output=$(gh pr list --head ${ticket}-${version}-Commons-Upgrade)

    read word _ <<< "$output}"

    echo ${value} | tr -d '-'
    output=$(echo ${value} | tr -d '-')
    eval "${output}=https://github.com/hmcts/${value}/pull/${word}"

    cd ..
    
    clear
done 

echo ${sscshearingsapi}
echo ${sscstribunalscaseapi}