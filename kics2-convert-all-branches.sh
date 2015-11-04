git for-each-ref --format="%(refname:short)" refs/heads |
while read local
do
    echo git checkout -f "$local"
    git checkout -f "$local"

    echo git reset --hard HEAD
    git reset --hard HEAD

    echo sh ../submodule2subtree.sh
    sh ../submodule2subtree.sh

    ln -s README README.md
    git add README.md
    git commit -m "symlink README.md"

    echo --------------
done
