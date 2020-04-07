FROM ruby AS builder

COPY ./app/Gemfile ./app/Gemfile.lock ./

RUN apt-get update -qq \
    && apt-get upgrade -yq \
    && apt-get install -yq --no-install-recommends g++ make \
    && bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 3 \
    && apt-get purge -y --auto-remove g++ make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log

# app
FROM ruby:slim

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends libsodium-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY ./app . 

CMD ["ruby", "main.rb"]

