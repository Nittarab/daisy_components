# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class BadgeComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: BadgeComponentPreview, component_name: 'badge')
    end
  end
end
