FROM php:fpm-bookworm AS extensions-builder

RUN apt update -y && apt upgrade -y

RUN docker-php-ext-install bcmath

RUN apt install -y libbz2-dev \
 && docker-php-ext-install bz2

RUN docker-php-ext-install calendar

RUN docker-php-ext-install ctype

RUN apt install -y libcurl4-openssl-dev \
 && docker-php-ext-install curl

RUN docker-php-ext-install dba

RUN docker-php-ext-install dl_test

RUN apt install -y libxml2-dev \
 && docker-php-ext-install dom

RUN apt install -y libenchant-2-dev \
 && docker-php-ext-install enchant

RUN docker-php-ext-install exif

RUN docker-php-ext-install ffi

RUN docker-php-ext-install fileinfo

RUN docker-php-ext-install filter

RUN docker-php-ext-install ftp

RUN apt install -y libpng-dev \
 && docker-php-ext-install gd

RUN docker-php-ext-install gettext

RUN apt install -y libgmp-dev \
 && docker-php-ext-install gmp

# RUN docker-php-ext-install hash

RUN docker-php-ext-install iconv

RUN apt install -y libc-client2007e-dev libkrb5-dev \
 && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
 && docker-php-ext-install imap

RUN docker-php-ext-install intl

# RUN docker-php-ext-install json

RUN apt install -y libldap-dev \
 && docker-php-ext-install ldap

RUN apt install -y libonig-dev \
 && docker-php-ext-install mbstring

RUN docker-php-ext-install mysqli

# RUN docker-php-ext-install oci8

# RUN docker-php-ext-install odbc

RUN docker-php-ext-install opcache

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install pdo

RUN apt install -y freetds-dev \
 && docker-php-ext-install pdo_dblib

RUN apt install -y firebird-dev \
 && docker-php-ext-install pdo_firebird

RUN docker-php-ext-install pdo_mysql

# RUN docker-php-ext-install pdo_oci

RUN apt install -y unixodbc-dev \
 && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
 && docker-php-ext-install pdo_odbc

RUN apt install -y libpq-dev \
 && docker-php-ext-install pdo_pgsql

RUN apt install -y libsqlite3-dev \
 && docker-php-ext-install pdo_sqlite

RUN apt install -y libpq-dev \
 && docker-php-ext-install pgsql

RUN docker-php-ext-install phar

RUN docker-php-ext-install posix

RUN apt install -y libpspell-dev \
 && docker-php-ext-install pspell

# RUN docker-php-ext-install random

# RUN docker-php-ext-install readline

# RUN docker-php-ext-install reflection

RUN docker-php-ext-install session

RUN docker-php-ext-install shmop

RUN docker-php-ext-install simplexml

RUN apt install -y libsnmp-dev \
 && docker-php-ext-install snmp

RUN docker-php-ext-install soap

RUN docker-php-ext-install sockets

RUN apt install -y libsodium-dev \
 && docker-php-ext-install sodium

# RUN docker-php-ext-install spl

# RUN apt install -y libargon2 \
#  && docker-php-ext-install standard

RUN docker-php-ext-install sysvmsg

RUN docker-php-ext-install sysvsem

RUN docker-php-ext-install sysvshm

RUN apt install -y libtidy-dev \
 && docker-php-ext-install tidy

# RUN docker-php-ext-install tokenizer

RUN docker-php-ext-install xml

# RUN docker-php-ext-install xmlreader

RUN docker-php-ext-install xmlwriter

RUN apt install -y libxslt1-dev \
 && docker-php-ext-install xsl

# RUN docker-php-ext-configure zend_test CFLAGS=-I/usr/include/libxml2 \
#  && docker-php-ext-install zend_test

RUN apt install -y libzip-dev \
 && docker-php-ext-install zip

RUN tar rf /artifacts.tar.gz /usr/local/lib/php/extensions \
 && tar rf /artifacts.tar.gz /usr/local/include/php/ext

FROM php:fpm-bookworm

COPY --from=extensions-builder /artifacts.tar.gz /

RUN tar xf /artifacts.tar.gz -C /

RUN apt update -y && apt upgrade -y \
 && apt install -y \
    libenchant-2-2 \
    libpng16-16 \
    libc-client2007e \
    libsybdb5 \
    libfbclient2 \
    libodbc2 \
    libxslt1.1 \
    libsnmp40 \
    libpq5 \
    libtidy5deb1 \
    libzip4 \
 && apt autoremove -y && apt clean -y

RUN docker-php-ext-enable \
  bcmath \
  bz2 \
  calendar \
  ctype \
  curl \
  dba \
  dl_test \
  dom \
  enchant \
  exif \
  ffi \
  fileinfo \
  filter \
  ftp \
  gd \
  gettext \
  gmp \
  iconv \
  imap \
  intl \
  ldap \
  mbstring \
  mysqli \
  opcache \
  pcntl \
  pdo \
  pdo_dblib \
  pdo_firebird \
  pdo_mysql \
  pdo_odbc \
  pdo_pgsql \
  pdo_sqlite \
  pgsql \
  phar \
  posix \
  pspell \
  session \
  shmop \
  simplexml \
  snmp \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  tidy \
  xml \
  xmlwriter \
  xsl \
  zip
