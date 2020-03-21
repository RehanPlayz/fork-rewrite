FROM debian:10.1-slim

RUN apt-get update 
RUN apt-get -y install apt-utils curl software-properties-common apt-transport-https ca-certificates wget  tar dirmngr gnupg iproute2 libopus0 make g++ locales git  cmake zip unzip
RUN addgroup --gid 998 container 
RUN useradd -r -u 999 -d /home/container -g container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

    # Golang
RUN apt-get update && apt-get -y install golang && go get github.com/bwmarrin/discordgo

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
