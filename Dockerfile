FROM ubuntu:20.04

# Install persistent packages
RUN apt-get update && apt-get install -y  \
  python3 \
  python3-dev \
  python3-pip \
  bash \
  openssl \
  gcc \
  g++ \
  make \
  git \ 
  curl \
  wget \
  zip \
  lzip \
  rar \
  unrar \
  autoconf \
  automake \
  && pip3 install --upgrade pip wheel setuptools \
  && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y iptables sqlite3 net-tools psmisc numactl zlib1g-dev tmux checkinstall
RUN apt-get update && apt-get install -y python3-pydot xvfb libtool libconfig-dev graphviz jq libcap2-bin geoip-database libgeoip-dev p7zip-full mono-utils upx-ucl unace-nonfree cabextract openvpn uthash-dev libarchive-dev software-properties-common 
RUN apt-get update && apt-get install -y libssl-dev unzip libjpeg-dev ssdeep libfuzzy-dev exiftool
RUN apt-get update && apt-get install -y privoxy wkhtmltopdf xfonts-100dpi tcpdump 
RUN apt-get update && apt-get install -y python3-pil subversion uwsgi uwsgi-plugin-python3 python3-pyelftools wireguard


RUN mkdir /sandbox \
  && chown ${USER}:${USER} -R "sandbox"

ADD . /sandbox

RUN cd sandbox \
  && CRYPTOGRAPHY_DONT_BUILD_RUST=1 pip3 install -r requirements.txt \
  && python3 utils/community.py -waf -cr