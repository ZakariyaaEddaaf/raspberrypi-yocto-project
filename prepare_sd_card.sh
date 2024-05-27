#!/bin/bash

NUM_OF_ARGS=$#
usage()
{
    if [ "${NUM_OF_ARGS}" -ne 1 ];then
            echo "Usage: $(basename $0) <action>"
            exit 1
    fi
}
require_sudo_privilege() 
{
    if [[ $EUID -ne 0 ]]; then
        echo "This script requires sudo privileges."
        exit 1
    fi
}

echo "[=============== Prepare Sd-Card Tool ===============]"
usage
require_sudo_privilege