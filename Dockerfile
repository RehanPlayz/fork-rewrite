FROM debian:9.11-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install apt-utils curl ffmpeg software-properties-common apt-transport-https ca-certificates wget dirmngr gnupg iproute2 libopus0 make g++ locales git cmake zip unzip libtool-bin autoconf automake
RUN addgroup --gid 998 container 
RUN useradd -r -u 999 -d /home/container -g container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

        # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update \
    && apt-get -y install libopus0 nodejs npm node-gyp \
    && npm install discord.js node-opus canvas opusscript \
    && npm install sqlite3 --build-from-source 
RUN npm i npm@latest -g
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn
RUN npm install -g nodemon && nodemon -v
RUN apt-get update && apt-get -y install dnsutils python3 build-essential

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
