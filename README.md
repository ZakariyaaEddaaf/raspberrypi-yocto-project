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

Set the target machine, by default is "qemux86-64".
```
# MACHINE ??= "qemux86-64"
MACHINE ??= "raspberrypi4"
```

Enable UART for serial console, add following variable to "conf/local.conf"
```
ENABLE_UART = "1"
```

for preparing build environment and use bitbake source "oe-init-build-env" script.
the "oe-init-build-env" will create a "build" folder and change auto. dir. to it.
run following commad:   
```
. oe-init-build-env
```
list supported raspberrypi boards run following commad:
```
ls poky/meta-raspberrypi/conf/machine
```

install python3 in the image, add the following to local.conf

```
IMAGE_INSTALL:append = " python3"
```

Shell environment set up for builds, saved under "conf-notes.txt" file
```
cat meta/conf/conf-notes.txt
```

## Basic Yocto layer

Show existing layers, run following command
```
bitbake-layers show-layers
```
create layer (supposed from build dir), run following command
```
bitbake-layers create-layer ../meta-eddaaf
```
Add layer to build configuration, run following command
```
bitbake-layers add-layer ../meta-eddaaf
```
create a directory inside "meta-eddaaf"

## Basic Yocto Recipes

create a recipes, run following commands
```
mkdir meta-customlayer/recipes-eddaaf
mkdir meta-customlayer/recipes-eddaaf/files
touch meta-customlayer/recipes-eddaaf/files/main.cpp
mkdir meta-customlayer/recipes-eddaaf/hello-world-cpp
touch meta-customlayer/recipes-eddaaf/hello_world_cpp.bb

```
├── conf
│   └── layer.conf
├── COPYING.MIT
├── README
├── recipes-eddaaf
│   ├── files
│   │   └── main.cpp
│   ├── hello-world-cpp
│   └── hello_world_cpp.bb
└── recipes-example
    └── example
        └── example_0.1.bb
