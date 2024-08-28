#!/bin/bash

function clean_up() {
    
    running=$(docker ps -a -q | wc -l)
    if [[ ${running} -gt 0 ]]; then
        echo "INFO: Killing containers"
        docker rm -f $(docker ps -a -q)
    fi

    time docker-compose down -v

}

########################
#     SCRIPT START     #
########################
clean_up