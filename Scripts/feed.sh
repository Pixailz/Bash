#!/bin/bash

function ask(){
    local message=$1
    local default=$2
    [ -z $2 ] && local default="NULL"
    local choice=""
    local loop=1

    if [ $default == "y" ]; then
        printf "${message} (Y/n)"
    elif [ $default == "n" ]; then
        printf "${message} (y/N)"
    else
        printf "${message} (y/n)"
    fi

    read -n 1 choice
    printf "\n"
    choice=$(echo $choice | tr '[A-Z]' '[a-z]')
    if [ $choice != "y" ] && [ $choice != "n" ]; then
        [ $default == "y" ] && return 1
        [ $default == "n" ] && return 0
    fi
    [ $choice == "y" ] && return 1
    [ $choice == "n" ] && return 0
}

function printFeedHelp(){
    printf "Usage: feed <exec_name> <title> <command>\n"
    [ ! -z "$1" ] && printf "ERROR: $1\n"
}

function feed() {
    [ -z "$1" ] && printFeedHelp "need exec name" && return
    [ -z "$2" ] && printFeedHelp "need title" && return
    [ -z "$3" ] && printFeedHelp "need command" && return

    feed_name=$1
    feed_title=$2
    feed_command=$3

    feed_file_path=$(printf "/home/pix/Dinosaure/${feed_name}_command.md")

    if [ ! -f "$feed_file_path" ]; then

        ask "file ${feed_file_path} not found, would you like to create ?" n
        local return_ask=$?

        if [ "$return_ask" == "1" ]; then
            printf "# ${feed_title}\n" > $feed_file_path
            printf "$feed_command\n\n" >> $feed_file_path

        fi

    else
        printf "# ${feed_title}\n" >> $feed_file_path
        printf "$feed_command\n\n" >> $feed_file_path

    fi
}

feed "ffuf" "test_command" "ffuf -w jhojs;dfg -w fsdf sdf"
