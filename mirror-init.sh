#!/bin/sh

REPO_URL=https://github.com/borisfom/distro.git
MIRROR_URL=git@github.com:borisfom/distro-mirror.git

BRANCH_NAME=${BRANCH_NAME:-release}

THIS_DIR=$(cd $(dirname $0); pwd)

echo rm -rf torch-mirror
rm -rf torch-mirror

echo git clone -b ${BRANCH_NAME} --depth 10 ${REPO_URL} torch-mirror
git clone -b ${BRANCH_NAME} --depth 10 ${REPO_URL} torch-mirror

cd ${THIS_DIR}/torch-mirror && git checkout ${BRANCH_NAME} && git reset --hard HEAD && ${THIS_DIR}/submodule2subtree.sh

# echo ----------------------------

cd ${THIS_DIR}/torch-mirror && git remote set-url origin --push ${MIRROR_URL}

echo --------------------------
