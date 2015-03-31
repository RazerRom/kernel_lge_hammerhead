#!/bin/sh

if [ $# -gt 0 ]; then
	echo $1 > .version
fi

buildid=$(( $1 + 1 ))
zipfile="Chroma.Kernel-r$buildid.zip"

. ./env_setup.sh ${1} || exit 1;

if [ -e .config ]; then
	rm .config
fi

cp arch/arm/configs/aosp_defconfig .config >> /dev/null
make aosp_defconfig  >> /dev/null

make -j$NUMBEROFCPUS CONFIG_NO_ERROR_ON_MISMATCH=y

cp arch/arm/boot/zImage-dtb ramdisk/

cd ramdisk/

./mkbootfs boot.img-ramdisk | gzip > ramdisk.gz
./mkbootimg --kernel zImage-dtb --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=hammerhead user_debug=31 msm_watchdog_v2.enable=1' --base 0x00000000 --pagesize 2048 --ramdisk_offset 0x02900000 --tags_offset 0x02700000 --ramdisk ramdisk.gz --output ../boot.img

rm -rf ramdisk.gz
rm -rf zImage
cd ..

if [ -e arch/arm/boot/zImage ]; then
	cp boot.img zip/

	rm -rf ramdisk/boot.img

	cd zip/
	rm -f *.zip
	zip -r -9 $zipfile *
	rm -f /tmp/*.zip
	cp *.zip /tmp
	cd ..
else
	echo "Something goes wrong aborting!"
	return
fi
