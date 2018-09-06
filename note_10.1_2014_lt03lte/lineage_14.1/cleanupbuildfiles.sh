#!/bin/bash

SAUCE=~/android/lineage/out/target/product/lt03lte
DEVICE=lt03lte

if [ -e $SAUCE/system/build.prop ]; then
	rm $SAUCE/system/build.prop
fi

if [ -e $SAUCE/obj/KERNEL_OBJ ]; then
	rm -r $SAUCE/obj/KERNEL_OBJ
fi

if [ -e $SAUCE/boot.img ]; then
	rm $SAUCE/boot.img
fi

if [ -e $SAUCE/cache.img ]; then
	rm $SAUCE/cache.img
fi

if [ -e $SAUCE/recovery.img ]; then
	rm $SAUCE/recovery.img
fi

if [ -e $SAUCE/userdata.img ]; then
	rm $SAUCE/userdata.img
fi

if [ -e $SAUCE/system.img ]; then
	rm $SAUCE/system.img
fi

if [ -e $SAUCE/ramdisk.img ]; then
	rm $SAUCE/ramdisk.img
fi

if [ -e $SAUCE/ramdisk-recovery.cpio ]; then
	rm $SAUCE/ramdisk-recovery.cpio
fi

if [ -e $SAUCE/ramdisk-recovery.img ]; then
	rm $SAUCE/ramdisk-recovery.img
fi

if [ -e $SAUCE/dt.img ]; then
	rm $SAUCE/dt.img
fi

if [ -e $SAUCE/kernel ]; then
	rm $SAUCE/kernel
fi

if [ -e $SAUCE/android-info.txt ]; then
	rm $SAUCE/android-info.txt
fi

if [ -e $SAUCE/build_fingerprint.txt ]; then
	rm $SAUCE/build_fingerprint.txt
fi

if [ -e $SAUCE/clean_steps.mk ]; then
	rm $SAUCE/clean_steps.mk
fi

if [ -e $SAUCE/installed-files.json ]; then
	rm $SAUCE/installed-files.json
fi

if [ -e $SAUCE/installed-files.txt ]; then
	rm $SAUCE/installed-files.txt
fi

if [ -e $SAUCE/ota_script_path ]; then
	rm $SAUCE/ota_script_path
fi

if [ -e $SAUCE/previous_build_config.mk ]; then
	rm $SAUCE/previous_build_config.mk
fi

if [ -e $SAUCE/recovery.id ]; then
	rm $SAUCE/recovery.id
fi

if [ -e $SAUCE/lineage-14.1-*-UNOFFICIAL-$DEVICE.zip ]; then
	rm $SAUCE/lineage-14.1-*-UNOFFICIAL-$DEVICE.zip
fi

if [ -e $SAUCE/lineage_$DEVICE-ota-*.zip ]; then
	rm $SAUCE/lineage_$DEVICE-ota-*.zip
fi

if [ -e $SAUCE/lineage-14.1-*-UNOFFICIAL-$DEVICE.zip.md5sum ]; then
	rm $SAUCE/lineage-14.1-*-UNOFFICIAL-$DEVICE.zip.md5sum
fi
