# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'bootsnap', require: false
gem 'factory_bot_rails'
gem 'kaminari'
gem 'octokit'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.1'
gem 'rspec-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'test-prof'
end
