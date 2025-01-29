# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class DropdownComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(ButtonComponentPreview, 'button')
    end
  end
end
