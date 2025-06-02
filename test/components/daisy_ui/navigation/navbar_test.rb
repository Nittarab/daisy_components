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

      def test_playground
        render_preview(:playground, from: NavbarPreview)
        assert_selector 'div.navbar'
      end
    end
  end
end
