FROM alpine:latest

LABEL maintainer "Steven Armstrong <steven.armstrong@id.ethz.ch>"

RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk --no-cache add --upgrade apk-tools@edge \
    && apk --no-cache add dnsmasq@edge curl

# Add our configuration tftp boot files.
COPY etc /etc
COPY tftproot /tftproot

EXPOSE 53 53/udp

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["--help"]
CMD ["--log-facility=-", "--log-dhcp"]
