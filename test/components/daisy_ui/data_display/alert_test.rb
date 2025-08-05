# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class AlertTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(
        preview_class: AlertPreview,
        component_name: 'alert',
        exclude: ['playground']
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.alert[role="alert"]', count: 1
        assert_text '12 unread messages. Tap to see.'
      end
    end
  end
end