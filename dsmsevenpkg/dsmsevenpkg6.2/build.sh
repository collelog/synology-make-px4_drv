#!/bin/sh

./build-base-image.sh -v 6.2
./build-platform-image.sh -v 6.2 -p apollolake
./build-platform-image.sh -v 6.2 -p avoton
./build-platform-image.sh -v 6.2 -p braswell
./build-platform-image.sh -v 6.2 -p broadwell
./build-platform-image.sh -v 6.2 -p broadwellnk
./build-platform-image.sh -v 6.2 -p broadwellntbap
./build-platform-image.sh -v 6.2 -p bromolow
./build-platform-image.sh -v 6.2 -p cedarview
./build-platform-image.sh -v 6.2 -p denverton
./build-platform-image.sh -v 6.2 -p evansport
./build-platform-image.sh -v 6.2 -p geminilake
./build-platform-image.sh -v 6.2 -p grantley
./build-platform-image.sh -v 6.2 -p purley
./build-platform-image.sh -v 6.2 -p v1000
#./build-platform-image.sh -v 6.2 -p x86
docker push collelog/dsmpkg-env:6.2-base
docker push collelog/dsmpkg-env:6.2-apollolake
docker push collelog/dsmpkg-env:6.2-avoton
docker push collelog/dsmpkg-env:6.2-braswell
docker push collelog/dsmpkg-env:6.2-broadwell
docker push collelog/dsmpkg-env:6.2-broadwellnk
docker push collelog/dsmpkg-env:6.2-broadwellntbap
docker push collelog/dsmpkg-env:6.2-bromolow
docker push collelog/dsmpkg-env:6.2-cedarview
docker push collelog/dsmpkg-env:6.2-denverton
docker push collelog/dsmpkg-env:6.2-evansport
docker push collelog/dsmpkg-env:6.2-geminilake
docker push collelog/dsmpkg-env:6.2-grantley
docker push collelog/dsmpkg-env:6.2-purley
docker push collelog/dsmpkg-env:6.2-v1000
#docker push collelog/dsmpkg-env:6.2-x86
