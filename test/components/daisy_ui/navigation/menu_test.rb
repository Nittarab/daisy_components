# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Navigation
    class MenuTest < DaisyUI::ComponentTestCase
      include PreviewTestConcern

      test_all_preview_examples(
        preview_class: MenuPreview,
        component_name: 'menu',
        exclude: %w[playground]
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.menu', count: 1
        assert_selector '.menu li', count: 3
        assert_text 'Home'
        assert_text 'Messages'
        assert_text 'Analytics'
      end
    end
  end
end
