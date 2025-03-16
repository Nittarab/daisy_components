# frozen_string_literal: true

require 'test_helper'
require 'nokogiri'

module DaisyComponents
  module Actions
    class ButtonComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(preview_class: ButtonComponentPreview, component_name: 'button',
                                exclude: ['login_buttons'])

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'button.btn', count: 1
        assert_text 'Button'
      end

      def test_playground_preview_with_color
        render_preview('playground', params: { color: 'primary' })
        assert_selector 'button.btn.btn-primary', count: 1
      end

      def test_playground_preview_with_size
        render_preview('playground', params: { size: 'lg' })
        assert_selector 'button.btn.btn-lg', count: 1
      end

      def test_playground_preview_with_variant_outline
        render_preview('playground', params: { variant: 'outline' })
        assert_selector 'button.btn.btn-outline', count: 1
      end

      def test_playground_preview_with_variant_soft
        render_preview('playground', params: { variant: 'soft' })
        assert_selector 'button.btn.btn-soft', count: 1
      end

      def test_playground_preview_with_variant_dash
        render_preview('playground', params: { variant: 'dash' })
        assert_selector 'button.btn.btn-dash', count: 1
      end

      def test_playground_preview_with_shape_wide
        render_preview('playground', params: { shape: 'wide' })
        assert_selector 'button.btn.btn-wide', count: 1
      end

      def test_playground_preview_with_shape_block
        render_preview('playground', params: { shape: 'block' })
        assert_selector 'button.btn.btn-block', count: 1
      end

      def test_playground_preview_with_shape_circle
        render_preview('playground', params: { shape: 'circle' })
        assert_selector 'button.btn.btn-circle', count: 1
      end

      def test_playground_preview_with_shape_square
        render_preview('playground', params: { shape: 'square' })
        assert_selector 'button.btn.btn-square', count: 1
      end

      def test_playground_preview_disabled
        render_preview('playground', params: { disabled: true })
        assert_selector 'button.btn[disabled]', count: 1
      end

      def test_playground_preview_loading
        render_preview('playground', params: { loading: true })
        assert_selector 'button.btn span.loading.loading-spinner', count: 1
      end

      def test_playground_preview_active
        render_preview('playground', params: { active: true })
        assert_selector 'button.btn.btn-active', count: 1
      end

      def test_playground_preview_with_start_icon
        render_preview('playground', params: { has_start_icon: true })
        assert_selector 'button.btn svg:first-child.h-5.w-5', count: 1
      end

      def test_playground_preview_with_end_icon
        render_preview('playground', params: { has_end_icon: true })
        assert_selector 'button.btn svg:last-child.h-5.w-5', count: 1
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { classes: 'test-class' })
        assert_selector 'button.btn.test-class', count: 1
      end

      def test_playground_preview_with_custom_text
        render_preview('playground', params: { text: 'Custom Text' })
        assert_text 'Custom Text'
      end

      def test_playground_preview_with_multiple_options
        render_preview('playground', params: {
                         text: 'Test',
                         color: 'primary',
                         size: 'lg',
                         variant: 'outline',
                         loading: true,
                         has_start_icon: true
                       })

        assert_selector 'button.btn.btn-primary.btn-lg.btn-outline', count: 1
        assert_selector 'button.btn span.loading.loading-spinner', count: 1
        assert_text 'Test'
      end

      def test_playground_preview_with_multiple_options_no_loading
        render_preview('playground', params: {
                         text: 'Test',
                         color: 'primary',
                         size: 'lg',
                         variant: 'outline',
                         has_start_icon: true
                       })

        assert_selector 'button.btn.btn-primary.btn-lg.btn-outline', count: 1
        assert_selector 'button.btn svg:first-child.h-5.w-5', count: 1
        assert_text 'Test'
      end
    end
  end
end
