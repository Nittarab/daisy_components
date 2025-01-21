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

    private

    def preview_class
      "#{self.class.name.sub(/Test$/, '')}Preview".constantize
    end

    def preview
      @preview ||= preview_class.new
    end

    def render_preview(preview_class, example, **params)
      preview = preview_class.new
      preview_result = preview.public_send(example, **params)
      component = preview_result[:component]
      preview_result[:block].call(component) if preview_result[:block]
      render_inline(component)
    end
  end
end
