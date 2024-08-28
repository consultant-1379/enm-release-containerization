#!/bin/bash

image_version=$1

version=$(echo ${image_version} | awk -F "=" '{print $2}')

echo "COMMAND: git add VERSION"
git add VERSION

echo "COMMAND: git commit -m "Version ${version}""
git commit -m "Version ${version}"

echo "COMMAND: git tag -a "${version}" -m "version ${version}""
git tag -a "${version}" -m "version ${version}"

echo "COMMAND: git rebase HEAD gcn/master"
git rebase HEAD gcn/master

echo "COMMAND: git push ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.oss.ci.rtd/enm-release-containerization HEAD:master"
git push ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.oss.ci.rtd/enm-release-containerization HEAD:master

echo "COMMAND: git push --tags ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.oss.ci.rtd/enm-release-containerization"
git push --tags ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.oss.ci.rtd/enm-release-containerization
