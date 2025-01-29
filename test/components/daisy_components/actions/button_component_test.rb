# frozen_string_literal: true

require 'test_helper'
require 'nokogiri'

module DaisyComponents
  module Actions
    class ButtonComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(ButtonComponentPreview, 'button')
    end
  end
end
