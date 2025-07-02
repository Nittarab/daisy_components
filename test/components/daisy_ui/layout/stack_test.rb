# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Layout
    class StackTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: StackPreview,
                                component_name: 'stack',
                                exclude: ['playground'])

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.stack', count: 1
      end
    end
  end
end
