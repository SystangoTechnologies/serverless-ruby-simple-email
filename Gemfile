# frozen_string_literal: true

source 'https://rubygems.org'

gem 'aws-sdk'
gem 'dynomite'
gem 'jets'
# Include mysql2 gem if you are using ActiveRecord, remove if you are not
gem 'mysql2', '~> 0.5.2'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rack'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'shotgun'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec'
end
