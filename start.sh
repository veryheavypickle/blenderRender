#!/bin/bash

currentDir=$(pwd)
outDir=$currentDir/output/
blendDir=$currentDir/input/

main () {
	if ! [ -d "$outDir" ]; then
		mkdir $outDir
	fi
	if ! [ -d "$blendDir" ]; then
		mkdir $blendDir
	fi

	# clean
	find $currentDir -name "*.blend1" -delete

	blenderRecursive
}

blenderRecursive() {
	# get blender files
	local files=($(find $blendDir -maxdepth 1 -name "*.blend"))
	# if length of files is greater than 0
	if [ ${#files[@]} -gt 0 ]; then
		blenderRender ${files[0]}
		blenderRecursive
	fi
}

blenderRender () {
	local filePath=$1
	local fileOutName=$outDir$(basename -- "${filePath%.*}_####")
	blender -b $filePath -x 1 -o $fileOutName -a
	rm $filePath
}

main