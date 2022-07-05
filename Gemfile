# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "bcrypt"
gem "bootsnap", require: false
gem "faker"
gem "jbuilder"
gem "json"
gem "jwt", require: false
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "pundit"
gem "rack-cors"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "redis"
gem "sneakers"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "bundler-audit"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "minitest"
  gem "rails-erd"
end

group :development do
  gem "overcommit", require: false
  gem "rubocop-rails_config"
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop", require: false
end

group :test do
  gem "byebug"
  gem "simplecov"
end
