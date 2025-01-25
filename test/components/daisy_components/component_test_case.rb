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

    # def render_preview(name, params: {})
    #   preview_class = "DaisyComponents::Actions::#{self.class.name.demodulize.gsub('Test', '')}Preview".constantize
    #   preview = preview_class.new
    #   render_inline(preview.public_send(name, **params))
    # end
  end
end
