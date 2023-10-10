VERSION 0.7

ARG ALPINE_VERSION=3.18

FROM alpine:${ALPINE_VERSION}
COPY .tool-versions .
RUN cat .tool-versions
ARG NODE_VERSION="$(grep nodejs .tool-versions | cut -d \' \' -f 2)"
ARG NODE_IMAGE_VERSION="${NODE_VERSION}-alpine${ALPINE_VERSION}"

FROM node:${NODE_IMAGE_VERSION}
WORKDIR /build

deps:
    RUN apk add make git patch

build:
    FROM +deps
    ARG VERSION=develop
    COPY . .
    RUN VERSION=${VERSION} make
    SAVE ARTIFACT build/web-archives-darkreader_${VERSION}.js AS LOCAL build/web-archives-darkreader_${VERSION}.js
