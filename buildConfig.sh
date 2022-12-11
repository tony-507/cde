#!/bin/bash

imgName="cde"
imgVersion="latest"

source build-tools/docker-client.sh

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
	cmd="docker build -t $imgName -f $srcDir/Dockerfile "
	if [[ ${DEBUG_BUILD} ]]; then
		cmd+="--progress=plain "
	fi
	cmd+="$srcDir"
	$cmd
}

testBaseImage () {
	testReport="${MODULE_DIR}/output/test_detail_cde.xml"
	mkdir -p $(dirname $testReport)
	rm -f $testReport
	touch $testReport

	mount "/var/run/docker.sock:/var/run/docker.sock"
	mount "${MODULE_DIR}:/mnt"
	id=$(startInstance $imgName:$imgVersion)

	if [[ $id ]]; then
		testCnt=$(ls ${MODULE_DIR}/test | grep -c "")
		echo "<testsuite tests=\"$testCnt\">" > $testReport

		echo -e "\nStart CDE tests...\n"
		for t in ${MODULE_DIR}/test/*; do
			fname=$(basename $t)
			testName=${fname%.sh}
			stdout=$(docker exec $id bash /mnt/$fname)

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

		removeInstance $id
	else
		failBuild "Fail to start container"
	fi
}
