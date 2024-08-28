#!/bin/bash

function run_dockerfile_linter() {
    files_changed=$(cat < diff.txt)
    echo "*********************************************"
    echo "*         Running Dockerfile Linter         *"
    echo "*********************************************"
    echo -e "\n"
    for file_name in ${files_changed}; do
        if [[ "${file_name}" == *"Dockerfile"* ]]; then
            echo "COMMAND: docker run --rm -i armdocker.rnd.ericsson.se/dockerhub-ericsson-remote/hadolint/hadolint < ${file_name}"
            docker run --rm -i armdocker.rnd.ericsson.se/dockerhub-ericsson-remote/hadolint/hadolint < ${file_name}
            if [[ $? -ne 0 ]]; then
                echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
                echo "ERROR: Dockerfile ${file_name} has linting issues. Check above output for more info"
                echo "See this URL for help on linter rules : https://github.com/hadolint/hadolint#rules "
                echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
                exit_code=1
            else
                echo "==================================================="
                echo "SUCCESS : Dockerfile linter passed for ${file_name}"
                echo "==================================================="
            fi
            echo -e "\n"
        fi
    done


}

function check_result() {
    if [[ ${exit_code} -eq 1 ]]; then
        echo "======================================================="
        echo "Error : Some Dockerfiles did not pass the linter checks"
        echo "======================================================="
        exit 1
    fi
    echo "==========================================="
    echo "SUCCESS : All Dockerfiles passed the linter"
    echo "==========================================="
    echo -e "\n"
}

########################
#     SCRIPT START     #
########################
run_dockerfile_linter
check_result