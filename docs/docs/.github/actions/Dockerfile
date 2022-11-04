FROM tensorflow/tensorflow:latest-gpu

LABEL version=v1.0.8

ENV DEBCONF_NOWARNINGS="yes"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq < /dev/null

COPY . .

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

ENTRYPOINT ["/entrypoint.sh"]
