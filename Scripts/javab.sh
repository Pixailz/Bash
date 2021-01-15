#!/bin/bash

usage (){
    echo "Usage : $0 [FILE.JAVA]"
}

loop='y'

while [ "$loop" == 'y' ]; do
    
    clear
    if [ -z $1 ]; then
        
        usage
        exit 1

    elif [ ${1: -5} != ".java" ]; then

        echo "File $1 couldn't be compiled because isn't a .java file"
        usage
        exit 2
    fi

    old_file=$(echo $1 | sed 's/.java/.class/g')

    if [ -f "$file" ]; then
        echo "removing old"
        rm -f $old_file
    fi

    file=$(echo $1 | sed 's/.java//g')
    javac $1
    echo -e "=====\nBEGIN\n====="
    java $file

    echo -e "\n===\nEND\n==="
    
    loop=""

    while [[ "$loop" != 'y' ]] && [[ "$loop" != 'n' ]]; do
        read -p "Retry (Y/N)" -n 1 loop
        echo ""
        loop=$(echo "${loop,,}")
        if [[ "$loop" != 'y' ]] && [[ "$loop" != 'n' ]]; then
            echo "Wrong choice !"
        fi
    done
done

echo "Good bye !"