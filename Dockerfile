FROM debian:10.1-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-utils curl software-properties-common openssl apt-transport-https ca-certificates wget dirmngr gnupg iproute2 libopus0 make g++ locales git cmake zip unzip 
RUN addgroup --gid 998 container 
RUN useradd -r -u 999 -d /home/container -g container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

   # Lua5.1 && Luvit
RUN apt-get update && apt-get -y install libssl-dev  
RUN apt-get update && apt-get -y install lua5.1 m4 luarocks && luarocks install litcord
RUN curl -fsSL https://github.com/luvit/lit/raw/master/get-lit.sh | sh
RUN mv luvit /usr/bin && mv luvi /usr/bin && mv lit /usr/bin

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
