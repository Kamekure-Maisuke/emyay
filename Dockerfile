FROM ubuntu:bionic

ENV LANG ja_JP.UTF-8

RUN apt-get update -qq && \
    apt-get -y --no-install-recommends install \
    ca-certificates \
    g++ \
    rsync \
    wget \
    vim \
    locales && \
    locale-gen ja_JP.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN mkdir -p /tmp/emojicode &&  \
    wget -q https://github.com/emojicode/emojicode/releases/download/v1.0-beta.2/Emojicode-1.0-beta.2-Linux-x86_64.tar.gz -O emojicode.tar.gz && \
    tar -xzf emojicode.tar.gz --directory /tmp/emojicode --strip-components=1 && \
    rm emojicode.tar.gz && cd /tmp/emojicode && \
    echo y | ./install.sh && cd && rm -rf /tmp/emojicode

WORKDIR /usr/local/src/emyay
COPY . /usr/local/src/emyay

RUN echo 'finish build'
