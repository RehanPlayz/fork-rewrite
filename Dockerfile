FROM debian:buster-slim

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

        # NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
SHELL [ "/bin/bash", "-l", "-c" ]
RUN nvm install 8
RUN nvm install 10
RUN nvm install 12
RUN nvm install 14
RUN nvm alias default 10
RUN apt-get update \
    && nvm use 10 \
    && npm install -g coffeescript typescript opusscript
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn
RUN npm install -g nodemon && nodemon -v
RUN npm install -g coffeescript typescript
RUN apt-get update && apt-get -y install dnsutils python3 build-essential
 
    # NVM test
RUN nvm use 8 && node -v
RUN nvm use 10 && node -v
RUN nvm use 12 && node -v
RUN nvm use 14 && node -v

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
