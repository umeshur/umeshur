$ cat test.sh
#!/bin/bash

# file which have list of content 
filename="input.txt"

# User your PAT
PAT="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"

API_URL="api.github.com"

#no need
PER="write"

while IFS=$'\n' read  -r repo
do
        echo "$repo"
        curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer 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" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/repos -d '{"name": "'$repo'","private":false}'
done < "$filename"
