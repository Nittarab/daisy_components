# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class BadgeComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(preview_class: BadgeComponentPreview, component_name: 'badge')
    end
  end
end
