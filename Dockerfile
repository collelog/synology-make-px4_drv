FROM collelog/synology-buildenv
LABEL maintainer "collelog <collelog.cavamin@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

COPY syno_make_px4_drv.sh /toolkit/script/
RUN set -eux && \
	chmod -R 755 /toolkit/script

VOLUME /toolkit/results_file
WORKDIR /toolkit/script
