FROM golang:1.17-alpine AS build-env
ADD . /src
RUN cd /src && go build -o goapp

FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        unzip \
        wget \
        pkg-config \
        libvips-dev
WORKDIR /app
COPY --from=build-env /src/ /app/
ENTRYPOINT ./goapp