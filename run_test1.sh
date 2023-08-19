#!/bin/bash
# GitHub Personal Access Token (PAT)
echo -n "Enter your Github PAT:"
read -s PAT
echo ""    #just empty line
now=$(date)
output=out.txt
echo "#################################################$now##############################################" >> $output
echo ================ >> $output
echo result >> $output
echo ================ >> $output
#file with team and repo names with permissions
TXT_FILE="repolist.txt"   #API has diffrent names for Read and Write. API Read is passed in as pull & Write is push
#Loop through CSV entries and change permissions
while IFS=$',' read -r team repo permission
do
curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $PAT" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/WoolworthsSOISaml/teams/$team/repos/WoolworthsSOISaml/$repo -d '{"permission":"'$permission'"}'

status=$(curl -L -X PUT -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $PAT" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/WoolworthsSOISaml/teams/$team/repos/WoolworthsSOISaml/$repo -d '{"permission":"'$permission'"}' -s -o /dev/null -w "%{http_code}")
if [[ $status == 200 ]] || [[ $status == 204 ]]
then
        echo teams updated to $repo >> $output
        echo $team is added to $repo with role $permission >> $output
        echo "---------------------------------------------------------------------------------------" >> $output
else
        echo failed for $repo  >> $output
        echo $team is not added to $repo >> $output
        echo "---------------------------------------------------------------------------------------" >> $output
fi
done < "$TXT_FILE"
echo "Task is complted and output stored at $output."
