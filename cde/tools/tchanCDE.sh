#!/bin/bash

containerName="tony57CDEDD"
imageName="tchan_cde:latest"

# Check if CDE image exists
checkImageExists () {
	docker images | grep ${imageName}
}

# Check if container already exists
checkContainerExists () {
	docker ps -a | grep ${containerName}
}

# Print error and exits
fatal () {
	echo $1
	exit 1
}

# Custom setup
customise () {
	:
}

# Command line options
startContainer () {
	if [[ -z $(checkContainerExists) ]]; then
		if [[ -z $(checkImageExists) ]]; then
			docker run -d \
				--name ${containerName} \
				-v $(pwd):/mnt \
				-v /var/run/docker.sock:/var/run/docker.sock \
				tony57/cde tail -f /dev/null > /dev/null 2>&1
			echo "Installing dev tools. Please wait..."
			docker exec ${containerName} bash -c "/opt/tony57/rpm/install_cde.sh"
			echo "Customising environment..."
			customise
			docker commit ${containerName} ${imageName}
			docker rm -f ${containerName}
		fi	
		docker run -d \
			--name ${containerName} \
			-v $(pwd):/mnt \
			-v /var/run/docker.sock:/var/run/docker.sock \
			${imageName} tail -f /dev/null > /dev/null 2>&1
		echo "Done!"
	else
		fatal "Container already exists"
	fi
}

runSession () {
	if [[ -z $(checkContainerExists) ]]; then
		fatal "Container not exists"
	else
		if [[ $(docker ps -a | grep ${containerName}) ]]; then
			docker start ${containerName}
		fi
		docker exec -it ${containerName} /bin/bash
	fi
}

stopContainer () {
	if [[ -z $(checkContainerExists) ]]; then
		fatal "Container not exists"
	else
		docker stop ${containerName}
	fi
}

deleteContainer () {
	if [[ -z $(checkContainerExists) ]]; then
		fatal "Container not exists"
	else
		docker rm -f ${containerName}
	fi
}

reloadContainer () {
	if [[ -z $(checkContainerExists) ]]; then
		fatal "Container not exists"
	else
		stopContainer
		docker start ${containerName}
	fi
}

showHelp () {
	echo "CDEDD helper script"
	echo "start:  Start a container"
	echo "run:    Run interactive session"
	echo "stop:   Stop the container"
	echo "delete: Remove the container"
	echo "reload: Reload the container"
	echo "help:   Print help messages"
}

assertDockerRunning () {
	rv=$(docker images | grep Error)
	if [[ $rv ]]; then
		exit 1
	fi
}

assertDockerRunning
case $1 in
	"start")
		startContainer
		;;
	"run")
		runSession
		;;
	"stop")
		stopContainer
		;;
	"delete")
		deleteContainer
		;;
	"reload")
		reloadContainer
		;;
	"help")
		showHelp
		;;
	*)
		echo -e "Unknown option\n"
		showHelp
		;;
esac
