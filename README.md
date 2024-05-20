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
