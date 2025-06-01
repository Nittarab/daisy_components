# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Layout
    class StackTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: StackPreview,
                                component_name: 'stack',
                                exclude: ['playground'])

      def test_playground
        render_preview(:playground, from: StackPreview)
        assert_selector 'div.stack'
      end
    end
  end
end
