#!/bin/bash

apps=("python3" "node" "npm" "java") 

for app in ${apps[@]}; do
	if [[ -z $(command -v $app) ]]; then
		echo "$app not found"
	fi
done
