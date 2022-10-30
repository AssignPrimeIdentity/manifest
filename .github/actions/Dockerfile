FROM tensorflow/tensorflow:latest

LABEL version="1.0.5"
LABEL homepage="https://eq19.github.io/"
LABEL maintainer="eq19 <admin@rq19.com>"
LABEL repository="https://github.com/FeedMapping/deploy"

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV RAILS_VERSION 5.0.1
ENV RUBYOPT=W0

RUN apt-get update && apt install -y git
RUN apt-get install -y npm && npm install -g yarn
RUN apt-get install -y ruby ruby-dev ruby-bundler build-essential
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . .
ENTRYPOINT ["/entrypoint.sh"]
