#!/bin/bash

THIS_DIR=$(cd $(dirname $0); pwd)
BRANCH_NAME=${BRANCH_NAME:-release}

git fetch origin ${BRANCH_NAME}
git checkout ${BRANCH_NAME} `cat files.list`

cat .gitmodules |while read i
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
