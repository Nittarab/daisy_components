# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class BadgeTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: BadgePreview, component_name: 'badge')
    end
  end
end
