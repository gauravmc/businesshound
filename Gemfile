source 'https://rubygems.org'

gem 'rails', '3.2.17'
gem 'bcrypt-ruby'
gem 'jquery-rails'
gem 'mysql2'
gem 'less-rails-bootstrap', '2.3.0'
gem 'newrelic_rpm'
gem 'acts_as_list'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

group :development do
	gem 'thin'
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
end

gem 'unicorn'

group :development, :test do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-debugger'
  gem 'pry-stack_explorer'
end
