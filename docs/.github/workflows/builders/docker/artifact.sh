#!/bin/bash

# environtment
echo -e "\n$hr\nENVIRONTMENT\n$hr"
printenv | sort

# makefile
echo -e "\n$hr\nMAKEFILE\n$hr"
cat ${WORKING_DIR}/${JEKYLL_SRC}/Makefile

# config file
echo -e "\n$hr\nJEKYLL CONFIG FILE\n$hr"
cat ${WORKING_DIR}/${JEKYLL_SRC}/${JEKYLL_CFG}

# pinned repos
# https://dev.to/thomasaudo/get-started-with-github-grapql-api--1g8b
echo -e "\n$hr\nPINNED  REPOSITORIES\n$hr"
AUTH="Authorization: bearer $JEKYLL_GITHUB_TOKEN"
curl -L -X POST "${GITHUB_GRAPHQL_URL}" -H "$AUTH" \
--data-raw '{"query":"{\n  user(login: \"'${GITHUB_REPOSITORY_OWNER}'\") {\n pinnedItems(first: 6, types: REPOSITORY) {\n nodes {\n ... on Repository {\n name\n }\n }\n }\n }\n}"'

# Directory Setting
# remote_theme: eQ19/parser
# https://jekyllrb.com/docs/configuration/default/
# https://jekyllrb.com/docs/continuous-integration/github-actions/
# https://docs.github.com/en/actions/security-guides/encrypted-secrets

ln -s docs/css/_sass _sass
ln -s assets/_layouts _layouts
ln -s assets/_plugins _plugins
ln -s assets/_includes _includes
ln -s assets/primes/numberGenerator/python/prime_lists/_data _data
ln -s assets/primes/numberGenerator/python/prime_lists/_data/_base/_maps _maps
ln -s assets/primes/numberGenerator/python/prime_lists/_data/_base/_feeds _feeds
ln -s assets/primes/numberGenerator/python/prime_lists/_data/_base/_posts _posts

# workspace
echo -e "\n$hr\nWORKING DIRECTORY\n$hr"
echo ${WORKING_DIR}
ls -al ${WORKING_DIR}

# jekyll source
echo -e "\n$hr\nJEKYLL DIRECTORY\n$hr"
pwd
ls -al ${WORKING_DIR}/${JEKYLL_SRC}

# asset files
echo -e "\n$hr\nASSET FILES\n$hr"
# https://stackoverflow.com/a/42137273/4058484
ls -al ${WORKING_DIR}/${JEKYLL_SRC}/docs/assets
