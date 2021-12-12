FROM redis:5.0.14-alpine

MAINTAINER charlie

COPY ./redis.conf /usr/local/etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server","/usr/local/etc/redis/redis.conf"]