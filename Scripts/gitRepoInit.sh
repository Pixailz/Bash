#! /bin/bash
#init repo files

read -p "Enter the username for github : "
read -p "Enter the name of the repo : " repo

git clone https://github.com/$urlrepo/$repo.git

cd $repo

git init
git commit -m "first commit"
