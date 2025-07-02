# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class BadgeTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: BadgePreview, component_name: 'badge')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.badge', count: 1
        assert_text 'Badge'
      end
    end
  end
end
