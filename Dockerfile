FROM debian:bullseye-slim
ARG FILENAME=bot
COPY $FILENAME /usr/local/bin/bot
ENTRYPOINT ["bot"]
