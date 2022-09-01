# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "aws-sdk-cognitoidentity"
gem "aws-sdk-cognitoidentityprovider"
gem "aws-sdk-s3"
gem "bcrypt"
gem "bootsnap", require: false
gem "faker"
gem "image_processing"
gem "jbuilder"
gem "json"
gem "jwt"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "pundit"
gem "rswag"
gem "rswag-ui"
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
  gem "rspec-rails", "~> 6.0.0.rc1"
  gem "rswag-specs"
  gem "byebug"
end

group :development do
  gem "overcommit", require: false
  gem "rubocop-rails_config"
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop", require: false
  gem "rest-client"
end

group :test do
  gem "simplecov"
  gem "webmock"
end
