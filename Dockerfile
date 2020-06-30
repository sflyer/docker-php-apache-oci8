FROM php:7.2-apache
#set variable - where is oracle instant client
ENV ORACLE_HOME=/opt/oracle/instantclient_18_3
ENV LD_LIBRARY_PATH  /opt/oracle/instantclient_18_3:${LD_LIBRARY_PATH}
#copy app and change own
COPY ./index.php /var/www/html
COPY ./myfolder /var/www/html/myfolder
RUN chown www-data:www-data -R /var/www/html
#copy oracle client
COPY ./oracle/instantclient_18_3 /opt/oracle/instantclient_18_3
#apt
RUN apt-get update && apt-get install -qqy git unzip libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libaio1 wget && apt-get clean autoclean && apt-get autoremove --yes &&  rm -rf /var/lib/{apt,dpkg,cache,log}/
#composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install extension
RUN echo 'instantclient,/opt/oracle/instantclient_18_3/' | pecl install oci8 \
      && docker-php-ext-enable \
               oci8 \
       && docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,/opt/oracle/instantclient_18_3,18.3 \
       && docker-php-ext-install \
               pdo_oci
