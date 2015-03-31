#!/bin/bash

if [ ! -e /usr/bin/ccache ]; then
	echo "You must install 'ccache' to continue.";
	sudo apt-get install ccache
fi

export ARCH=arm;
export SUB_ARCH=arm;
export USER=`whoami`;
export TMPFILE=`mktemp -t`;
export KBUILD_BUILD_USER="TomorrowLandAce";
export KBUILD_BUILD_HOST="PokeCenter";
export CROSS_COMPILE=../toolchain/arm-eabi-4.9.3/bin/arm-eabi-;
export NUMBEROFCPUS=`grep 'processor' /proc/cpuinfo | wc -l`;
