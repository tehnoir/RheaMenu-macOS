#!/bin/bash

showUsage() {
	echo "This is a helper script for use in conjunction"
	echo "with rmenu for Sega Saturn Rhea."
	echo "This script will iterate through your game directories"
	echo "and create a file with the name of the game in the"
	echo "current dircetory. The purpose is to make it easier to"
	echo "see what games are in numbered directories since the"
	echo "image files themselves must conform to 8.3 naming."
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

getGameTitle() {
	echo `xxd -s 112 -l 130 -ps "$1" | xxd -r -p | sed -e "s/\( \)*/\1/g"`
}

cd $sdCard
for i in $(find . -not -path "." -maxdepth 1 -type d | sort | grep -v "\.\/\." | grep -v "\01"); do
	cd $i

	if [ "$(ls | grep -i \.img)" ]; then
		f=`ls | grep -i \.img`
		game_title=$(title_ccd $f)
		touch "${game_title// /_}"
	fi
	cd ..
done



