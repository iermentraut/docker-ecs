#!/bin/sh -xe

addgroup \
    -g 1001 \
    application

adduser \
    -u 1001 \
    -G application \
    -g "" \
    -S \
    -s /bin/sh \
    -D \
    -h /application \
    application

chmod 755 /application

chown -R application:application /application
