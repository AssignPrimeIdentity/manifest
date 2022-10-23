#!/bin/bash
set -e
export WORKING_DIR=${PWD}
export hr=$(printf '=%.0s' {1..83})
export SCRIPT_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Initial default value
TOKEN=${INPUT_TOKEN}
ACTOR=${INPUT_ACTOR}
BRANCH=${INPUT_BRANCH}
REPOSITORY=${INPUT_REPOSITORY}
PROVIDER=${INPUT_PROVIDER:=github}
BUNDLER_VER=${INPUT_BUNDLER_VER:=>=0}
JEKYLL_SRC=${INPUT_JEKYLL_SRC:=./}
JEKYLL_CFG=${INPUT_JEKYLL_CFG:=./_config.yml}
JEKYLL_BASEURL=${INPUT_JEKYLL_BASEURL:=}
PRE_BUILD_COMMANDS=${INPUT_PRE_BUILD_COMMANDS:=}

if [[ -z "${TOKEN}" ]]; then
  echo -e "Please set the TOKEN environment variable."
  exit 1
fi

if [[ "${OWNER}" != "eq19" ]]; then
  JEKYLL_SRC=${JEKYLL_SRC}/docs
  sed -i -e "s/eq19/${OWNER}/g" ${JEKYLL_SRC}/${JEKYLL_CFG}
fi

export JEKYLL_CFG=${JEKYLL_CFG}
export BUNDLER_VER=${BUNDLER_VER}
export JEKYLL_GITHUB_TOKEN=${TOKEN}
export OWNER=${GITHUB_REPOSITORY_OWNER}
export PAGES_REPO_NWO=${GITHUB_REPOSITORY}}
export BUNDLE_PATH=${WORKING_DIR}/vendor/bundle
export SSL_CERT_FILE=$(realpath .github/hook-scripts/cacert.pem)

# Pre-handle Jekyll baseurl
if [[ -n "${JEKYLL_BASEURL-}" ]]; then
  JEKYLL_BASEURL="--baseurl ${JEKYLL_BASEURL}"
fi

build_jekyll() {
  echo -e "\nJEKYLL INSTALLATION\n"
  cd ${JEKYLL_SRC}
  pwd 
  JEKYLL_GITHUB_TOKEN=${TOKEN} bundle exec jekyll build --trace --profile \
    ${JEKYLL_BASEURL} \
    -c ${JEKYLL_CFG} \
    -d ${WORKING_DIR}/build
}

build_jekyll || {
  $CLEANUP_BUNDLER_CACHE_DONE && exit -1
  echo -e "\nRebuild all gems and try to build again\n"
  cleanup_bundler_cache
  bundle install
  build_jekyll
}
