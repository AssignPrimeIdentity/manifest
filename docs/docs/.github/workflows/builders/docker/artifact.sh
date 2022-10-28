#!/bin/bash

# environtment
echo -e "\n$hr\nENVIRONTMENT\n$hr"
printenv | sort

# makefile
echo -e "\n$hr\nMAKEFILE\n$hr"
cat ${WORKING_DIR}/Makefile

# config file
echo -e "\n$hr\nJEKYLL CONFIG FILE\n$hr"
cat ${JEKYLL_CFG}

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

# workspace
echo -e "\n$hr\nWORKING DIRECTORY\n$hr"
echo ${WORKING_DIR}
ls -al ${WORKING_DIR}
[[ ! -d "css" ]] && ln -s ${JEKYLL_SRC}/docs/css css
if [[ ! -d "assets" ]]; then
  if [[ -d "${WORKING_DIR}/assets" ]]; then
    ln -s ${WORKING_DIR}/assets assets
  else
    if [[ -d "${WORKING_DIR}/docs/assets" ]]; then
      ln -s ${WORKING_DIR}/docs/assets assets
    fi
  fi
fi

# jekyll source
echo -e "\n$hr\nJEKYLL DIRECTORY\n$hr"
pwd
ln -s css/_sass _sass
ln -s lists/_data _data
ln -s assets/_layouts _layouts
ln -s assets/_plugins _plugins
ln -s assets/_includes _includes
ln -s lists/_data/_base/_maps _maps
ln -s lists/_data/_base/_feeds _feeds
ln -s lists/_data/_base/_posts _posts
ls -al ${JEKYLL_SRC}
