#!/bin/bash

source ./dsminfo 2> /dev/null
dsm_version="$dsm_version_default"
dsm_platform=""

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
			echo "Parameter $1 is not supported! Check $0 --help"
			exit 1
			;;
	esac
done

if [ -z "$dsm_version" ] ; then echo "No DSM version specified! Check $0 --help"; exit 1; fi
if [ -z "$dsm_platform" ] ; then echo "No DSM platform specified! Check $0 --help"; exit 1; fi

docker build -f Dockerfile.platform -t collelog/dsmpkg-env:"$dsm_version"-"$dsm_platform" --build-arg dsm_version="$dsm_version" --build-arg dsm_platform="$dsm_platform" .

