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

	# get blender files
	local files=($(find $blendDir -name "*.blend" -maxdepth 1))
	for file in "${files[@]}"; do
   		blenderRender $file
	done
}

blenderRender () {
	local filePath=$1
	local fileBaseName=$(basename -- "${filePath%.*}")
	blender -b $file -x 1 -o $outDir/$fileBaseName_ -a
}

main