FROM ruby:3.3.0-alpine3.19

RUN apk update && apk add \
    bash 

RUN echo "PS1='\n\[\e[32m\]\u \[\e[33m\]in \w\[\e[0m\] \n> '" >> /root/.bashrc

WORKDIR /usr/src/ruby

