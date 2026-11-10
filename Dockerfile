FROM alpine:3.20
LABEL org.opencontainers.image.source="https://github.com/Exido-Rio/zphisher-"
WORKDIR /zphisher/
COPY . /zphisher
RUN apk add --no-cache bash ncurses curl unzip wget php \
	&& addgroup -S zphisher \
	&& adduser -S -G zphisher zphisher \
	&& mkdir -p /zphisher/.server /zphisher/auth \
	&& chown -R zphisher:zphisher /zphisher
USER zphisher
CMD ["./zphisher.sh"]
