FROM debian:stretch-slim

RUN mkdir -p /opt/tmp /opt/src /opt/go/bin
ENV GOPATH=/opt/src/ \
    GOBIN=/opt/go/bin \
    PATH=/opt/go/bin:$PATH \
    GO_VERSION=1.10.7

ADD https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz /opt/tmp/
ADD ./files/dep-linux-amd64 /opt/tmp/dep

ADD https://github.com/Masterminds/glide/releases/download/v0.13.2/glide-v0.13.2-linux-amd64.zip /tmp/glide.zip
ADD https://raw.githubusercontent.com/golang/dep/master/install.sh /tmp/dep.sh

RUN unzip /tmp/glide.zip -d /opt/ && mkdir /opt/bin &&\
    chmod +x /opt/linux-amd64/glide &&\ 
    ln -s /opt/linux-amd64/glide /bin/glide &&\ 
    apt update -y && apt-get install -y unzip curl git  && apt upgrade -y &&\
    sh /tmp/dep.sh && ln -s /opt/src/bin/dep /bin/dep &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN tar -C /opt/ -xzf /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    mv /opt/tmp/dep /opt/go/bin/dep &&\
    chmod +x /opt/go/bin/* &&\
    ln -s /opt/go/bin/* /bin/ &&\
    rm /opt/tmp/go${GO_VERSION}.linux-amd64.tar.gz &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*