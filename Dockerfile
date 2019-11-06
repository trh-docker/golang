FROM debian:stretch-slim

RUN mkdir -p /opt/tmp /opt/src /opt/go/bin
ENV GOPATH=/opt/src/ \
    GOBIN=/opt/go/bin \
    PATH=/opt/go/bin:$PATH \
    GO_VERSION=1.11 \
    DEP_VERSION=0.5.4

ADD https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz /opt/tmp/

ADD https://github.com/Masterminds/glide/releases/download/v0.13.2/glide-v0.13.2-linux-amd64.zip /tmp/glide.zip
ADD https://github.com/golang/dep/releases/download/v${DEP_VERSION}/dep-linux-amd64 /tmp/dep

RUN apt update -y && apt-get -y upgrade && apt-get install -y unzip curl git  && apt upgrade -y &&\
    unzip /tmp/glide.zip -d /opt/ && mkdir /opt/bin &&\
    chmod +x /opt/linux-amd64/glide &&\ 
    mv /tmp/dep /opt/go/bin/dep &&\
    ln -s /opt/linux-amd64/glide /bin/glide &&\ 
    tar -C /opt/ -xzf /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    chmod +x /opt/go/bin/* &&\
    ln -s /opt/go/bin/* /bin/ &&\
    rm /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*