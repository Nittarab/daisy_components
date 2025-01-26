# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class BadgeComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_badge
        render_preview(:default, from: BadgeComponentPreview)
        assert_selector '.badge', text: 'Default Badge'
      end

      def test_renders_with_variants
        render_preview(:colors)
        assert_selector '.badge.badge-primary', text: 'Primary'
        assert_selector '.badge.badge-secondary', text: 'Secondary'
        assert_selector '.badge.badge-accent', text: 'Accent'
      end

      def test_renders_with_sizes
        render_preview(:sizes)
        assert_selector '.badge.badge-lg', text: 'Large'
        assert_selector '.badge.badge-md', text: 'Medium'
        assert_selector '.badge.badge-sm', text: 'Small'
        assert_selector '.badge.badge-xs', text: 'Extra Small'
      end

      def test_renders_with_outline
        render_preview(:outline)
        BadgeComponent::VARIANTS.each do |variant|
          assert_selector ".badge.badge-outline.badge-#{variant}", text: "badge-#{variant}"
        end
      end

      def test_renders_with_icon
        render_preview(:with_icon)
        assert_selector '.badge svg'
        assert_selector '.badge', text: 'Icon Badge'
      end

      def test_renders_in_button
        render_preview(:in_button)
        assert_selector '.badge', text: '99+'
        assert_selector '.badge', text: '8'
        assert_selector 'button.btn', text: /Inbox/
        assert_selector 'button.btn', text: /Notifications/
      end

      def test_renders_with_block_content
        render_preview(:with_block)
        assert_selector '.badge', text: 'Block Badge'
      end

      def test_renders_with_multiple_attributes
        render_preview(:playground, params: { variant: 'primary', size: 'lg', outline: true })
        assert_selector '.badge.badge-primary.badge-lg.badge-outline'
      end

      def test_ignores_invalid_variant
        render_inline(BadgeComponent.new('Invalid Variant', variant: 'invalid'))
        assert_selector '.badge', text: 'Invalid Variant'
        refute_selector '.badge.badge-invalid'
      end

      def test_ignores_invalid_size
        render_inline(BadgeComponent.new('Invalid Size', size: 'invalid'))
        assert_selector '.badge', text: 'Invalid Size'
        refute_selector '.badge.badge-invalid'
      end

      def test_renders_with_custom_classes
        render_inline(BadgeComponent.new('Custom Classes', class: 'custom-class'))
        assert_selector '.badge.custom-class', text: 'Custom Classes'
      end

      def test_html_attributes_handling
        render_inline(BadgeComponent.new(
                        'Badge with Attributes',
                        class: 'custom-class',
                        data: { controller: 'test' },
                        aria: { label: 'Badge' }
                      ))
        assert_selector('.badge.custom-class[data-controller="test"][aria-label="Badge"]',
                        text: 'Badge with Attributes')
      end
    end
  end
end
