# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  class DividerComponentTest < DaisyUI::ComponentTestCase
    def test_renders_divider
      component = Divider.new

      render_inline(component)
      assert_selector 'li.divider'
    end
  end
end
