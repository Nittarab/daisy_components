# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  class BaseComponentTest < ViewComponent::TestCase
    class TestComponent < BaseComponent
      def call
        tag.div(class: classes)
      end
    end

    def test_renders_with_classes
      render_inline(TestComponent.new(classes: 'test-class another-class'))
      assert_selector('div.test-class.another-class')
    end

    def test_renders_without_classes
      render_inline(TestComponent.new)
      assert_selector('div')
      refute_selector('div[class]')
    end

    def test_renders_with_nil_classes
      render_inline(TestComponent.new(classes: nil))
      assert_selector('div')
      refute_selector('div[class]')
    end
  end
end
