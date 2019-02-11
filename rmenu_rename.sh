#!/bin/bash

showUsage() {
	echo "This script is for use with rmenu for the"
	echo "Sega Saturn Rhea."
	echo "Simply renames directories already on an"
	echo "SD card for rmenu to be sequentially numbered."
	echo ""
	echo "Options:"
	echo "-h        Show this help text"
	echo "-p [path] Path to Rhea SD card"
	echo ""
	echo "Further Information"
	echo "-------------------"
	echo "For full information, see:"
	echo "http://github.com/megatron-uk/RheaMenu-Linux"
	echo ""	
}

while getopts ":d:h" opt; do
	case $opt in
		d)
			sdCard="$OPTARG"
			;;
		h)
			showUsage
			exit 0
			;;
		:)
			echo "Option -$OPTARG requires a value." >&2
			exit 1
			;;
	esac
done

gameTitle() {
	echo `xxd -s 112 -l 130 -ps "$1" | xxd -r -p | sed -e "s/\( \)*/\1/g"`
}

# Make our first dir 02, and go up from there.
cd $sdCard
count=2
for i in $(find . -not -path "." -maxdepth 1 -type d | sort | grep -v "\.\/\." | grep -v "\01"); do
	newDirectoryName=$(printf "%02d" $count)
	mv $i $newDirectoryName
	count=$((count+1))
done



