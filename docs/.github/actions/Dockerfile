FROM tensorflow/tensorflow:latest-gpu

LABEL version="v1.0.8"

ENV DEBCONF_NOWARNINGS="yes"
ENV DEBIAN_FRONTEND noninteractive
ENV PATH="${PATH}:/root/.local/bin"

RUN apt-get update -qq < /dev/null
RUN apt-get install -qq git < /dev/null

COPY . .
ENTRYPOINT ["/entrypoint.sh"]
