#!/bin/sh

BRANCH_NAME=${1:-release}

REPO_URL=https://github.com/borisfom/distro.git
MIRROR_URL=${MIRROR_URL:-"git@github.com:borisfom/distro-mirror.git"}
MIRROR_DIR="torch-mirror/${BRANCH_NAME}"
MIRROR_BRANCH="${BRANCH_NAME}-mirror"
THIS_DIR=$(cd $(dirname $0); pwd)

rm -rf ${MIRROR_DIR}

echo git clone --branch ${BRANCH_NAME} --single-branch ${REPO_URL} ${MIRROR_DIR}
git clone --branch ${BRANCH_NAME} --single-branch ${REPO_URL} ${MIRROR_DIR}

echo ----------------------------

cd ${THIS_DIR}/${MIRROR_DIR} && git remote set-url origin --push ${MIRROR_URL} && git remote -v

cd ${THIS_DIR}/${MIRROR_DIR} && git checkout --orphan ${MIRROR_BRANCH} && git commit -a -m 'Initialized orhpan ${MIRROR_BRANCH} branch' && git push -f --set-upstream origin ${MIRROR_BRANCH} || exit 1

cd ${THIS_DIR}/${MIRROR_DIR} && ${THIS_DIR}/submodule2subtree.sh || exit 1

echo --------------------------

echo "Mirror of ${MIRROR_BRANCH} at ${REPO_URL} initialized."

echo --------------------------
