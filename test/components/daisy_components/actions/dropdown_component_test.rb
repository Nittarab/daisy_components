# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class DropdownComponentTest < DaisyComponents::ComponentTestCase
      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include DaisyComponents::IconsHelper

      def test_renders_basic_dropdown
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        items: [
                          { text: 'Item 1', href: '#' }
                        ]
                      ))

        assert_selector('.dropdown')
        assert_selector('button.btn', text: 'Click me')
        assert_selector('.dropdown-content')
        assert_selector('a', text: 'Item 1')
      end

      def test_renders_dropdown_positions
        %w[top top-end bottom bottom-end left left-end right right-end].each do |position|
          render_inline(DropdownComponent.new(
                          position: position,
                          trigger: { text: 'Click me' },
                          items: [{ text: 'Item', href: '#' }]
                        ))

          assert_selector(".dropdown.dropdown-#{position}")
        end
      end

      def test_renders_hover_variants
        # Standard hover
        render_inline(DropdownComponent.new(
                        hover: true,
                        trigger: { text: 'Hover me' },
                        items: [{ text: 'Item', href: '#' }]
                      ))
        assert_selector('.dropdown.dropdown-hover')

        # Hover content
        render_inline(DropdownComponent.new(
                        hover: 'content',
                        trigger: { text: 'Hover content' },
                        items: [{ text: 'Item', href: '#' }]
                      ))
        assert_selector('.dropdown.dropdown-hover-content')
      end

      def test_renders_header_and_footer
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        header: { title: 'Menu' },
                        footer: { content: 'Footer content' },
                        items: [{ text: 'Item', href: '#' }]
                      ))

        assert_selector('.dropdown-header')
        assert_selector('.dropdown-header .text-lg.font-bold', text: 'Menu')
        assert_selector('.dropdown-footer', text: 'Footer content')
      end

      def test_renders_custom_header_content
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        header: { content: tag.div('Custom header', class: 'custom-header') },
                        items: [{ text: 'Item', href: '#' }]
                      ))

        assert_selector('.dropdown-header .custom-header', text: 'Custom header')
      end

      def test_renders_variants
        %w[primary secondary accent info success warning error ghost neutral].each do |variant|
          render_inline(DropdownComponent.new(
                          variant: variant,
                          trigger: { text: 'Click me' },
                          items: [{ text: 'Item', href: '#' }]
                        ))

          assert_selector(".btn.btn-#{variant}")
        end
      end

      def test_renders_sizes
        %w[xs sm md lg].each do |size|
          render_inline(DropdownComponent.new(
                          size: size,
                          trigger: { text: 'Click me' },
                          items: [{ text: 'Item', href: '#' }]
                        ))

          assert_selector(".btn.btn-#{size}")
        end
      end

      def test_renders_dividers
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        items: [
                          { text: 'Item 1', href: '#' },
                          { type: :divider },
                          { text: 'Item 2', href: '#' }
                        ]
                      ))

        assert_selector('li.divider')
      end

      def test_renders_item_variants
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        items: [
                          { text: 'Error', href: '#', variant: :error }
                        ]
                      ))

        assert_selector('a.text-error')
      end

      def test_playground_preview
        render_preview(:playground)
        assert_selector('.dropdown')
      end

      def test_positions_preview
        render_preview(:positions)
        assert_selector('.dropdown')
      end

      def test_variants_preview
        render_preview(:variants)
        assert_selector('.dropdown')
      end

      def test_sizes_preview
        render_preview(:sizes)
        assert_selector('.dropdown')
      end

      def test_features_preview
        render_preview(:features)
        assert_selector('.dropdown')
      end
    end
  end
end
