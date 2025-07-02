# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Navigation
    class NavbarTest < DaisyUI::ComponentTestCase
      include PreviewTestConcern

      test_all_preview_examples(
        preview_class: NavbarPreview,
        component_name: 'navbar',
        exclude: %w[playground]
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.navbar', count: 1
      end
    end
  end
end
