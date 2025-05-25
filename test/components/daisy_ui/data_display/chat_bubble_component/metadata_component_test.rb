# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class ChatBubbleComponent
      class MetadataComponentTest < DaisyUI::ComponentTestCase
        def test_raises_error_for_invalid_type
          error = assert_raises(ArgumentError) do
            MetadataComponent.new(text: 'Test', type: :invalid)
          end

          assert_equal 'Invalid type: invalid. Must be one of: header, footer', error.message
        end
      end
    end
  end
end
