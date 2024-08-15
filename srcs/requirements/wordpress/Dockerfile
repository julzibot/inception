FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache sed \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-phar \
    php81-json \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-mbstring \
    php81-openssl \
    php81-xml \
    php81-zip \
    wget \
    unzip

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
    /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner=nobody|g" \
    /etc/php81/php-fpm.d/www.conf &&\
    sed -i "s|;listen.group = nobody|listen.group=nobody|g" \
    /etc/php81/php-fpm.d/www.conf &&\
    rm -rf /var/cache/apk/*

WORKDIR /var/www

# Download Wordpress
RUN wget http://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

# Copy the script, make script executable
COPY ./requirements/wordpress/conf/wp-config-create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-config-create.sh && chmod -R 0777 wp-content/

# Download WP CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    ln -s /usr/bin/php81 /usr/bin/php && \
    wp --info

# Install WP
RUN wp core download --allow-root --version=latest --force

CMD ["/bin/sh", "/usr/local/bin/wp-config-create.sh"]
