FROM tensorflow/tensorflow:latest-gpu

LABEL version="1.0.6"
LABEL homepage="https://eq19.github.io/"
LABEL maintainer="eq19 <admin@rq19.com>"
LABEL repository="https://github.com/FeedMapping/deploy"

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV DEBIAN_FRONTEND noninteractive
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV DEBCONF_NOWARNINGS="yes"
ENV RAILS_VERSION 5.0.1
ENV RUBYOPT=W0

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils

RUN python3 -mvenv myvenv
RUN myvenv/venv/pip install --upgrade pip

RUN apt-get install -y npm && npm install -g yarn
RUN apt-get install -y ruby ruby-dev ruby-bundler build-essential
RUN apt-get install -y git && git config --global init.defaultBranch master

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install rails --version "$RAILS_VERSION"

COPY . .
ENTRYPOINT ["/entrypoint.sh"]
