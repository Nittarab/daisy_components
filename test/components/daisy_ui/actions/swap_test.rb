# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Actions
    class SwapComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern
      test_all_preview_examples(preview_class: SwapPreview, component_name: 'swap')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'input[type="checkbox"]', count: 1
        assert_selector '.swap', count: 1
        assert_text 'OFF'
      end
    end
  end
end
