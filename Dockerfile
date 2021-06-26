FROM golang:1.16.5-alpine3.14 as build
ARG VERSION
ARG CHECKSUM
ARG FILENAME=${VERSION}.tar.gz
ENV GO111MODULE on
WORKDIR /tmp
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    wget=1.21.1-r1 \
    make=4.3-r0 \
    build-base=0.5-r2 && \
  echo "**** download static ****" && \
  mkdir /app && \
  wget -q "https://github.com/go-shiori/shiori/archive/${FILENAME}" && \
  echo "${CHECKSUM}  ${FILENAME}" | sha256sum -c && \
  tar -xvf "${FILENAME}" -C /app --strip-components 1
WORKDIR /app
RUN \
  go get -d -v ./... && \
  go install -v ./...

FROM ghcr.io/linuxserver/baseimage-alpine:3.14
ARG BUILD_DATE
ARG VERSION
ENV GOPATH /go
ENV SHIORI_DIR /data
# hadolint ignore=DL3048
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
COPY --from=build --chown=abc:abc /go/bin /go/bin
COPY root/ /
RUN \
  mkdir /data && \
  chown -R abc:abc \
    /data \
    /go
WORKDIR /data
EXPOSE 8080/tcp
VOLUME \
  /data
