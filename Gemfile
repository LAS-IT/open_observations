source 'https://rubygems.org'
# ruby '2.0.0'
# ruby '2.1.10'
# ruby '2.2.3'
# ruby '2.2.5'
ruby '2.2.10'
# ruby '2.3.7'

# gem 'rails', '3.2.16'
# gem 'rails', '3.2.22'
# gem 'rails', '3.2.22.2'
gem 'rails', '3.2.22.5'

# setup production alerting - disabled in config/initializers/rollbar.rb
# for RAILS_ENVs: development and test
# error monitoring
# gem 'oj', '~> 2.12'
gem 'oj', '~> 3.3'
# gem 'rollbar', '~> 1.4'
# gem 'rollbar', '~> 2.11'
gem 'rollbar' , '~> 2.15'

# gem 'pg', '~> 0.18'
# gem 'pg', '~> 0.19'
# gem 'pg', '~> 0.20'
gem 'pg', '~> 0.21'
gem 'postgres_ext'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '3.0.4'
gem 'jquery-ui-rails', '4.1.1'
gem 'turbolinks', '2.0.0'
gem 'jbuilder', '~> 1.2'
gem 'unicorn'
gem 'haml'
gem 'devise'
gem 'simple_form'
gem 'ffaker'
gem "country_select", "~> 1.2.0"
gem 'uuid_it', git: 'git://github.com/danreedy/uuid_it.git'
# gem 'uuid_it', path: '~/Dropbox/Development/Rails/Gems/uuid_it'
gem 'draper', '~> 1.3'
gem 'rolify'
gem 'cancan'
gem 'cancan_strong_parameters'
gem 'bitmask_attributes'
gem 'chartkick'
gem 'paperclip', '~> 3.0'

gem 'test-unit', '~> 3.0'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'haml-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'railroady'
  gem 'bullet'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'rspec-nc'
  gem 'capybara'
  gem 'factory_girl_rails'
end

group :test do
  gem 'sqlite3'
end

gem 'rails_12factor', group: :production
