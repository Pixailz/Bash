#!/bin/bash
#Password Generator V1

usage (){
	echo -e "Usage: $0 [LEVEL]"
	echo -e "\tH : HIGH"
	echo -e "\tM : MEDIUM"
	echo -e "\tL : LOW"
}

question (){
	echo "This is a simple password generator"
	read -p "Number of password: " PASS_NUMBER
	read -p "Please enter the length of the password: " PASS_LENGTH
}

if [ ! -z "$1" ] && [ "$1" == "H" ]; then
	question
	for p in $(seq 1 $PASS_NUMBER); do
		</dev/urandom tr -dc 'A-Za-z0-9!#$%&*+,-.<=>?@'\' | head -c $PASS_LENGTH  ; echo
	done
elif [ ! -z "$1" ] && [ "$1" == "M" ]; then
	question
	for p in $(seq 1 $PASS_NUMBER); do
		openssl rand -base64 48| cut -c1-$PASS_LENGTH
	done
elif [ ! -z "$1" ] && [ "$1" == "L" ]; then
	question
	for p in $(seq 1 $PASS_NUMBER); do
		openssl rand -hex 48| cut -c1-$PASS_LENGTH
	done
else
	usage
fi