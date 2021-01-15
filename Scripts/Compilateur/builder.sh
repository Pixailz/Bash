#!/bin/bash
# Alpha version
# Script by Pixailz
# Kernel Source by DJY (https://github.com/johanlike/DJY-Nethunter-Andrax-Kernel-Source)

mainMenu (){
	loopMainMenu=true
	choiceMainMenu=""
  
	while [[ "$loopMainMenu" == true ]]; do
		clear
    
		echo "Main menu"
		echo "  1 : Download and build DJY-Kernel"
		read -p "root@builder:~# " choiceMainMenu
    
		if [[ "$choiceMainMenu" == "1" ]]; then
			loopMainMenu=false
		else
			echo "Wrong choice !"
		sleep 1.5
		fi
	done
}

downloadDJY (){
	if [[ ! -d DJY-Nethunter-Andrax-Kernel-Source ]]; then
		echo -e "\nDownloading source dir\n"
		git clone https://github.com/johanlike/DJY-Nethunter-Andrax-Kernel-Source
	else
		echo -e "\nSource dir already exist\n"
	fi
  
	if [[ ! -d DJY-Clang-Binutils-Comprehensive-Toolchains ]]; then
		echo -e "\nDownloading toolchain\n"
		git clone https://github.com/johanlike/DJY-Clang-Binutils-Comprehensive-Toolchains
	else
		echo -e "\nToolchain dir already exist\n" 
	fi
}

confirmDJY (){
	echo -e "\nExporting some utils var\n"
	currentPath=$(pwd)
	sourcePath=$(echo $currentPath)/DJY-Nethunter-Andrax-Kernel-Source
	toolchainPath=$(echo $currentPath)/DJY-Clang-Binutils-Comprehensive-Toolchains/bin/aarch64-linux-gnu-
  
	echo -e "Current Path :\t\t$(echo $currentPath)"
	echo -e "Source Path :\t\t$(echo $sourcePath)"
	echo -e "ToolchainPath :\t\t$(echo $toolchainPath)\n"
	read -p "press q to quit" -n 1 choiceConfirm

	case $choiceConfirm in 
		[qQnN]*) exit 1;;
	esac
}

exportDJY (){
	export ARCH=arm64
	export CROSS_COMPILE=$(echo $toolchainPath)
	export CONFIG_BUILD_ARM64_DT_OVERLAY=y
	export LITTLE_CPU_MASK=15
	export BIG_CPU_MASK=240
	#export MAC80211=y
	#export WLAN_VENDOR_RALINK=y
}

buildDJY (){
  cd $(echo $sourcePath)
  echo -e "\nMake (1/5) clean\n"
	make clean
	make mrproper
	make CC=clang O=./out clean
	make CC=clang O=./out mrproper
	
	echo -e "\nMake (2/5) config\n"
	#make CC=clang O=./out sdm845-perf_defconfig
	make CC=clang O=./out oneplus6_defconfig
 
	echo -e "\nMake (3/5) prepare\n"
 	make CC=clang O=./out prepare
	make CC=clang O=./out modules_prepare
    
	echo -e "\nMake (4/5) modules\n"
	make CC=clang O=./out modules
    
	echo -e "\nMake (5/5) final\n"
	make CC=clang O=./out
}

mainMenu

downloadDJY

confirmDJY

exportDJY

buildDJY