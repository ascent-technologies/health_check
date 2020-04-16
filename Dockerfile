FROM ruby:2.7

WORKDIR /usr/src/app

COPY . ./
RUN bundle install
RUN bundle exec appraisal install

COPY . .

CMD ["./your-daemon-or-script.rb"]
