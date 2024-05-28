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

erase_sd_card() 
{
    echo ">> Erasing SD-Card..."
    if ls /dev/sda* >/dev/null 2>&1; then
        read -p ">> Are you sure you want to erase /dev/sda? (yes/y/no): " confirm
        if [[ "$confirm" == "yes" || "$confirm" == "y" ]]; then
            echo ">> Erasing in progress..."
            dd if=/dev/zero of=/dev/sda bs=1024M status=progress
            if [ $? -eq 0 ]; then
                echo ">> Erasing completed successfully."
            else
                echo ">> Erasing failed. Please check the device and try again."
            fi
        else
            echo ">> Erasing aborted by user."
        fi
    else
        echo ">> No SD-Card found at /dev/sda."
    fi
}


echo "[=================== Prepare SD-Card Tool ===================]"
usage
require_sudo_privilege
umount_partitions
erase_sd_card