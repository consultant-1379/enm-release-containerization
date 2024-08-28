#!/bin/bash

docker_image=$1
service_path=$2
image_version=$3

version=$(echo ${image_version} | awk -F "=" '{print $2}')

echo "COMMAND: docker build -f ${service_path} -t armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:${version} --pull ${WORKSPACE}"
docker build -f ${service_path} -t armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:${version} --pull ${WORKSPACE}

echo "COMMAND: docker_image_id=$(docker images armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image} -q)"
docker_image_id=$(docker images armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image} -q)

echo "COMMAND: docker tag ${docker_image_id} armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:latest"
docker tag ${docker_image_id} armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:latest

echo "COMMAND: docker push armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:${version}"
docker push armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:${version}

echo "COMMAND: docker push armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:latest"
docker push armdocker.rnd.ericsson.se/proj_openstack_tooling/${docker_image}:latest
