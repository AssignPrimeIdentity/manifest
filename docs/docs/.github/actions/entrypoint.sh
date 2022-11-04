#!/bin/bash
set -e
export WORKING_DIR=${PWD}
chown -R $(whoami) ${WORKING_DIR}
export hr=$(printf '=%.0s' {1..80})

# Initial default value
TOKEN=${INPUT_TOKEN}
ACTOR=${INPUT_ACTOR}
BRANCH=${INPUT_BRANCH}
REPOSITORY=${INPUT_REPOSITORY}
OWNER=${GITHUB_REPOSITORY_OWNER}
PROVIDER=${INPUT_PROVIDER:=github}
BUNDLER_VER=${INPUT_BUNDLER_VER:=>=0}
JEKYLL_BASEURL=${INPUT_JEKYLL_BASEURL:=}
PRE_BUILD_COMMANDS=${INPUT_PRE_BUILD_COMMANDS:=}

# https://stackoverflow.com/a/42137273/4058484
export JEKYLL_SRC=${WORKING_DIR}
export JEKYLL_GITHUB_TOKEN=${TOKEN}
if [[ "${OWNER}" != "eq19" ]]; then
  export JEKYLL_SRC=${WORKING_DIR}/docs
fi
export JEKYLL_CFG=${JEKYLL_SRC}/_config.yml
sed -i -e "s/eq19/${OWNER}/g" ${JEKYLL_CFG}

if [[ -z "${TOKEN}" ]]; then
  echo -e "Please set the TOKEN environment variable."
  exit 1
fi

# Check parameters and assign default values
if [[ "${PROVIDER}" == "github" ]]; then
  : ${BRANCH:=gh-pages}
  : ${ACTOR:=${GITHUB_ACTOR}}
  : ${REPOSITORY:=${GITHUB_REPOSITORY}}

  # Check if repository is available
  if ! echo -e "${REPOSITORY}" | grep -Eq ".+/.+"; then
    echo -e "The repository ${REPOSITORY} doesn't match the pattern <author>/<repos>"
    exit 1
  fi
fi

# Pre-handle Jekyll baseurl
if [[ -n "${JEKYLL_BASEURL-}" ]]; then
  JEKYLL_BASEURL="--baseurl ${JEKYLL_BASEURL}"
fi

# Initialize environment
export RUBYOPT=W0
export RAILS_VERSION=5.0.1
export BUNDLER_VER=${BUNDLER_VER}
export PATH=${PATH}/root/.local/bin
export BUNDLE_SILENCE_ROOT_WARNING=1
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1
export PAGES_REPO_NWO=$GITHUB_REPOSITORY
export BUNDLE_PATH=${WORKING_DIR}/vendor/bundle
# export GEM_HOME=/github/home/.gem/ruby/${RUBY_VERSION}
# export PATH=$PATH:${GEM_HOME}/bin:$HOME/.local/bin
export SSL_CERT_FILE=$(realpath .github/hook-scripts/cacert.pem)

echo -e "$hr\nBUNDLE INSTALLATION\n$hr"
apt-get install -qq python3.8-venv < /dev/null
chown -R root ${HOME} && python3.8 -m venv grammar < /dev/null
source grammar/bin/activate && touch nojekyll

apt-get install -qq --no-install-recommends apt-utils < /dev/null
apt-get install -qq git < /dev/null

apt-get install -qq ruby ruby-dev ruby-bundler build-essential < /dev/null
gem install rails --version "$RAILS_VERSION" --quiet --silent < /dev/null

apt-get install -qq npm < /dev/null
npm set progress=false && npm install -qq yarn < /dev/null

python -m pip install -U --force-reinstall pip < /dev/null
pip install tensorflow-gpu --root-user-action=ignore --quiet < /dev/null

# Restore modification time (mtime) of git files
CLEANUP_BUNDLER_CACHE_DONE=false
bundle config path $BUNDLE_PATH
bundle config cache_all true
/script/init_environment.sh
/script/restore_mtime.sh

# Clean up bundler cache
cleanup_bundler_cache() {
  echo -e "\nCleaning up incompatible bundler cache\n"
  /script/cleanup_bundler.sh
  gem install bundler -v "${BUNDLER_VER}"
  
  rm -rf ${BUNDLE_PATH}
  mkdir -p ${BUNDLE_PATH}

  bundle install
  CLEANUP_BUNDLER_CACHE_DONE=true
}

# If the vendor/bundle folder is cached in a differnt OS (e.g. Ubuntu),
# it would cause `jekyll build` failed, we should clean up the uncompatible
# cache firstly.
OS_NAME_FILE=${BUNDLE_PATH}/os-name
os_name=$(cat /etc/os-release | grep '^NAME=')
os_name=${os_name:6:-1}

if [[ "$os_name" != "$(cat $OS_NAME_FILE 2>/dev/null)" ]]; then
  cleanup_bundler_cache
  echo -e $os_name > $OS_NAME_FILE
fi

# Check and execute pre_build_commands commands
cd ${JEKYLL_SRC}

if [[ ${PRE_BUILD_COMMANDS} ]]; then
  eval "${PRE_BUILD_COMMANDS}"
fi

# https://gist.github.com/DrOctogon/bfb6e392aa5654c63d12
build_jekyll() {
  echo -e "\nJEKYLL INSTALLATION\n"
  pwd
  JEKYLL_GITHUB_TOKEN=${TOKEN} bundle exec jekyll build --trace --profile \
    ${JEKYLL_BASEURL} -c ${JEKYLL_CFG} -d ${WORKING_DIR}/build
}

build_jekyll || {
  $CLEANUP_BUNDLER_CACHE_DONE && exit -1
  echo -e "\nRebuild all gems and try to build again\n"
  cleanup_bundler_cache
  build_jekyll
}

# Check if deploy on the same repository branch
cd ${WORKING_DIR}/build && rm -rf grammar
if [[ "${PROVIDER}" == "github" ]]; then
  source "/script/github.sh"
else
  echo -e "${PROVIDER} is an unsupported provider."
  exit 1
fi

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* < /dev/null
exit $?
