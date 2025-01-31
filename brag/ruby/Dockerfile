FROM ruby:3.3.0-alpine3.19

RUN apk update && apk add \
    bash \
    build-base \
    libpq-dev

RUN echo "PS1='\n\[\e[32m\]\u \[\e[33m\]in \w\[\e[0m\] \n> '" >> /root/.bashrc

COPY Gemfile /usr/src/ruby/Gemfile
RUN cd /usr/src/ruby && bundle install

WORKDIR /usr/src/ruby

