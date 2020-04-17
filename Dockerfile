ARG BUNDLER_VERSION=2.1.4
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

COPY . .

ARG BUNDLER_VERSION
ENV BUNDLER_VERSION=${BUNDLER_VERSION}

RUN gem install bundler -v ${BUNDLER_VERSION} && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install -j 8 --retry 3 && \
  bundle exec appraisal install