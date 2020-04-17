ARG BUNDLER_VERSION=2.1.4
ARG NODE_VERSION=12.10
ARG RAILS_MASTER_KEY
ARG RUBY_VERSION=2.7.1
# ARG RAILS_VERSION=6.0.0

FROM ruby:${RUBY_VERSION}-alpine AS base

WORKDIR /usr/src/app

RUN apk update && apk upgrade && apk add --update --no-cache \
  bash \
  curl \
  git \
  less \
  libxml2 \
  libxslt \
  make \
  nodejs \
  postgresql-client \
  tzdata \
  vim \
  wait4ports

FROM base AS dev-web

RUN apk add --update --no-cache \
  build-base \
  graphviz \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  sqlite-dev

COPY . ./

ARG BUNDLER_VERSION
# ARG RAILS_VERSION

ENV EDITOR=vim
ENV BUNDLER_VERSION=${BUNDLER_VERSION}
# ENV RAILS_VERSION=${RAILS_VERSION}

# RUN gem install rails -v ${RAILS_VERSION}
RUN gem install bundler -v ${BUNDLER_VERSION}
RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install -j 8 --retry 3
RUN bundle exec appraisal install