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
    end
  end
end
