#!/bin/sh

./build-base-image.sh -v 7.1
./build-platform-image.sh -v 7.1 -p apollolake
./build-platform-image.sh -v 7.1 -p avoton
./build-platform-image.sh -v 7.1 -p braswell
./build-platform-image.sh -v 7.1 -p broadwell
./build-platform-image.sh -v 7.1 -p broadwellnk
./build-platform-image.sh -v 7.1 -p broadwellntbap
./build-platform-image.sh -v 7.1 -p bromolow
./build-platform-image.sh -v 7.1 -p cedarview
./build-platform-image.sh -v 7.1 -p denverton
./build-platform-image.sh -v 7.1 -p evansport
./build-platform-image.sh -v 7.1 -p geminilake
./build-platform-image.sh -v 7.1 -p grantley
./build-platform-image.sh -v 7.1 -p purley
./build-platform-image.sh -v 7.1 -p v1000
#./build-platform-image.sh -v 7.1 -p x86
docker push collelog/dsmpkg-env:7.1-base
docker push collelog/dsmpkg-env:7.1-apollolake
docker push collelog/dsmpkg-env:7.1-avoton
docker push collelog/dsmpkg-env:7.1-braswell
docker push collelog/dsmpkg-env:7.1-broadwellnk
docker push collelog/dsmpkg-env:7.1-broadwellntbap
docker push collelog/dsmpkg-env:7.1-bromolow
docker push collelog/dsmpkg-env:7.1-cedarview
docker push collelog/dsmpkg-env:7.1-denverton
docker push collelog/dsmpkg-env:7.1-evansport
docker push collelog/dsmpkg-env:7.1ho-geminilake
docker push collelog/dsmpkg-env:7.1-grantley
docker push collelog/dsmpkg-env:7.1-purley
docker push collelog/dsmpkg-env:7.1-v1000
#docker push collelog/dsmpkg-env:7.1-x86
