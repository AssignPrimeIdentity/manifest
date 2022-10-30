FROM tensorflow/tensorflow:latest

LABEL version="1.0.5"
LABEL homepage="https://eq19.github.io/"
LABEL maintainer="eq19 <admin@rq19.com>"
LABEL repository="https://github.com/FeedMapping/deploy"

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV RUBYOPT=W0

COPY . .
ENTRYPOINT ["/entrypoint.sh"]
