FROM debian:stretch-slim

ENV GO_VERSION=1.10.7
RUN mkdir /opt/golang /opt/tmp /opt/src

ADD https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz /opt/tmp/
RUN tar -C /usr/local -xzf /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    export PATH=$PATH:/usr/local/go/bin &&\
    export GOPATH=/opt/src/ &&\
    ln -s /usr/local/go/bin/* /bin/ &&\
    rm /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz

ADD https://github.com/Masterminds/glide/releases/download/v0.13.2/glide-v0.13.2-linux-amd64.zip /tmp/glide.zip
ADD https://raw.githubusercontent.com/golang/dep/master/install.sh /tmp/dep.sh

RUN apt update -y && apt upgrade -y && mkdir /opt/src/bin
RUN sh /tmp/dep.sh && ln -s /opt/src/bin/dep /bin/dep
RUN unzip /tmp/glide.zip -d /opt/ && mkdir /opt/bin &&\
    chmod +x /opt/linux-amd64/glide &&\ 
    ln -s /opt/linux-amd64/glide /bin/glide

ENV GOPATH=/opt/src/