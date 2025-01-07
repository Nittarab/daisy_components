# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  class ComponentTestCase < ViewComponent::TestCase
    include ViewComponent::TestHelpers
    include Capybara::Minitest::Assertions

    def setup
      super
      @routes = DaisyComponents::Engine.routes
    end
  end
end
