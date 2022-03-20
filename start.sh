#!/bin/bash

currentDir=$(pwd)
outDir=$currentDir/output/
blendDir=$currentDir/blender/

main () {
	if ! [ -d "$outDir" ]; then
		mkdir $outDir
	fi
	if ! [ -d "$blendDir" ]; then
		mkdir $blendDir
	fi

	# clean
	find $currentDir -name "*.blend1" -delete

	blenderRender
}

blenderRender () {
	# get first blender file
	local files=($(find $blendDir -maxdepth 1 -name "*.blend"))
	local currentFile=${files[0]}

	# get the base file name
   	local fileOutName=$outDir$(basename -- "${currentFile%.*}_####")
   	#blender -b $file -x 1 -o $fileOutName -a
   	echo "Lol $fileOutName"
   	rm $currentFile

	# If there are still files, then restart
	if [ ${#files} != "0" ]; then
		blenderRender
	fi
}

main