# Common Development Desktop (CDE)

This repository is a common dependencies for other projects.

It consists of two parts:

* build-tools

This directory contains common workflow scripts for building different projects. To use the tools in another project, first copy the folder to the root directory of the project. Then run the followings:
```
$> ln -sf build-tools/build-local.sh build-local.sh
$> ./build-local.sh
```
To run full workflow, e.g. possible deployment to remote repository, replace `build-local.sh` with `build-deploy.sh`.

For the build flow to work, one needs to add a `buildConfig.sh` at root directory with two functions: userBuild and userBuildLocal. The two functions would be run for the two workflows.

* CDE

This repository provides a helper script to run the docker builder image as a simple development desktop. Refer to the script `tchanCDE.sh` for more detail.
