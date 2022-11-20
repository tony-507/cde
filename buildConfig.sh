#!/bin/bash

userBuildLocal () {
	imgName="cde"
	imgVersion="latest"
	srcDir="${MODULE_DIR}/src"

	docker build -t $imgName:$imgVersion -f $srcDir/Dockerfile $srcDir/.
}

userBuild () {
	userBuildLocal
	publishDocker $imgName $imgVersion
}
