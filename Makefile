build:
	docker build -t railsapp .

test-rails5: build
	docker run --rm -it railsapp bundle exec appraisal rails-5 rake test

test-rails6: build
	docker run --rm -it railsapp bundle exec appraisal rails-6 rake test

.PHONY: test
test: build
	docker run --rm -it railsapp bundle exec appraisal rake test