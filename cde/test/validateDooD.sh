#!/bin/bash

cmd=$(docker ps)

if [[ -z $cmd ]]; then
	echo "Test container instance not found"
fi
