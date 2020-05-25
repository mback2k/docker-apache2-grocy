FROM mback2k/apache2-php

ARG PHP_VERSION=7.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-gd \
        curl unzip && \
    apt-get install -y --no-install-recommends \
        msmtp msmtp-mta && \
    apt-get clean

RUN a2enmod rewrite headers env setenvif

RUN mkdir -p /var/www
WORKDIR /var/www

ARG GROCY_VERSION=2.7.1

ADD https://github.com/grocy/grocy/releases/download/v${GROCY_VERSION}/grocy_${GROCY_VERSION}.zip /var/www
RUN unzip grocy_${GROCY_VERSION}.zip -d grocy

RUN chown root:root -R /var/www/grocy
RUN chown www-data:www-data -R /var/www/grocy/data

RUN cp -a /var/www/grocy/config-dist.php /var/www/grocy/data/config.php
RUN cp -ar /var/www/grocy/data -T /var/cache/grocy-data-dist

VOLUME /var/www/grocy/data

ENV GROCY_DATA_DIR /var/www/grocy/data
ENV GROCY_DATA_DIST_DIR /var/cache/grocy-data-dist

ADD docker-entrypoint.d/ /run/docker-entrypoint.d/
ADD docker-websites.d/ /run/docker-websites.d/

HEALTHCHECK CMD killall -0 run-parts || curl -f http://localhost/index.php || exit 1
