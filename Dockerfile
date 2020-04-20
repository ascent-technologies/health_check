ARG RUBY_VERSION=2.6

FROM ruby:${RUBY_VERSION}-alpine

WORKDIR /usr/src/app

RUN apk update && apk upgrade && apk add --update --no-cache \
  bash \
  git \
  libxml2 \
  libxslt \
  nodejs \
  sqlite-libs \
  tzdata \
  build-base \
  libxml2-dev \
  libxslt-dev \
  sqlite-dev

COPY lib/health_check/version.rb health_check/version.rb
COPY Gemfile health_check.gemspec Appraisals ./

RUN gem install bundler && \
  bundle install -j 8 --retry 3 && \
  bundle exec appraisal install

COPY . .