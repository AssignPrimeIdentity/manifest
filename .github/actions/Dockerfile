FROM tensorflow/tensorflow:latest-gpu

LABEL version="v1.0.8"
LABEL homepage="https://eq19.github.io/"
LABEL maintainer="eq19 <admin@rq19.com>"
LABEL repository="https://github.com/FeedMapping/deploy"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt-get -qq update < /dev/null
RUN apt-get -qq install --no-install-recommends apt-utils < /dev/null

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV PATH="${PATH}:/root/.local/bin"

RUN apt-get -qq install python3.8-venv < /dev/null
RUN python3.8 -m venv nvidia < /dev/null
RUN chown -R root nvidia && source nvidia/bin/activate
RUN python -m pip install -U --force-reinstall pip < /dev/null
RUN pip install tensorflow-gpu --root-user-action=ignore --quiet

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV RAILS_VERSION 5.0.1
ENV RUBYOPT=W0

RUN apt-get -qq install ruby ruby-dev ruby-bundler build-essential < /dev/null
RUN apt-get -qq install git < /dev/null && git config --global init.defaultBranch master
RUN apt-get -qq install npm < /dev/null && npm set progress=false && npm install -qq yarn

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* < /dev/null
RUN gem install rails --version "$RAILS_VERSION" < /dev/null

COPY . .
ENTRYPOINT ["/entrypoint.sh"]
