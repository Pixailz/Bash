#! /bin/bash

read -p "Enter your email : " userEmail
read -p "Enter your name : " userName

git config --global user.email "$userEmail"
git config --global user.name "userName"

