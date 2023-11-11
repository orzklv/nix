#!/bin/bash

# Ask user GitHub access token if not set and add to ~/.zshrc
read - r - p 'Enter your GitHub access token: ' GITHUB_ACCESS_TOKEN
printf "\nexport GITHUB_ACCESS_TOKEN=\"%s\"" "$GITHUB_ACCESS_TOKEN" > > ~/.zshrc

# Ask user if it's a user or organization
read - r - p 'Is this for a user or organization? [ user/organization ]: ' GITHUB_USER_ORG

if [ "$GITHUB_USER_ORG" = "organization" ]; then
  # Ask user for GitHub organization name
  read -r -p 'Enter the name of github organization: ' GITHUB_ORG
fi

# Ask user where they want write as location
read -r -p 'Enter your location: ' GITHUB_LOCATION

# Regarding to user or organization, update location
if [ "$GITHUB_USER_ORG" = "user" ]; then
  curl -H "Authorization: bearer $GITHUB_ACCESS_TOKEN" -d "{\"location\":\"$GITHUB_LOCATION\"}" https://api.github.com/user
elif [ "$GITHUB_USER_ORG" = "organization" ]; then
  curl -H "Authorization: bearer $GITHUB_ACCESS_TOKEN" -d "{\"location\":\"$GITHUB_LOCATION\"}" "https://api.github.com/orgs/$GITHUB_ORG"
else
  echo "Invalid argument for user or organization"
  exit 1
fi
