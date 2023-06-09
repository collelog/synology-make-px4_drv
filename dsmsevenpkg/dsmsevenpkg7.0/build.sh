#!/bin/sh

./build-base-image.sh -v 7.0
./build-platform-image.sh -v 7.0 -p apollolake
./build-platform-image.sh -v 7.0 -p avoton
./build-platform-image.sh -v 7.0 -p braswell
./build-platform-image.sh -v 7.0 -p broadwell
./build-platform-image.sh -v 7.0 -p broadwellnk
#./build-platform-image.sh -v 7.0 -p broadwellntbap
./build-platform-image.sh -v 7.0 -p bromolow
./build-platform-image.sh -v 7.0 -p cedarview
./build-platform-image.sh -v 7.0 -p denverton
./build-platform-image.sh -v 7.0 -p evansport
./build-platform-image.sh -v 7.0 -p geminilake
./build-platform-image.sh -v 7.0 -p grantley
./build-platform-image.sh -v 7.0 -p purley
./build-platform-image.sh -v 7.0 -p v1000
#./build-platform-image.sh -v 7.0 -p x86
docker push collelog/dsmpkg-env:7.0-base
docker push collelog/dsmpkg-env:7.0-apollolake
docker push collelog/dsmpkg-env:7.0-avoton
docker push collelog/dsmpkg-env:7.0-braswell
docker push collelog/dsmpkg-env:7.0-broadwellnk
#docker push collelog/dsmpkg-env:7.0-broadwellntbap
docker push collelog/dsmpkg-env:7.0-bromolow
docker push collelog/dsmpkg-env:7.0-cedarview
docker push collelog/dsmpkg-env:7.0-denverton
docker push collelog/dsmpkg-env:7.0-evansport
docker push collelog/dsmpkg-env:7.0ho-geminilake
docker push collelog/dsmpkg-env:7.0-grantley
docker push collelog/dsmpkg-env:7.0-purley
docker push collelog/dsmpkg-env:7.0-v1000
#docker push collelog/dsmpkg-env:7.0-x86
