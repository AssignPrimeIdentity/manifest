FROM tensorflow/tensorflow:latest-gpu

LABEL version=v1.0.8

ENV DEBCONF_NOWARNINGS="yes"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq < /dev/null
RUN apt-get install -qq python3.8-venv < /dev/null
RUN /usr/bin/python3.8 -m venv /tf-gpu < /dev/null

ADD . /tf-gpu/maps

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

ENTRYPOINT ["/tf-gpu/maps/entrypoint.sh"]
