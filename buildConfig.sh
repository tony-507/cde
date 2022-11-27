#!/bin/bash

imgName="cde"
imgVersion="latest"

userBuild () {
	srcDir="${MODULE_DIR}/src"

	echo $srcDir
	echo "Start building CDE image"

	buildBaseImage

	publishDocker $imgName
}

userTest () {
	testBaseImage
}

buildBaseImage () {
	docker build -t $imgName \
		-f $srcDir/Dockerfile \
		--progress=plain \
		$srcDir/
}

testBaseImage () {
	testReport="${MODULE_DIR}/output/test_detail_cde.xml"
	containerName="testContainer"
	mkdir -p $(dirname $testReport)
	rm -f $testReport
	touch $testReport

	echo "Starting CDE container..."
	docker run -d -v ${MODULE_DIR}/test:/mnt -v /var/run/docker.sock:/var/run/docker.sock --name $containerName $imgName tail -f /dev/null

	testCnt=$(ls ${MODULE_DIR}/test | grep -c "")
	echo "<testsuite tests=\"$testCnt\">" > $testReport

	echo -e "\nStart CDE tests...\n"
	for t in ${MODULE_DIR}/test/*; do
		fname=$(basename $t)
		testName=${fname%.sh}
		stdout=$(docker exec $containerName bash /mnt/$fname)

		echo "  <testcase classname=\"cde\" name=\"$testName\">" >> $testReport

		if [[ -z $stdout ]]; then
			echo -e "[PASS] $testName\n"
		else
			echo -e "[FAIL] $testName\n"
			echo "    <failure type=\"unknown\">$stdout</failure>" >> $testReport
		fi
		echo "  </testcase>" >> $testReport
	done

	echo "</testSuite>" >> $testReport

	echo "Removing CDE container..."
	docker rm -f $containerName
}
