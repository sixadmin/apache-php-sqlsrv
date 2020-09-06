FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y wget
RUN apt-get install -y ca-certificates
RUN apt-get install -y apache2 
RUN apt-get install -y php 
RUN apt-get install -y php-dev 
RUN apt-get install -y php-mysql
RUN apt-get install -y php-gd
RUN apt-get install -y php-sqlite3
RUN apt-get install -y php7.4-xsl
RUN apt-get install -y php-zip
RUN apt-get install -y libapache2-mod-php 
RUN apt-get install -y php-curl 
RUN apt-get install -y php-json 
RUN apt-get install -y php-common 
RUN apt-get install -y php-mbstring 
RUN apt-get install -y composer
RUN apt-get -y install unixodbc-dev
RUN apt-get install -y adminer
RUN pecl install sqlsrv pdo_sqlsrv
RUN apt-get install -y software-properties-common
RUN rm -rvf /etc/apache2/sites-enabled/*
COPY ./mywebsite.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/mywebsite.conf /etc/apache2/sites-enabled/mywebsite.conf
COPY ./php.ini /etc/php/7.4/apache2/php.ini
COPY ./index.php /var/www/html/index.php
RUN rm -rf /var/www/html/index.html
RUN a2enconf adminer
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 20M
ENV PHP_POST_MAX_SIZE 20M


CMD ["apachectl","-D","FOREGROUND"]
RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443