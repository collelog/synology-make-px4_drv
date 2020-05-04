# syno_make_px4_drv.sh
FROM alpine:3.11 AS script-cp

COPY syno_make_px4_drv.sh /tmp
RUN chmod 755 /tmp/syno_make_px4_drv.sh


# final image
FROM collelog/synology-buildenv
LABEL maintainer "collelog <collelog.cavamin@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
COPY --from=script-cp /tmp/syno_make_px4_drv.sh /toolkit/script/

VOLUME /toolkit/results_file
WORKDIR /toolkit/script
