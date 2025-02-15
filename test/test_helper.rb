# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
require_relative 'support/daisy_components/preview_test_concern'
require 'rails/test_help'
require 'capybara'
require 'view_component/test_helpers'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load component test case
require_relative 'components/daisy_components/component_test_case'

module ActiveSupport
  class TestCase
    include ViewComponent::TestHelpers
    include Capybara::Node::Matchers
    include ActionView::Helpers::TagHelper
  end
end
