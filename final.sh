#!/bin/bash
# GitHub Personal Access Token (PAT)
echo -n "Enter your Github PAT:"
read -s PAT
# GitHub API base URL
API_URL="https://api.github.com"
#file with team and repo names
TXT_FILE="repolist.txt"
permission="pull"
#Loop through CSV entries and change permissions
while IFS=$',' read -r team repo
do
curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $PAT" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/WoolworthsSOISaml/teams/$team/repos/WoolworthsSOISaml/$repo -d '{"permission":"'$permission'"}'
done < "$TXT_FILE"
green='\033[0;32m'
echo -e "${green}Task is compeleted. Thanks"
