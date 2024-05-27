#!/bin/bash

NUM_OF_ARGS=$#
usage()
{
    if [ "${NUM_OF_ARGS}" -ne 1 ];then
            echo ">> Usage: $(basename $0) <action>"
            exit 1
    fi
}
require_sudo_privilege() 
{
    if [[ $EUID -ne 0 ]]; then
        echo ">> This script requires sudo privileges."
        exit 1
    fi
}

umount_partitions() 
{
    echo ">> Unmounting partitions..."
    if ls /dev/sda* >/dev/null 2>&1; then
        for partition in /dev/sda*; do
            if [ -b "$partition" ]; then
                umount "$partition" 2>/dev/null && echo ">> Unmounted $partition"
            fi
        done
        echo ">> Partitions unmounted"
    else
        echo ">> No partitions found for unmounting."
    fi
}


echo "[=============== Prepare Sd-Card Tool ===============]"
usage
require_sudo_privilege
umount_partitions