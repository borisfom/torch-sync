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

    # extract the module name
    mname=$(basename $mpath)

    # deinit the module
    echo git submodule deinit $mpath
    git submodule deinit $mpath

    # remove the module from git
    echo git rm -fr --cached $mpath
    git rm -fr --cached $mpath

    # remove the module from the filesystem
    echo rm -rf $mpath
    rm -rf $mpath

    # commit the change
    echo git commit -m \"Removed $mpath submodule\"
    git commit -m "Removed $mpath submodule"

    # add the remote
    echo git remote add -f $mname $mpath
    git remote add -f $mname $murl

    # add the subtree
    echo git subtree add --prefix $mpath $murl master
    git subtree add --prefix $mpath $mname master

    # fetch the files
    echo git fetch $murl master
    git fetch $murl master
fi
done
echo git rm -f .gitmodules
