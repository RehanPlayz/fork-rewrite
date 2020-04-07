FROM python:2.7.17-slim-buster

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install apt-utils curl python3-pip libffi-dev software-properties-common apt-transport-https ca-certificates wget dirmngr gnupg iproute2 make g++ locales git cmake
RUN addgroup --gid 998 container 
RUN useradd -r -u 999 -d /home/container -g container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

    # Python3
RUN apt-get update && apt-get -y install python2.7 pip libffi-dev mono-complete \
    && pip install aiohttp websockets pynacl opuslib \
    && python2.7 -m pip install -U discord.py[voice]

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
