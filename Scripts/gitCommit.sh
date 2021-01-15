#! /bin/bash

read -p "Enter a git repo : " repo 

cd $repo

git add .
git commit -a
git push
