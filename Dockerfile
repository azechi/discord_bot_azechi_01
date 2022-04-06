# syntax=docker/dockerfile:latest

FROM rust:slim-bullseye as builder

WORKDIR /usr/src/app
COPY . .
RUN \
  \ #--mount=type=cache,target=/usr/local/cargo/registry \
  \ #--mount=type=cache,target=/usr/src/app/target \
  cargo install --path .


FROM debian:bullseye-slim

COPY --from=builder /usr/local/cargo/bin/discord_bot_azechi_01 /usr/local/bin/discord_bot_azechi_01
CMD ["discord_bot_azechi_01"]

