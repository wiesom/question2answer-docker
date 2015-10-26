FROM php:5.6-apache
MAINTAINER Mats Löfgren <mats.lofgren@matzor.eu>

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
    git libfreetype6-dev libpng12-dev libjpeg-dev zlib1g unzip&& \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install mysqli mbstring && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ &&\
    docker-php-ext-install gd calendar


RUN mkdir -p /var/www
RUN git clone https://github.com/q2a/question2answer.git /var/www/html

ADD entrypoint.sh /entrypoint.sh
RUN chown root:root /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
