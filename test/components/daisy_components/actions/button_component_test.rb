# frozen_string_literal: true

require 'test_helper'
require 'nokogiri'

module DaisyComponents
  module Actions
    class ButtonComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(preview_class: ButtonComponentPreview, component_name: 'button',
                                exclude: ['login_buttons'])
    end
  end
end
