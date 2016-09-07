FROM alpine:edge
MAINTAINER scher200

# Add testing repo to get latest apk packages RUN echo "ipv6" >> /etc/modules
RUN echo "ipv6" >> /etc/modules

# Install packages
RUN apk upgrade -U 
RUN apk --no-cache --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
    openssl \
    php7 \
    php7-xml \
    php7-xsl \
    php7-pdo \
    php7-pdo_mysql \
    php7-mcrypt \
    php7-curl \
    php7-json \
    php7-fpm \
    php7-phar \
    php7-gd \
    php7-openssl \
    php7-mysqli \
    php7-ctype \
    php7-opcache \
    php7-mbstring \
    php7-session \
    php7-pdo_sqlite \
    php7-sqlite3 \
    php7-pcntl \
    wget \ 
    curl \
    nginx \
    bash \
    openssl \
    ca-certificates \
    opensmtpd \
    supervisor

RUN rm -fr /var/cache/apk/*

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.1/dumb-init_1.1.1_amd64
RUN chmod +x /usr/local/bin/dumb-init

# Insert the root folder and overwrite the configuration files
COPY /rootfs /

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/dumb-init"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
