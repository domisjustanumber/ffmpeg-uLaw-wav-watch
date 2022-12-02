FROM jrottenberg/ffmpeg
RUN apk add --no-cache cpulimit
RUN apk add --no-cache bash
WORKDIR /usr/src/ffmpeg-watch
COPY crontab /etc/crontabs/root
VOLUME [ "/watch", "/output", "/storage"]
COPY run.sh .
ENTRYPOINT [ "crond" ]
CMD ["-f", "-d", "8"]
