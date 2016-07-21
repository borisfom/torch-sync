#!/bin/sh

REPO_URL=$1
MIRROR_URL=$2

REPO_URL=https://github.com/borisfom/distro.git
MIRROR_URL=git@github.com:borisfom/distro-mirror.git

BRANCH_NAME=${BRANCH_NAME:-release}

THIS_DIR=$(cd $(dirname $0); pwd)

echo rm -rf torch-mirror
rm -rf torch-mirror

echo git clone --mirror -b ${BRANCH_NAME} ${REPO_URL} torch-mirror/.git
git clone --mirror ${REPO_URL} -b ${BRANCH_NAME} torch-mirror/.git

echo cd torch-mirror
cd torch-mirror

echo git config --local --bool core.bare false
git config --local --bool core.bare false

echo git checkout release
git checkout release

echo git reset --hard HEAD
git reset --hard HEAD

echo ${THIS_DIR}/submodule2subtree.sh
${THIS_DIR}/submodule2subtree.sh

# echo ----------------------------

echo git remote add mirror ${MIRROR_URL}
git remote add mirror ${MIRROR_URL}

echo --------------------------

# ${THIS_DIR}/convert-all-branches.sh

# ${THIS_DIR}/mirror-repush-all-branches.sh
