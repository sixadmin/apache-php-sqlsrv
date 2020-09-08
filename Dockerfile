FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends curl
RUN apt-get install -y --no-install-recommends ca-certificates
RUN apt-get install -y --no-install-recommends vim
RUN apt-get install -y --no-install-recommends telnet
RUN apt-get install -y --no-install-recommends build-essential
RUN apt-get install -y --no-install-recommends iputils-ping
RUN apt-get install -y --no-install-recommends gnupg
RUN rm -rf /var/lib/apt/lists/*
RUN curl -k https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN touch /etc/apt/sources.list.d/mssql-release.list
RUN curl -k https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y --no-install-recommends php-pear
RUN apt-get install -y --no-install-recommends wget
RUN apt-get install -y --no-install-recommends g++
RUN apt-get install -y --no-install-recommends apache2  
RUN apt-get install -y --no-install-recommends php 
RUN apt-get install -y --no-install-recommends php-mysql
RUN apt-get install -y --no-install-recommends php-mbstring
RUN apt-get install -y --no-install-recommends php-dev 
RUN apt-get install -y --no-install-recommends php-gd
RUN apt-get install -y --no-install-recommends php-sqlite3
RUN apt-get install -y --no-install-recommends php-xsl
RUN apt-get install -y --no-install-recommends php-zip
RUN apt-get install -y --no-install-recommends libapache2-mod-php 
RUN apt-get install -y --no-install-recommends php-curl 
RUN apt-get install -y --no-install-recommends php-json 
RUN apt-get install -y --no-install-recommends php-common 
RUN apt-get install -y --no-install-recommends composer
RUN apt-get -y install --no-install-recommends unixodbc-dev
RUN apt-get -y install --no-install-recommends msodbcsql17
RUN pecl install sqlsrv pdo_sqlsrv
RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.2/mods-available/sqlsrv.ini
RUN printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.2/mods-available/pdo_sqlsrv.ini
RUN phpenmod -v 7.2 sqlsrv pdo_sqlsrv
RUN apt-get install -y software-properties-common
RUN rm -rvf /etc/apache2/sites-enabled/*
COPY ./mywebsite.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/mywebsite.conf /etc/apache2/sites-enabled/mywebsite.conf
RUN mkdir /usr/share/adminer
RUN wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
RUN ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
RUN echo "Alias /adminer.php /usr/share/adminer/adminer.php" | tee /etc/apache2/conf-available/adminer.conf
RUN a2enconf adminer.conf
COPY ./index.php /var/www/html/index.php
RUN rm -rf /var/www/html/index.html
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 20M
ENV PHP_POST_MAX_SIZE 20M


CMD ["apachectl","-D","FOREGROUND"]
RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443