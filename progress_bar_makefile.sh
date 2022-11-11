#!/bin/bash

SRC_C=(
	"ft_strncmp.c"
	"ft_itoa.c"
	"ft_ipstr.c"
	"ft_int4_comp.c"
	"ft_int4_dcomp.c"
	"ft_int4_inc.c"
	"ft_int4_dec.c"
)

LENGTH_BAR=25
CHAR_DONE="\033[32m-\033[0m"
CHAR_HEAD=">"
CHAR_LEFT=" "

function	print_progress_bar()
{
	local	file_name=${1}
	local	position=${2}
	local	file_name_len=${#file_name}
	local	pourcentage_done=$((${position} * ${LENGTH_BAR} / ${NUMBER_ITEM}))
	local	pourcentage_left=$((${LENGTH_BAR} - ${pourcentage_done}))

	printf "["
	for i in $(seq 2 ${pourcentage_done}); do
		printf "%b" "${CHAR_DONE}"
	done
	if [ ${pourcentage_left} != 0 ]; then
		printf "%b" "${CHAR_HEAD}"
	else
		printf "%b" "${CHAR_DONE}"
	fi
	for i in $(seq 1 ${pourcentage_left}); do
		printf "%b" "${CHAR_LEFT}"
	done
	printf "\033[K"
	printf "] %s %%\n" $((${position} * 100 / ${NUMBER_ITEM}))
	printf "\033[2K"
	printf "(%s)\n" "${file_name}"
	printf "\033[2F"
	sleep 2
}

NUMBER_ITEM=${#SRC_C[@]}

for i in $(seq ${#SRC_C[@]}); do
	i=$((${i} - 1))
	print_progress_bar ${SRC_C[${i}]} $(($i + 1))
done
printf "\033[2E"
