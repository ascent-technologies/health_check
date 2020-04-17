build:
	docker build -t railsapp .

test-rails5:
	docker run -it railsapp bundle exec appraisal rails-5 rake test

test-rails6:
	docker run -it railsapp bundle exec appraisal rails-6 rake test

test-all:
	docker run -it railsapp bundle exec appraisal rake test