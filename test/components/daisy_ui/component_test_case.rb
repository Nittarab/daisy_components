# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  class ComponentTestCase < ViewComponent::TestCase
    include ViewComponent::TestHelpers
    include Capybara::Minitest::Assertions

    def setup
      super
      @routes = DaisyUI::Engine.routes
    end
  end
end
