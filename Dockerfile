FROM collelog/synology-buildenv
LABEL maintainer "collelog <collelog.cavamin@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /toolkit/script
ADD syno_make_px4_drv.sh /toolkit/script/
RUN chmod -R 755 /toolkit/script

VOLUME /toolkit/results_file
WORKDIR /toolkit/script
