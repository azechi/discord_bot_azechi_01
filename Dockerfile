FROM ruby:slim

COPY ./app/Gemfile .
COPY ./app/Gemfile.lock .

RUN apt-get update && apt-get install -y g++ make && bundle install 

COPY ./app .

CMD ["ruby", "main.rb"]

