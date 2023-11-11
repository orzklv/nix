#!/bin/bash

# Ask user GitHub access token if not set and add to ~/.zshrc
read -r -p 'Enter your GitHub access token: ' GITHUB_ACCESS_TOKEN
printf "\nexport GITHUB_ACCESS_TOKEN=\"%s\"" "$GITHUB_ACCESS_TOKEN" >> ~/.zshrc

# Check if .fast-push file exists, if not, ask user for repository name
# and add to ./.fast-push, if it does, read from ./.fast-push
if [ ! -f ./.fast-push ]; then
  echo "No repository name found, please enter your repository name"
  echo "Example: [repo-owner/repo-name] like... orzklv/tools"
  read -r -p 'Enter your repository location: ' REPOSITORY_LOCATION
  printf "%s" "REPOSITORY_LOCATION" > ./.fast-push
else
  REPOSITORY_LOCATION=$(cat ./.fast-push)
fi

# Push the current branch to GitHub
git push https://"$GITHUB_ACCESS_TOKEN"@github.com/"$REPOSITORY_LOCATION".git