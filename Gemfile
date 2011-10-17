source 'http://rubygems.org'

gem 'rails', '3.1.0.rc8'

gem 'haml'
gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'sqlite3'
  gem 'database_cleaner'
  gem 'launchy'
end

group :prototype, :production do
  gem 'mysql2'
  gem 'unicorn'
end

# Deploy with Capistrano
# gem 'capistrano'