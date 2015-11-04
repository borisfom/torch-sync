echo rm -rf kics2-mirror
rm -rf kics2-mirror

echo git clone --mirror git://git-ps.informatik.uni-kiel.de/curry/kics2.git kics2-mirror/.git
git clone --mirror git://git-ps.informatik.uni-kiel.de/curry/kics2.git kics2-mirror/.git

echo cd kics2-mirror
cd kics2-mirror

echo git config --local --bool core.bare false
git config --local --bool core.bare false

echo git reset --hard HEAD
git reset --hard HEAD

# echo ----------------------------

echo git remote add mirror git@github.com:eallik/curry-kics2.git
git remote add mirror git@github.com:eallik/curry-kics2.git

echo --------------------------

../kics2-convert-all-branches.sh

../kics2-mirror-repush-all-branches.sh

