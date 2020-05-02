# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'bcrypt'
gem 'bootstrap', '~> 4.4.1'
gem 'dotenv', '~> 2.4'
gem 'interactor'
gem 'pg'
gem 'rollbar'
gem 'sass'
gem 'slim'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'capistrano', require: false
  gem 'capistrano-hanami', require: false
  gem 'capistrano3-puma', require: false
  gem 'hanami-webconsole'
  gem 'pry-byebug'
  gem 'rubocop'
  gem 'shotgun', platforms: :ruby
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec'
end

group :production do
  gem 'puma'
end
