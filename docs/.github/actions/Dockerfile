FROM tensorflow/tensorflow:latest

LABEL version="1.0.5"
LABEL homepage="https://eq19.github.io/"
LABEL maintainer="eq19 <admin@rq19.com>"
LABEL repository="https://github.com/FeedMapping/deploy"

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV RAILS_VERSION 5.0.1
ENV RUBYOPT=W0

RUN apt-get update && \
    apt-get install -y ruby && \
    apt-get install -y nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    gem install rails --version "$RAILS_VERSION"

COPY . .
ENTRYPOINT ["/entrypoint.sh"]
