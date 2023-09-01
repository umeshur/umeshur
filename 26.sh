#!/bin/bash

ACCESS_TOKEN=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
REPO_OWNER="umeshur"
repo_name="umeshur"
NEW_BRANCH_NAME="shruuu"
CODEOWNERS_CONTENT="testing11111 @team @team1"
BASE_BRANCH=main
# Create a new feature branch
curl -X POST "https://api.github.com/repos/$REPO_OWNER/$repo_name/git/refs" \
     -H "Authorization: Bearer $ACCESS_TOKEN" \
     -d '{
       "ref": "refs/heads/'$NEW_BRANCH_NAME'",
       "sha": "'$(curl -s "https://api.github.com/repos/$REPO_OWNER/$repo_name/git/refs/heads/$BASE_BRANCH" | jq -r .object.sha)'"
     }'

response=$(curl -H "Authorization: token $ACCESS_TOKEN" -H "Accept: application/vnd.github.v3+json"  "https://api.github.com/repos/umeshur/$repo_name/contents/CODEOWNERS")
# Extract SHA from the response using jq (make sure jq is installed)
sha=$(echo "$response" | jq -r '.sha')

# Print the retrieved SHA
echo "SHA of $FILE_PATH: $sha"
# Fetch existing CODEOWNERS content
EXISTING_CONTENT=$(curl -H "Authorization: token $ACCESS_TOKEN" https://api.github.com/repos/umeshur/$repo_name/contents/CODEOWNERS?ref=main | jq -r '.content')
echo Existing content fetched $EXISTING_CONTENT
EXIT=$(echo "$EXISTING_CONTENT"| openssl enc -d -base64)
echo decoded
# Modify the content (example: add a new line)
update=$(echo "new line added")
echo new lines added
NEW_CONTENT=$(echo "$EXIT" | sed "a\'$update'")
echo combined
NEW=$(echo "$NEW_CONTENT" | base64)
echo encodedd
# Modify CODEOWNERS file in the new branch
DATA=$('{"message": "Update CODEOWNERS in '$NEW_BRANCH_NAME',"content": '$NEW',"sha": '$sha',"branch": '$NEW_BRANCH_NAME'}')

curl -L -X PUT -H 'Accept: application/vnd.github+json' -H 'Authorization: Bearer '$ACCESS_TOKEN'' -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/umeshur/$repo_name/contents/CODEOWNERS" -d "$DATA"


curl --request POST --url "https://api.github.com/repos/umeshur/hello-world/contents/CODEOWNERS" --header  "Accept: application/vnd.github+json" --header "Authorization: Bearer $ACCESS_TOKEN" --data '{"branch":"'$NEW_BRANCH_NAME'","content": "'$(echo '$CODEOWNERS_CONTENT'|base64)'","sha": "'$sha'"}' 
