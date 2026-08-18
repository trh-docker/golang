FROM debian:buster-slim

RUN mkdir -p /opt/tmp /opt/src /opt/go/bin
ENV GOPATH=/opt/src/ \
    GOBIN=/opt/go/bin \
    PATH=/opt/go/bin:$PATH \
    GO_VERSION=1.26.6 \
    GOPROXY=direct \
    GOSUMDB=off

#https://go.dev/dl/go1.26.2.darwin-amd64.pkg
ADD https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz /opt/tmp/

RUN apt update -y && apt-get -y upgrade  && apt-get install -y unzip curl git  && apt upgrade -y &&\
    tar -C /opt/ -xzf /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    chmod +x /opt/go/bin/* &&\
    ln -s /opt/go/bin/* /bin/ &&\
    rm /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*