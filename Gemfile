# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in daisy_components.gemspec.
gemspec

gem 'puma'
gem 'view_component', '3.21.0'

group :development do
  gem 'lookbook', '2.3.4'
  gem 'rubocop', '1.69.2'
  gem 'rubocop-capybara', '2.19.0'
  gem 'rubocop-performance', '1.23.0'
  gem 'rubocop-rails', '2.28.0'
  gem 'ruby-lsp'
end

group :test do
  gem 'capybara'
  gem 'debug'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
