# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class SwapComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern
      test_all_preview_examples(preview_class: SwapComponentPreview, component_name: 'swap')
    end
  end
end
