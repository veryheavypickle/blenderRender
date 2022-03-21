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

	blenderRecursive
}

blenderRecursive() {
	# get blender files
	local files=($(find $blendDir -maxdepth 1 -name "*.blend"))
	if [ ${#files[@]} > 0 ]; then
		blenderRender ${files[0]}
		blenderRecursive
	fi
}

blenderRender () {
	local filePath=$1
	local fileOutName=$outDir$(basename -- "${filePath%.*}_####")
	#blender -b $file -x 1 -o $fileOutName -a
	rm $filePath
}

main