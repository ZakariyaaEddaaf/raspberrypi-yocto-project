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

## Basic Yocto layer (Create and add layer)

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

## Basic Yocto Recipes (Write and add the Recipe)

create a recipe, run following commands
```
mkdir meta-eddaaf/recipes-eddaaf
mkdir meta-eddaaf/recipes-eddaaf/helloworld
mkdir meta-eddaaf/recipes-eddaaf/helloworld/files
touch meta-eddaaf/recipes-eddaaf/helloworld/files/main.cpp
touch meta-eddaaf/recipes-eddaaf/helloworld/helloworld_0.1.bb
```
File structure (tree)
```.
├── conf\
│   └── layer.conf\
├── COPYING.MIT\
├── README\
├── recipes-eddaaf\
│   └── hello-world-cpp\
│       ├── files\
│       │   └── main.cpp\
│       └── hello_world_cpp.bb\
└── recipes-example\
    └── example\
        └── example_0.1.bb\
```
Some common terms used in recipes:
```
${WORKDIR} - this is the location inside of your build (after you run source oe-init-build-env) and is referring to: build/tmp/work/<machine_architecture>/<recipe_name>/<recipe_version>
${PN} - Package name, i.e., name of the recipe. Same as the name you gave your .bb file.
${PV} - Package version, i.e., version of the recipe.
SRC_URI = “the file your recipe is built off of.” This can be a .zip, .c, or whichever file you need to build your recipe with.
md5, sha256 - these can be found by typing “openssl md5 <file_name>” into the command line.
```