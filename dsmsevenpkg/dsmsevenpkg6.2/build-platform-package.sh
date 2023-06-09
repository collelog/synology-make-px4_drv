#!/bin/bash

source ./dsminfo 2> /dev/null
export dsm_version="$dsm_version_default"
export dsm_platform=""

POSITIONAL=()
while [[ $# -gt 0 ]] ; do
	case $1 in
		-v|--version)
			dsm_version="$2"
			shift
			shift
			;;
		-p|--platform)
			dsm_platform="$2"
			shift
			shift
			;;
		-h|--help)
			echo "Usage: $0 <parameters...>"
			echo "Available parameters:"
			echo "  -v --version   Specify DSM version (default $dsm_version_default)"
			echo "  -p --platform  Specify DSM platform"
			echo "  -h --help      Show this help text"
			exit 0
			;;
		*)
			POSITIONAL+=("$1")
			shift
			;;
	esac
done
set -- "${POSITIONAL[@]}"

if [ -z "$dsm_version" ] ; then echo "No DSM version specified! Check $0 --help"; exit 1; fi
if [ -z "$dsm_platform" ] ; then echo "No DSM platform specified! Check $0 --help"; exit 1; fi

rootdir="$( cd "$(dirname "$0")" ; pwd -P )"
package_source=`readlink -f $1`
container="dsmpkg-$dsm_version-$dsm_platform"
dockercmd="docker exec -it $container"
buildtmp=`mktemp -d -t dsmpkg-build.XXXXXXXX`
pkgtmp=`mktemp -d -t dsmpkg-pkg.XXXXXXXX`

cd "$package_source"
docker run -d --rm -v "$package_source:/source:ro" -v "$buildtmp:/target" --name "$container" "collelog/dsmpkg-env:$dsm_version-$dsm_platform" /bin/bash -c "trap : TERM INT; sleep infinity & wait"
make bootstrap
$dockercmd /bin/bash -c "cp -r /source /source_int; cd /source_int; make build"

cp -r "$package_source/pkgfiles/"* $pkgtmp

cd "$buildtmp"
tar cfz $pkgtmp/package.tgz *
$dockercmd /bin/bash -c "rm -rf /target/*"
docker stop $container
rm -rf $buildtmp

cd "$pkgtmp"
envsubst < INFO > INFO.tmp
mv INFO.tmp INFO
tar cfz "$rootdir/package-$dsm_version-$dsm_platform.unsigned.spk" *
rm -rf "$pkgtmp"

