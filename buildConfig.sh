#!/bin/bash

userBuild () {
	imgName="cde"
	imgVersion="latest"
	srcDir="${MODULE_DIR}/src"

	echo $srcDir
	echo "Start building CDE image"

	buildBaseImage

	publishDocker $imgName
}

buildBaseImage () {
	docker build -t $imgName -f $srcDir/Dockerfile $srcDir/
}


