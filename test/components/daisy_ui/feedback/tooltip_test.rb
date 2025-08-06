# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Feedback
    class TooltipTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(
        preview_class: TooltipPreview,
        component_name: 'tooltip',
        exclude: ['playground']
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.tooltip[data-tip="Hello world"]', count: 1
        assert_selector '.tooltip .btn', count: 1
        assert_text 'Hover me'
      end

      def test_playground_preview_with_position
        render_preview('playground', params: { position: 'top' })
        assert_selector '.tooltip.tooltip-top[data-tip="Hello world"]', count: 1
      end

      def test_playground_preview_with_color
        render_preview('playground', params: { color: 'primary' })
        assert_selector '.tooltip.tooltip-primary[data-tip="Hello world"]', count: 1
      end

      def test_playground_preview_with_force_open
        render_preview('playground', params: { force_open: true })
        assert_selector '.tooltip.tooltip-open[data-tip="Hello world"]', count: 1
      end

      def test_playground_preview_with_responsive
        render_preview('playground', params: { responsive: 'lg' })
        assert_selector '.lg\\:tooltip[data-tip="Hello world"]', count: 1
      end

      def test_playground_preview_with_custom_tip
        render_preview('playground', params: { tip: 'Custom tooltip text' })
        assert_selector '.tooltip[data-tip="Custom tooltip text"]', count: 1
      end

      def test_playground_preview_with_custom_button_text
        render_preview('playground', params: { button_text: 'Click me' })
        assert_text 'Click me'
      end

      def test_playground_preview_with_custom_button_color
        render_preview('playground', params: { button_color: 'secondary' })
        assert_selector '.tooltip .btn.btn-secondary', count: 1
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { classes: 'test-class' })
        assert_selector '.tooltip.test-class', count: 1
      end

      def test_playground_preview_with_multiple_options
        render_preview('playground', params: {
                         tip: 'Test tip',
                         position: 'bottom',
                         color: 'primary',
                         force_open: true,
                         button_text: 'Test button'
                       })

        assert_selector '.tooltip.tooltip-bottom.tooltip-primary.tooltip-open[data-tip="Test tip"]', count: 1
        assert_text 'Test button'
      end
    end
  end
end