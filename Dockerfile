FROM ruby AS builder

COPY ./app/Gemfile ./app/Gemfile.lock ./

RUN bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 3


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

