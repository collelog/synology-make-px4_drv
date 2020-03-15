#!/bin/bash 

function prompt_for_source() {
	DSM_VER=""
	CPU_PKGARCH=""

	PS3="Please select DSM varsion of Synology NAS: "
	options=("DSM 6.2" "DSM 6.1" "Quit")
	select opt in "${options[@]}"
	do
		case $opt in
			"DSM 6.2")
				DSM_VER="6.2"
				break
				;;
			"DSM 6.1")
				DSM_VER="6.1"
				break
				;;
			"Quit")
				exit 1
				break
				;;
			*) echo "invalid option $REPLY";;
		esac
	done

	PS3="Please select CPU package arch of Synology NAS: "
	options=("apollolake" "avoton" "braswell" "broadwell" "broadwellnk" "bromolow" "denverton" "Quit")
	select opt in "${options[@]}"
	do
		case $opt in
			"apollolake")
				CPU_PKGARCH=apollolake
				break
				;;
			"avoton")
				CPU_PKGARCH=avoton
				break
				;;
			"braswell")
				CPU_PKGARCH=braswell
				break
				;;
			"broadwell")
				CPU_PKGARCH=broadwell
				break
				;;
			"broadwellnk")
				CPU_PKGARCH=broadwellnk
				break
				;;
			"bromolow")
				CPU_PKGARCH=bromolow
				break
				;;
			"denverton")
				CPU_PKGARCH=denverton
				break
				;;
			"Quit")
				exit 1
				break
				;;
			*) echo "invalid option $REPLY";;
		esac
	done

	echo "=================================================="
	echo "PATH:"${BASE_PATH}
	echo "DSM version:"${DSM_VER}
	echo "CPU package arch:"${CPU_PKGARCH}
	echo "=================================================="
}

function install_pkgscripts-ng() {
	if [ ! -d "${BASE_PATH}/pkgscripts-ng" ]; then
		echo "--------------------------------------------------"
		echo "install pkgscripts-ng"
		echo "--------------------------------------------------"

		mkdir -p ${BASE_PATH}/pkgscripts-ng
		cd  ${BASE_PATH}/pkgscripts-ng
		curl -fsSL https://github.com/SynologyOpenSource/pkgscripts-ng/tarball/master | tar -xz --strip-components=1
	fi
}

function exec_envdeploy() {
	if [ ! -d "${BASE_PATH}/build_env/ds.${CPU_PKGARCH}-${DSM_VER}" ]; then
		echo "exec EnvDeploy"

		cd ${BASE_PATH}/pkgscripts-ng
		${BASE_PATH}/pkgscripts-ng/EnvDeploy -v ${DSM_VER} -p ${CPU_PKGARCH}
	fi
}

function make_px4_drv() {
	echo "--------------------------------------------------"
	echo "make px4_drv"
	echo "--------------------------------------------------"

	if [ -d "${BASE_PATH}/source/px4_drv" ]; then
		rm -rf ${BASE_PATH}/source/px4_drv
	fi

	mkdir -p ${BASE_PATH}/source/px4_drv
	cd ${BASE_PATH}/source/px4_drv
	curl -fsSL https://github.com/nns779/px4_drv/tarball/develop | tar -xz --strip-components=1
	cd ${BASE_PATH}/source/px4_drv/fwtool
	make
	curl -fsSLO http://plex-net.co.jp/plex/pxw3u4/pxw3u4_BDA_ver1x64.zip
	unzip -oj pxw3u4_BDA_ver1x64.zip pxw3u4_BDA_ver1x64/PXW3U4.sys
	./fwtool PXW3U4.sys it930x-firmware.bin

	cd ${BASE_PATH}/source/px4_drv/driver
	sed -i -e 's/\/lib\/modules\/$(KVER)\/build/$(KSRC)/g' Makefile
	export KVER=${BASE_PATH}/build_env/ds.${CPU_PKGARCH}-${DSM_VER}/usr/local/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-
	export KSRC=${BASE_PATH}/build_env/ds.${CPU_PKGARCH}-${DSM_VER}/usr/local/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/lib/modules/DSM-${DSM_VER}/build
	make

	if [ ! -d "${BASE_PATH}/results_file/px4_drv" ]; then
		mkdir -p ${BASE_PATH}/results_file/px4_drv
	fi
	cp ${BASE_PATH}/source/px4_drv/driver/px4_drv.ko ${BASE_PATH}/results_file/px4_drv/
	cp ${BASE_PATH}/source/px4_drv/fwtool/it930x-firmware.bin ${BASE_PATH}/results_file/px4_drv/

	rm -rf ${BASE_PATH}/source/px4_drv
}

BASE_PATH="/toolkit"

prompt_for_source
install_pkgscripts-ng
exec_envdeploy
make_px4_drv

echo "=================================================="
echo "completed builds."
echo " - ${BASE_PATH}/results_file/px4_drv/px4_drv.ko"
echo " - ${BASE_PATH}/results_file/px4_drv/it930x-firmware.bin"
echo "=================================================="
