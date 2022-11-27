#!/bin/bash

apps=("make" "python3" "go" "node" "npm" "java" "ansible")

for app in ${apps[@]}; do
	if [[ -z $(command -v $app) ]]; then
		echo "$app not found"
	fi
done
