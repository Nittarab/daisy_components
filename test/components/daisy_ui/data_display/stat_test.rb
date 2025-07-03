# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class StatTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: DaisyUI::DataDisplay::StatPreview, component_name: 'stat')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.stats', count: 1
        assert_selector 'div.stat', count: 1
        assert_text 'Total Page Views'
        assert_text '89,400'
        assert_text '21% more than last month'
      end
    end
  end
end