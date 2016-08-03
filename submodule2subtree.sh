#!/bin/bash

# extract the list of submodules from .gitmodule
cat .gitmodules |while read i
do
if [[ $i == \[submodule* ]]; then
    echo $i

    # extract the module's prefix
    mpath=$(echo $i | cut -d\" -f2)

    # skip two lines
    read i; read i;

    # extract the url of the submodule
    murl=$(echo $i|cut -d\  -f3)

    read i;
    mbranch=$(echo $i|cut -d\  -f3)

    # deinit the module
    echo git submodule deinit $mpath
    git submodule deinit $mpath

    # remove the module from git
    echo git rm -fr --cached $mpath
    git rm -fr --cached $mpath &&  rm -rf $mpath && git commit -m "Removed $mpath submodule" || exit 1

    echo git commit -m \"Removed $mpath submodule\"


    # add the subtree
    echo git subtree add --squash --prefix $mpath $murl $mbranch
    git subtree add --squash --prefix $mpath $murl $mbranch

    # fetch the files
    echo git fetch $murl $mbranch
    git fetch $murl $mbranch
fi
done

git mv .gitmodules modules.gitinfo && git commit -m "Removed .gitmodules" && git push origin ${MIRROR_BRANCH}
