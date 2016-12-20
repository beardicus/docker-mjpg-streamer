FROM alpine:3.4
MAINTAINER Brian Boucheron <brian@boucheron.org>

RUN apk add --no-cache --virtual build-tmp git build-base linux-headers libjpeg-turbo-dev cmake \
    && git clone https://github.com/jacksonliam/mjpg-streamer.git \
    && cd /mjpg-streamer/mjpg-streamer-experimental \
    && make \
    && make install \
    && apk del build-tmp \
    && cd / \
    && rm -rf /mjpg-streamer \
    && apk add --no-cache libjpeg-turbo


EXPOSE 8080

ENTRYPOINT ["mjpg_streamer"]

CMD ["-i", "input_uvc.so", "-o", "output_http.so"]
