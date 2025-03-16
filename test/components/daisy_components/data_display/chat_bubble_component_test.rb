# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class ChatBubbleComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(preview_class: ChatBubbleComponentPreview, component_name: 'chat_bubble')
    end
  end
end
