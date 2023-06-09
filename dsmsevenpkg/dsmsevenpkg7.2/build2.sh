#!/bin/sh

./build-platform-image.sh -v 7.2 -p cedarview
./build-platform-image.sh -v 7.2 -p evansport
docker push collelog/dsmpkg-env:7.2-cedarview
docker push collelog/dsmpkg-env:7.2-evansport
