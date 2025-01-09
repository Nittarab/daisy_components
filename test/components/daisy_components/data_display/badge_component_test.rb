# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class BadgeComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_badge
        render_inline(BadgeComponent.new('Badge'))

        assert_selector('.badge', text: 'Badge')
      end

      def test_renders_with_block_content
        render_inline(BadgeComponent.new) { 'Block content' }

        assert_selector('.badge', text: 'Block content')
      end

      def test_renders_with_variants
        BadgeComponent::VARIANTS.each do |variant|
          render_inline(BadgeComponent.new('Badge', variant: variant))

          assert_selector(".badge.badge-#{variant}", text: 'Badge')
        end
      end

      def test_renders_with_sizes
        BadgeComponent::SIZES.each do |size|
          render_inline(BadgeComponent.new('Badge', size: size))

          assert_selector(".badge.badge-#{size}", text: 'Badge')
        end
      end

      def test_renders_with_outline
        render_inline(BadgeComponent.new('Badge', outline: true))

        assert_selector('.badge.badge-outline', text: 'Badge')
      end

      def test_renders_with_custom_classes
        render_inline(BadgeComponent.new('Badge', class: 'custom-class'))

        assert_selector('.badge.custom-class', text: 'Badge')
      end

      def test_renders_with_html_content
        render_inline(BadgeComponent.new) do
          '<span class="font-bold">HTML</span>'.html_safe
        end

        assert_selector('.badge span.font-bold', text: 'HTML')
      end

      def test_renders_with_multiple_attributes
        render_inline(BadgeComponent.new(
                        'Badge',
                        variant: 'primary',
                        size: 'lg',
                        outline: true,
                        class: 'custom-class'
                      ))

        assert_selector('.badge.badge-primary.badge-lg.badge-outline.custom-class', text: 'Badge')
      end

      def test_ignores_invalid_variant
        render_inline(BadgeComponent.new('Badge', variant: 'invalid-variant'))

        assert_selector('.badge', text: 'Badge')
        refute_selector('.badge-invalid-variant')
      end

      def test_ignores_invalid_size
        render_inline(BadgeComponent.new('Badge', size: 'invalid-size'))

        assert_selector('.badge', text: 'Badge')
        refute_selector('.badge-invalid-size')
      end
    end
  end
end
