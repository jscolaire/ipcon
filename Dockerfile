FROM debian:jessie
MAINTAINER jscolaire
LABEL version="1.0"
LABEL author="@jscolaire"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y ruby ruby-dev \
        build-essential make \
        libsqlite3-dev
RUN gem install bundler
RUN useradd -u 1000 -g 100 -m -d /app oper

COPY ./Gemfile /app
RUN su - oper -c "bundle install --path=vendor"

