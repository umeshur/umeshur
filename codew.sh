#!/bin/bash
ACCESS_TOKEN="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"
REPO_NAME=umeshur
REPO_OWNER=umeshur
response=$(curl -H "Authorization: token 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" -H "Accept: application/vnd.github.v3+json"  "https://api.github.com/repos/umeshur/umeshur/contents/CODEOWNERS")
# Extract SHA from the response using jq (make sure jq is installed)
sha=$(echo "$response" | jq -r '.sha')

# Print the retrieved SHA
echo "SHA of $FILE_PATH: $sha"
# Fetch existing CODEOWNERS content
EXISTING_CONTENT=$(curl -H "Authorization: token $ACCESS_TOKEN" "https://api.github.com/repos/umeshur/umeshur/contents/CODEOWNERS?ref=main" | jq -r '.["content"]')
# #EXIT=$(echo "$EXISTING_CONTENT"| base64 --decode)
# EXIT=$(echo "$EXISTING_CONTENT" | openssl enc -d -base64)
# echo $EXIT >> output_code.txt

