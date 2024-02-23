FROM php:fpm-alpine3.19 AS extensions-builder

RUN apk update && apk upgrade \
 && apk add alpine-sdk build-base

RUN docker-php-ext-install bcmath

RUN apk add bzip2-dev \
 && docker-php-ext-install bz2

RUN docker-php-ext-install calendar

RUN docker-php-ext-install ctype

RUN apk add curl-dev \
 && docker-php-ext-install curl

RUN docker-php-ext-install dba

RUN docker-php-ext-install dl_test

RUN apk add libxml2-dev \
 && docker-php-ext-install dom

RUN apk add enchant2-dev \
 && docker-php-ext-install enchant

RUN docker-php-ext-install exif

RUN docker-php-ext-install ffi

RUN docker-php-ext-install fileinfo

RUN docker-php-ext-install filter

RUN docker-php-ext-install ftp

RUN apk add libpng-dev \
 && docker-php-ext-install gd

RUN docker-php-ext-install gettext

RUN apk add gmp-dev \
 && docker-php-ext-install gmp

# RUN docker-php-ext-install hash

# RUN docker-php-ext-install iconv

RUN apk add imap-dev krb5-dev \
 && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
 && docker-php-ext-install imap

RUN apk add icu-dev \
 && docker-php-ext-install intl

# RUN docker-php-ext-install json

RUN apk add openldap-dev \
 && docker-php-ext-install ldap

RUN apk add oniguruma-dev \
 && docker-php-ext-install mbstring

RUN docker-php-ext-install mysqli

# RUN docker-php-ext-install oci8

# RUN apk add unixodbc-dev
# RUN docker-php-ext-configure --with-unixODBC
# RUN docker-php-ext-install odbc

RUN docker-php-ext-install opcache

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install pdo

RUN apk add freetds-dev \
 && docker-php-ext-install pdo_dblib

# RUN docker-php-ext-install pdo_firebird

RUN docker-php-ext-install pdo_mysql

# RUN docker-php-ext-install pdo_oci

RUN apk add unixodbc-dev \
 && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
 && docker-php-ext-install pdo_odbc

RUN apk add libpq-dev \
 && docker-php-ext-install pdo_pgsql

RUN apk add sqlite-dev \
 && docker-php-ext-install pdo_sqlite

RUN apk add libpq-dev \
 && docker-php-ext-install pgsql

RUN docker-php-ext-install phar

RUN docker-php-ext-install posix

RUN apk add aspell-dev \
 && docker-php-ext-install pspell

# RUN docker-php-ext-install random

# RUN docker-php-ext-install readline

# RUN docker-php-ext-install reflection

RUN docker-php-ext-install session

RUN docker-php-ext-install shmop

RUN docker-php-ext-install simplexml

RUN apk add net-snmp-dev \
 && docker-php-ext-install snmp

RUN docker-php-ext-install soap

RUN docker-php-ext-install sockets

RUN docker-php-ext-install sodium

# RUN docker-php-ext-install spl

# RUN apk add libargon2 \
#  && docker-php-ext-install standard

RUN docker-php-ext-install sysvmsg

RUN docker-php-ext-install sysvsem

RUN docker-php-ext-install sysvshm

RUN apk add tidyhtml-dev \
 && docker-php-ext-install tidy

# RUN docker-php-ext-install tokenizer

RUN docker-php-ext-install xml

# RUN docker-php-ext-install xmlreader

RUN docker-php-ext-install xmlwriter

RUN apk add libxslt-dev \
 && docker-php-ext-install xsl

# RUN docker-php-ext-configure zend_test CFLAGS=-I/usr/include/libxml2 \
#  && docker-php-ext-install zend_test

RUN apk add libzip-dev \
 && docker-php-ext-install zip

RUN apk add alpine-sdk build-base autoconf linux-headers \
 && pecl install xdebug

RUN tar rf /artifacts.tar.gz /usr/local/lib/php/extensions \
 && tar rf /artifacts.tar.gz /usr/local/include/php/ext \
 && tar rf /artifacts.tar.gz /usr/local/etc/php/conf.d

FROM php:fpm-alpine3.19

COPY --from=extensions-builder /artifacts.tar.gz /

RUN tar xf /artifacts.tar.gz -C /

RUN apk update && apk upgrade \
 && apk add \
   libbz2 \
   enchant2-libs \
   libpng \
   gmp \
   c-client \
   icu-libs \
   libldap \
   freetds \
   libpq \
   aspell-libs \
   net-snmp-libs \
   tidyhtml-libs \
   libxslt \
   libzip

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
  imap \
  intl \
  ldap \
  mbstring \
  mysqli \
  opcache \
  pcntl \
  pdo \
  pdo_dblib \
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
  zip \
  xdebug
