#!/bin/bash

filename="$1"

PAT="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"

API_URL="api.github.com"

PER="write"

while IFS=$'\n' read  -r repo 
do
	echo "$repo"
	curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer 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" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://$API_URL/user/repos \
  -d '{"name":"'$repo'","description":"This is your first repo as!","homepage":"https://github.com","private":false,"is_template": true}'
sleep 2
done < "$1"
green='\033[0;32m'
echo -e "${green}Task is compeleted. Thanks"
