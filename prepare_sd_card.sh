#!/bin/bash

NUM_ARG=$#
ACT_VAR=${1}
SDC_PAR=${2}
IMG_DIR="../build/tmp/deploy/images/raspberrypi4-64"
IMG_BZ2="eddaaf-image-minimal-raspberrypi4-64-20240526211022.rootfs.wic.bz2"
IMG_WIC="eddaaf-image-minimal-raspberrypi4-64-20240526211022.rootfs.wic"
IMG_EXT="${IMG_DIR}/${IMG_BZ2}"

usage()
{
    if [ "${NUM_ARG}" -ne 2 ];then
            echo ">> Usage: $(basename $0) <action> <patition>"
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
    if ls /dev/${SDC_PAR}* >/dev/null 2>&1; then
        for partition in /dev/${SDC_PAR}*; do
            if [ -b "$partition" ]; then
                umount "$partition" 2>/dev/null && echo ">> Unmounted $partition"
            fi
        done
        echo ">> Partitions unmounted"
    else
        echo ">> No partitions found for unmounting."
        exit 1
    fi
}

erase_sd_card() 
{
    echo ">> Erasing SD-Card..."
    if ls /dev/${SDC_PAR}* >/dev/null 2>&1; then
        read -p ">> Are you sure you want to erase /dev/${SDC_PAR}? (yes/y/no): " confirm
        if [[ "$confirm" == "yes" || "$confirm" == "y" ]]; then
            echo ">> Erasing in progress..."
            dd if=/dev/zero of=/dev/${SDC_PAR} bs=5024M status=progress
            if [ $? -eq 0 ]; then
                echo ">> Erasing completed successfully."
            else
                echo ">> Erasing failed. Please check the device and try again."
                exit 1
            fi
        else
            echo ">> Erasing aborted by user."
            exit 1
        fi
    else
        echo ">> No SD-Card found at /dev/${SDC_PAR}."
        exit 1
    fi
}

flash_sd_card()
{
    echo ">> Flashing SD-Card..."
    if ls /dev/${SDC_PAR}* >/dev/null 2>&1; then
        read -p ">> Are you sure you want to flash /dev/${SDC_PAR}? (yes/y/no): " confirm
        if [[ "$confirm" == "yes" || "$confirm" == "y" ]]; then
            echo ">> Flashing in progress..."
            dd if=${IMG_WIC} of=/dev/${SDC_PAR} bs=8M status=progress
            if [ $? -eq 0 ]; then
                echo ">> Flashing completed successfully."
            else
                echo ">> Flashing failed. Please check the device and try again."
                exit 1
            fi
        else
            echo ">> Flashing aborted by user."
            exit 1
        fi
    else
        echo ">> No SD-Card found at /dev/${SDC_PAR}."
        exit 1
    fi
}

extract_wic_img()
{
    echo ">> Extracting b2z image..."
    if ls ${IMG_EXT} > /dev/null 2>&1;then
        cp ${IMG_EXT} .
        echo ">> Extract in progress..."
        bunzip2 ${IMG_BZ2}
        if [ $? -eq 0 ]; then
            echo ">> Exctracting completed successfully."
        else
            echo ">> Exctracting failed."
            exit 1
        fi
    else
        echo ">> No b2z image found."
        exit 1
    fi
}

echo "[=================== Prepare SD-Card Tool ===================]"
usage
require_sudo_privilege
case ${ACT_VAR} in

    flash)
        umount_partitions
        erase_sd_card
        extract_wic_img
        flash_sd_card
    ;;
    erase)
        umount_partitions
        erase_sd_card
    ;;
    unmount)
        umount_partitions
    ;;
    extract)
        extract_wic_img
    ;;
    *)
        usage
esac
echo "[=========================== Done ===========================]"