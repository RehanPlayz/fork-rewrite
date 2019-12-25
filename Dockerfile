FROM debian:9.11-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install apt-utils curl software-properties-common apt-transport-https ca-certificates wget dirmngr gnupg iproute2 libopus0 make g++ locales git cmake \
    && useradd -d /home/container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

   # Composer & PHP7.2
RUN apt-get update && apt-get -y install wget gnupg2
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.x.list
RUN apt-get update && apt-get install -y php7.2 php7.2-cli php7.2-gd php7.2-pdo php7.2-mbstring php7.2-tokenizer php7.2-bcmath php7.2-xml php7.2-curl php7.2-zip && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
