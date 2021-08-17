FROM collelog/dsmpkg-env:7.0-purley as build_env

COPY syno_make_px4_drv.sh /toolkit/script/
RUN chmod 755 /toolkit/script/syno_make_px4_drv.sh

# final image
FROM collelog/dsmpkg-env:base-ubuntu
LABEL maintainer "collelog <collelog.cavamin@gmail.com>"

ENV DSM_VER="7.0"

COPY --from=build_env / /build_env

ENTRYPOINT ["/build_env/toolkit/script/syno_make_px4_drv.sh"]
