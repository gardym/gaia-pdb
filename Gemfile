source 'http://rubygems.org'

gem 'rails', '3.1.0.rc8'
gem 'will_paginate', '~> 3.0.2'

gem 'haml'
gem 'jquery-rails'
gem "therubyracer", :require => 'v8'
gem "prawn"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

group :development, :test do
  gem 'ci_reporter'
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'ruby-debug19'
end

group :prototype, :production do
  gem 'mysql2'
  gem 'unicorn'
end

group :heroku do
  gem 'pg'
end

# Deploy with Capistrano...
gem 'capistrano'
# ...with extensions for multi stage
gem 'capistrano-ext'
