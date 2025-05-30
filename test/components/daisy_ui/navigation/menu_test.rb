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
    end
  end
end
