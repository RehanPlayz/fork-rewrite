FROM python:3.7.7-stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install apt-utils curl jq ffmpeg software-properties-common apt-transport-https ca-certificates wget dirmngr gnupg iproute2 libopus0 make g++ locales git cmake zip unzip libtool-bin autoconf automake libsodium18
RUN addgroup --gid 998 container 
RUN useradd -r -u 999 -d /home/container -g container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

        # Dlang
RUN apt-get update && apt-get -y install dub && dub fetch dscord

        # Ruby
RUN apt-get update \
    && apt-get -y install ruby ruby-dev \
    && gem install discordrb

    # Golang
RUN apt-get update && apt-get -y install golang 
ENV GOPATH=$HOME/go
RUN go get github.com/bwmarrin/discordgo

    # Java 8
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ 
RUN apt-get update && apt-get -y install adoptopenjdk-8-hotspot
RUN java -version

    # Clojure
RUN apt-get update && apt-get -y install rlwrap build-essential
RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh
RUN chmod +x linux-install-1.10.1.536.sh && bash linux-install-1.10.1.536.sh

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update \
    && apt-get -y install nodejs npm sqlite3 node-gyp \
    && npm install discord.js node-opus canvas opusscript 
RUN npm i npm@latest -g
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn
RUN npm install -g nodemon && nodemon -v
RUN apt-get update && apt-get -y install dnsutils python3 build-essential

    # Dotnet
# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        #libicu63 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
RUN dotnet_sdk_version=3.1.102 \
    && curl -SL --output dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Sdk/$dotnet_sdk_version/dotnet-sdk-$dotnet_sdk_version-linux-x64.tar.gz \
    && dotnet_sha512='9cacdc9700468a915e6fa51a3e5539b3519dd35b13e7f9d6c4dd0077e298baac0e50ad1880181df6781ef1dc64a232e9f78ad8e4494022987d12812c4ca15f29' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -ozxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    # Trigger first run experience by running arbitrary cmd
    && dotnet help

    # Python3
RUN apt-get update && apt-get -y install libffi-dev \
    && pip3 install -q aiohttp websockets pynacl opuslib \
    && python3 -m pip install -U discord.py[voice]
RUN apt-get update && apt-get -y install dnsutils build-essential

   # Composer & PHP7.3
RUN apt-get update && apt-get -y install wget gnupg2
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.x.list
RUN apt-get update && apt-get install -y php7.3 php7.3-cli php7.3-gd php7.3-pdo php7.3-mbstring php7.3-tokenizer php7.3-bcmath php7.3-xml php7.3-curl php7.3-zip && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

        # Crystal
RUN curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add -
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list
RUN apt-get update && apt-get -y install crystal libssl-dev libxml2-dev libyaml-dev libgmp-dev libreadline-dev libz-dev

        # Rust
RUN apt-get update && apt-get -y install youtube-dl pkg-config rustc libsodium23
       
        # Scala
RUN apt-get update && apt-get -y install scala

       # Lua5.1 && Luvit
RUN apt-get update && apt-get -y install libssl-dev  
RUN apt-get update && apt-get -y install lua5.1 m4 luarocks && luarocks install litcord
RUN curl -fsSL https://github.com/luvit/lit/raw/master/get-lit.sh | sh
RUN mv luvit /usr/bin && mv luvi /usr/bin && mv lit /usr/bin

      # Nim  
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
ENV PATH=/root/.nimble/bin:$PATH
RUN nimble install discordnim -y

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
