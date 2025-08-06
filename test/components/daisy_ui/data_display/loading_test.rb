# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class LoadingTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: LoadingPreview, component_name: 'loading', exclude: ['playground'])

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'span.loading.loading-spinner', count: 1
      end

      def test_playground_preview_with_text
        render_preview('playground', params: { text: 'Loading...' })
        assert_selector 'div.flex.flex-col.items-center.gap-2', count: 1
        assert_selector 'span.loading.loading-spinner', count: 1
        assert_text 'Loading...'
      end

      def test_playground_preview_with_type
        render_preview('playground', params: { type: :dots })
        assert_selector 'span.loading.loading-dots', count: 1
      end

      def test_playground_preview_with_size
        render_preview('playground', params: { size: :lg })
        assert_selector 'span.loading.loading-spinner.loading-lg', count: 1
      end

      def test_playground_preview_with_color
        render_preview('playground', params: { color: :primary })
        assert_selector 'span.loading.loading-spinner.text-primary', count: 1
      end
    end
  end
end
