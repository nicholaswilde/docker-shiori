FROM golang:1.14.15-alpine3.13 as build
ARG VERSION
ARG CHECKSUM=c2ebc0f009feb22f891c7ab0fa7b8c0d71e1cfc34a974c7503a702ec07d8e9ee
ARG FILENAME=${VERSION}.tar.gz
ENV GO111MODULE on
WORKDIR /tmp
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    wget \
    make=4.3-r0 \
    build-base=0.5-r2 && \
  echo "**** download static ****" && \
  mkdir /app && \
  wget "https://github.com/go-shiori/shiori/archive/${FILENAME}" && \
  echo "${CHECKSUM}  ${FILENAME}" | sha256sum -c && \
  tar -xvf "${FILENAME}" -C /app --strip-components 1
WORKDIR /app
RUN \
  go get -d -v ./... && \
  go install -v ./...

FROM ghcr.io/linuxserver/baseimage-alpine:3.13
ARG BUILD_DATE
ARG VERSION
ENV GOPATH /go
ENV SHIORI_DIR /data
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
COPY --from=build --chown=abc:abc /go /go
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
#ENTRYPOINT ["/go/bin/shiori", "serve"]
