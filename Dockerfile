FROM quay.io/jitesoft/debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y \
    && apt-get -y install iptables apt-utils curl ffmpeg software-properties-common apt-transport-https ca-certificates wget dirmngr gnupg iproute2 youtube-dl sqlite3 libopus0 make g++ locales git cmake zip unzip libtool-bin autoconf automake curl jq
    
## User 
RUN addgroup --gid 998 container
RUN useradd -m -u 999 -d /home/container -g container -s /bin/bash container
  
    # Ensure UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

   # Fixes
RUN apt-get install -y gcc g++ libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev libgcc1 lib32gcc1 gdb libc6 git wget tar zip unzip binutils xz-utils liblzo2-2 iproute2 net-tools netcat telnet libatomic1 libsdl1.2debian libsdl2-2.0-0 libfontconfig libicu63 icu-devtools libunwind8 libssl-dev sqlite3 libmariadbclient-dev locales openssl libc6-dev libstdc++6 libssl1.1 lib32stdc++6 g++ make libirrlicht-dev cmake libpng-dev libjpeg-dev libxxf86vm-dev libgl1-mesa-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev libgmp-dev libjsoncpp-dev dnsutils python3 build-essential zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncurses5-dev libncursesw5-dev tk-dev libffi-dev liblzma-dev python-openssl libespeak-dev espeak sox libsox-fmt-mp3 libespeak1 libssl-dev less libasound2 libegl1-mesa libglib2.0-0 libnss3 libpci3 libpulse0 libxcursor1 libxslt1.1 libx11-xcb1 libxkbcommon0 locales pulseaudio python x11vnc x11-xkb-utils

  # Font 
RUN update-locale lang=en_US.UTF-8 \
 && dpkg-reconfigure --frontend noninteractive locales

   # yarn
RUN apt-get update \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get -y install yarn 


    # Pyenv && Python    
RUN apt-get update && apt-get -y install libffi-dev     

  # Others
RUN apt-get update && apt-get install -y rpl libx11-dev libxkbfile-dev libsecret-1-dev

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
