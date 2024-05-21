# Custom Yocto image for RaspberryPi 4

## Prerequisite
+ RaspberryPi 4
+ Sd-card (Me:32G)
+ Linux OS (Me:Debian 12)

## Dependencies
```
sudo apt update
sudo apt install bc build-essential chrpath cpio diffstat gawk git python texinfo wget gdisk
```

## Get started

clone poky (reference distribution) kirkstone branch (LTS)
```
mkdir yocto && cd yocto
git clone -b kirkstone http://git.yoctoproject.org/git/poky
cd poky 
```
clone raspberrypi meta-layer kirkstone branch as well

```
git clone -b kirkstone git://git.yoctoproject.org/meta-raspberrypi 
```
list supported raspberrypi boards execute following commad:
```
ls poky/meta-raspberrypi/conf/machine
```

install python3 in the image, add the following to local.conf

```
IMAGE_INSTALL:append = " python3"
```
