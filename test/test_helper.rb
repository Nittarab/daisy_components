# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
require 'rails/test_help'
require 'capybara'
require 'view_component/test_helpers'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

# Load component test case
require_relative 'components/daisy_components/component_test_case'
