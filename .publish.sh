#!/bin/bash
set -ex
DATE=$(date);
TMPREPO=$(mktemp -d);
git clone --quiet https://github.com/usegalaxy-au/usegalaxy-au.github.io.git $TMPREPO;
mv $TMPREPO/.git _site/;
cp Gemfile Gemfile.lock _site;
cp readme-deployed.md _site/README.md;
rm -rf $TMPREPO
cd _site
git add --all *
git config --local user.name "help@genome.edu.au"
git config --local user.email "help@genome.edu.au"
git config --local -l
git commit -m "Update site ($DATE)"

git push origin master
