# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class CardComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: CardComponentPreview, component_name: 'card')
    end
  end
end
