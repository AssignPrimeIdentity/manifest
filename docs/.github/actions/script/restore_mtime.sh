#!/bin/bash

# Restore the modification time (mtime) of all files in work tree, based on the
# date of the most recent commit that modified the file.
for f in $(git ls-files); do
  mtime=$(git log -1 --format='%at' -- "$f")
  [[ "$mtime" == "" ]] && continue
  mtime=$(date -d @"$mtime" "+%Y-%m-%dT%H:%M:%S")
  touch -d "$mtime" "$f"
done

# clone a repo, including its submodules
# https://stackoverflow.com/a/4438292/4058484
cd /tf-gpu/maps && rm -rf primes
mv ${JEKYLL_SRC}/.github/actions/primes primes

cd primes/numberGenerator
mv assets ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/assets assets
mv _sass ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_sass _sass
mv _layouts ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_layouts _layouts
mv _plugins ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_plugins _plugins
mv _includes ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_includes _includes

cd python/spacetimeengine/src
mv data ${JEKYLL_SRC}/_data && ln -s ${JEKYLL_SRC}/_data data

cd ${JEKYLL_SRC}/_data/_base
mv _maps ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_maps _maps
mv _feeds ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_feeds _feeds
mv _posts ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_posts _posts
