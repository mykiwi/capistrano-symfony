FROM alpine:edge

RUN apk add --no-cache \
        bash \
        curl \
        git \
        openssh-server && \
    ssh-keygen -A

RUN addgroup bar && \
    echo -e "foo\nfoo\n" | adduser -H -h /home -s /bin/bash -G bar foo && \
    mkdir -p /home/.ssh && \
    wget https://github.com/mykiwi.keys -O /home/.ssh/authorized_keys && \
    chown -R foo:bar /home

RUN apk add --no-cache \
        php7 \
        php7-ctype \
        php7-dom \
        php7-json \
        php7-phar \
        php7-mbstring \
        php7-iconv \
        php7-openssl \
        php7-pdo \
        php7-xml \
        unzip \
        openssh-client && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

CMD ["/usr/sbin/sshd", "-D"]
