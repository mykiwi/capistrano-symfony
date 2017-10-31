FROM ruby:alpine

RUN apk add --no-cache \
        make \
        openssh-client \
        su-exec && \
    addgroup bar && \
    adduser -D -H -h /home -s /bin/sh -G bar foo

ADD entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]
