FROM ruby:slim

COPY Gemfile .
COPY Gemfile.lock .
COPY main.rb .

RUN apt-get update && apt-get install -y g++ make && bundle install 

CMD ["ruby", "main.rb"]

