# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class CardTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: CardPreview, component_name: 'card')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.card', count: 1
        assert_text 'Card Title'
        assert_text 'Card content goes here.'
        assert_selector 'button.btn.btn-primary', count: 1
      end
    end
  end
end
