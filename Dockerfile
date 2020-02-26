FROM alpine:3.11.3
LABEL maintainer="DaveH <dude@m-ko.de> https://m-ko.de"

RUN apk add --no-cache \
    python3 py3-pip bash \
  && pip3 install --upgrade pip

RUN apk add --no-cache rsyslog wget

RUN apk add --no-cache clamav clamav-libunrar  --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main

COPY conf /etc/clamav
COPY bootstrap.py /bootstrap.py
COPY check.sh /check.sh

EXPOSE 3310/tcp
VOLUME ["/store"]

CMD /bootstrap.py

HEALTHCHECK --start-period=500s CMD /check.sh
