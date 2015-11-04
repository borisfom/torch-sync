# # delete all remote branches
# for remote in $(git show-ref --heads | cut -c53-);
# do
#     echo git push -f mirror :"$remote"
#     git push -f mirror :"$remote"
# done


# push master branch first to make it the default
echo git push -f mirror master
git push -f mirror master


# push rest of the branches
git for-each-ref --format="%(refname:short)" refs/heads |
while read local
do
    echo git push -f mirror "$local"
    git push -f mirror "$local"
done
