# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'puma'
gem 'redcarpet', '3.6.1'
gem 'view_component', '3.21.0'

group :development do
  gem 'lookbook', '2.3.4'
  gem 'rubocop', '1.71.0'
  gem 'rubocop-capybara', '2.21.0'
  gem 'rubocop-performance', '1.23.1'
  gem 'rubocop-rails', '2.29.1'
  gem 'ruby-lsp'
  gem 'ruby-lsp-rails'
end

group :test do
  gem 'capybara'
  gem 'debug'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

gem 'nokogiri', '~> 1.18', group: :development
gem 'terminal-table', '~> 3.0.2', group: :development
