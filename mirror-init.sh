#!/bin/sh

REPO_URL=https://github.com/borisfom/distro.git
MIRROR_URL=git@github.com:borisfom/distro-mirror.git

BRANCH_NAME=${BRANCH_NAME:-release}

THIS_DIR=$(cd $(dirname $0); pwd)

echo rm -rf torch-mirror
rm -rf torch-mirror

echo git clone --branch ${BRANCH_NAME} --single-branch --depth 10 ${REPO_URL} torch-mirror
git clone --branch ${BRANCH_NAME} --single-branch ${REPO_URL} torch-mirror

echo ----------------------------

cd ${THIS_DIR}/torch-mirror && git remote set-url origin --push ${MIRROR_URL} && git remote -v

cd ${THIS_DIR}/torch-mirror && git checkout --orphan mirror && git commit -a -m 'Initialized orhpan mirror branch' && git push -f --set-upstream origin mirror || exit 1

cd ${THIS_DIR}/torch-mirror && ${THIS_DIR}/submodule2subtree.sh || exit 1

echo --------------------------

echo "Mirror at ${REPO_URL} initialized."

echo --------------------------
