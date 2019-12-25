FROM debian:10.1-slim

RUN apt-get update \
    && apt-get -y install apt-utils curl software-properties-common apt-transport-https ca-certificates wget tar dirmngr gnupg iproute2 libopus0 make g++ locales git cmake \
    && useradd -d /home/container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

     # Dotnet
RUN apt-get update -qq -y && apt-get -y install \
    wget \
    libicu63 \
    libssl1.1
    # libc6 \
    # libgcc1 \
    # libgssapi-krb5-2 \
    # liblttng-ust0 \
    # libstdc++6 \
    # zlib1g
RUN wget -O /tmp/dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/228832ea-805f-45ab-8c88-fa36165701b9/16ce29a06031eeb09058dee94d6f5330/dotnet-sdk-2.2.401-linux-x64.tar.gz
RUN mkdir -p /usr/share/dotnet/
RUN tar zxf /tmp/dotnet.tar.gz -C /usr/share/dotnet/ && rm /tmp/dotnet.tar.gz
RUN ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN dotnet help

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
