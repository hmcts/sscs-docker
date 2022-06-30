ticket=$1
version=$2

if [ $# -eq 0 ]; then
    echo "Please provide a ticket number"
    exit 1
fi

if [ $# -eq 1 ]; then
    echo "Please provide the commons version"
    exit 1
fi

echo ${ticket}
echo ${version}

cd ../..

for value in sscs-hearings-api sscs-tribunals-case-api sscs-track-your-appeal-notifications sscs-ccd-callback-orchestrator sscs-bulk-scan sscs-evidence-share sscs-case-loader
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
echo ${sscstrackyourappealnotifications}
echo ${sscsccdcallbackorchestrator}
echo ${sscsbulkscan}
echo ${sscsevidenceshare}
echo ${sscscaseloader}
