FROM dphp/php

MAINTAINER charlie

ARG TZ
ARG CONTAINER_PACKAGE_URL

COPY ./supervisord.conf /etc/supervisor/supervisord.conf

RUN sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories

RUN apk update \
	&& apk upgrade \
	&& apk add supervisor \
	&& apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone \
	&& rm -rf /var/cache/apk/*


WORKDIR /www

# 覆盖php-fpm
CMD ["supervisord","-n","-c","/etc/supervisor/supervisord.conf"]