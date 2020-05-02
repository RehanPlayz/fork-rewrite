FROM python:3.8.1-slim-buster

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install apt-utils ffmpeg youtube-dl curl python3-pip libffi-dev software-properties-common apt-transport-https ca-certificates wget dirmngr gnupg iproute2 make g++ locales git cmake libespeak-dev espeak
RUN addgroup --gid 998 container 
RUN useradd -r -u 999 -d /home/container -g container -m container


    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

    # Python3
RUN apt-get update && apt-get -y install python3.7 python3-pip libffi-dev \
    && pip3 install aiohttp websockets pynacl opuslib \
    && python3 -m pip install -U discord.py[voice]

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
