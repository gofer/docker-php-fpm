FROM scratch

ADD root.tar.gz /

CMD ["php-fpm"]
