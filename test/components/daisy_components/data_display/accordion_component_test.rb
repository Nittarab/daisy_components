# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(preview_class: AccordionComponentPreview, component_name: 'accordion')
    end
  end
end
