# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Actions
    class SwapComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern
      test_all_preview_examples(preview_class: SwapComponentPreview, component_name: 'swap')
    end
  end
end
