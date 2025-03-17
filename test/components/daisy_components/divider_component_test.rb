# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  class DividerComponentTest < DaisyComponents::ComponentTestCase
    def test_renders_divider
      component = DividerComponent.new

      render_inline(component)
      assert_selector 'li.divider'
    end
  end
end
