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

# We need health_check/version.rb to build the gem, which is
# in lib so we copy that over.
# The gemspec also uses git ls for file dependencies,
# which is why we git init below.
COPY Gemfile health_check.gemspec Appraisals lib/ ./

RUN git init && gem install bundler && \
  bundle install -j 8 --retry 3 && \
  bundle exec appraisal install

COPY . .