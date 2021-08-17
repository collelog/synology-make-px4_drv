#!/bin/bash 

function make_px4_drv() {
	echo "--------------------------------------------------"
	echo "make px4_drv"
	echo "--------------------------------------------------"

	if [ -d "${PX4DRV_BUILD_PATH}/source/px4_drv" ]; then
		rm -rf ${PX4DRV_BUILD_PATH}/source/px4_drv
	fi

	mkdir -p ${PX4DRV_BUILD_PATH}/source/px4_drv
	cd ${PX4DRV_BUILD_PATH}/source/px4_drv
	curl -fsSL https://github.com/nns779/px4_drv/tarball/develop | tar -xz --strip-components=1
	cd ${PX4DRV_BUILD_PATH}/source/px4_drv/fwtool
	make
	curl -fsSLO http://plex-net.co.jp/plex/pxw3u4/pxw3u4_BDA_ver1x64.zip
	unzip -oj pxw3u4_BDA_ver1x64.zip pxw3u4_BDA_ver1x64/PXW3U4.sys
	./fwtool PXW3U4.sys it930x-firmware.bin

	cd ${PX4DRV_BUILD_PATH}/source/px4_drv/driver
	sed -i -e 's/\/lib\/modules\/$(KVER)\/build/$(KSRC)/g' Makefile
	sed -i -e 's/\/lib\/modules\/$(KVER)\/misc/$(KSRC)\/misc/g' Makefile

	cp -r ${PX4DRV_BUILD_PATH}/source/px4_drv/driver/ /build_env/usr/local/src/
	cp -r ${PX4DRV_BUILD_PATH}/source/px4_drv/include/ /build_env/usr/local/src/

	export CROSS_COMPILE=/usr/local/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-
	export ARCH=x86_64
	export KSRC=/usr/local/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/lib/modules/DSM-${DSM_VER}/build

	chroot /build_env/ /bin/bash -c 'cd /usr/local/src/driver; make'

	if [ ! -d "${PX4DRV_BUILD_PATH}/results_file/px4_drv" ]; then
		mkdir -p ${PX4DRV_BUILD_PATH}/results_file/px4_drv
	fi
	cp /build_env/usr/local/src/driver/px4_drv.ko ${PX4DRV_BUILD_PATH}/results_file/px4_drv/
	cp ${PX4DRV_BUILD_PATH}/source/px4_drv/fwtool/it930x-firmware.bin ${PX4DRV_BUILD_PATH}/results_file/px4_drv/

	rm -rf /build_env/usr/local/src/*
	rm -rf ${PX4DRV_BUILD_PATH}/source/px4_drv
}

PX4DRV_BUILD_PATH="/build_env/toolkit"

make_px4_drv

echo "=================================================="
echo "completed builds."
echo " - ${PX4DRV_BUILD_PATH}/results_file/px4_drv/px4_drv.ko"
echo " - ${PX4DRV_BUILD_PATH}/results_file/px4_drv/it930x-firmware.bin"
echo "=================================================="
