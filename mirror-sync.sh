#!/bin/bash

THIS_DIR=$(cd $(dirname $0); pwd)
BRANCH_NAME=${1:-release}

MIRROR_BRANCH="${BRANCH_NAME}-mirror"

git checkout ${MIRROR_BRANCH}

git fetch origin ${BRANCH_NAME}

# Refresh all files except subtrees from original repo
git checkout ${BRANCH_NAME} `cat files.list`

# Fetch new, possibly changed .gitmodules file
git checkout release .gitmodules && git mv -f .gitmodules modules.gitinfo || exit 1

cat modules.gitinfo |while read i
do
if [[ $i == \[submodule* ]]; then
    echo "Processing $i ..."

    # extract the module's prefix
    mpath=$(echo $i | cut -d\" -f2)

    # skip two lines
    read i; read i;

    # extract the url of the submodule
    murl=$(echo $i|cut -d\  -f3)

    read i;
    mbranch=$(echo $i|cut -d\  -f3)

    # fetch the submodules files
    git subtree pull --prefix $mpath --squash  $murl $mbranch
fi
done

git push origin ${MIRROR_BRANCH}
