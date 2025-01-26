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
                          { text: 'Item 1', href: '#' },
                          { text: 'Item 2', href: '#' }
                        ]
                      ))

        assert_selector('div.dropdown')
        assert_selector('button.btn', text: 'Click me')
        assert_selector('ul.dropdown-content')
        assert_selector('li a', text: 'Item 1')
        assert_selector('li a', text: 'Item 2')
      end

      def test_renders_with_position
        render_inline(DropdownComponent.new(
                        position: 'top',
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('div.dropdown.dropdown-top')
      end

      def test_invalid_position_is_ignored
        render_inline(DropdownComponent.new(
                        position: 'invalid-position',
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('div.dropdown')
        assert_not_includes rendered_content, 'invalid-position'
      end

      def test_renders_with_hover
        render_inline(DropdownComponent.new(
                        hover: true,
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('div.dropdown.dropdown-hover')
      end

      def test_renders_with_open_state
        render_inline(DropdownComponent.new(
                        open: true,
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('div.dropdown.dropdown-open')
      end

      def test_renders_with_end_alignment
        render_inline(DropdownComponent.new(
                        align_end: true,
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('div.dropdown.dropdown-end')
      end

      def test_renders_with_variant
        render_inline(DropdownComponent.new(
                        variant: 'primary',
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('button.btn.btn-primary')
      end

      def test_renders_with_size
        render_inline(DropdownComponent.new(
                        size: 'lg',
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('button.btn.btn-lg')
      end

      def test_renders_with_icon
        render_inline(DropdownComponent.new(
                        trigger: {
                          text: 'Settings',
                          icon: warning_icon('h-5 w-5')
                        }
                      ))

        assert_selector('button.btn svg')
        assert_selector('button.btn', text: 'Settings')
      end

      def test_renders_with_divider
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        items: [
                          { text: 'Item 1', href: '#' },
                          { type: :divider },
                          { text: 'Item 2', href: '#' }
                        ]
                      ))

        assert_selector('li.divider')
        assert_selector('li a', text: 'Item 1')
        assert_selector('li a', text: 'Item 2')
      end

      def test_renders_with_item_variants
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        items: [
                          { text: 'Delete', href: '#', variant: :error }
                        ]
                      ))

        assert_selector('li a.text-error', text: 'Delete')
      end

      def test_renders_with_item_icons
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        items: [
                          {
                            text: 'Settings',
                            href: '#',
                            icon: warning_icon('h-5 w-5')
                          }
                        ]
                      ))

        assert_selector('li a svg')
        assert_selector('li a', text: 'Settings')
      end

      def test_renders_with_additional_classes
        render_inline(DropdownComponent.new(
                        class: 'custom-class',
                        trigger: { text: 'Click me' }
                      ))

        assert_selector('div.dropdown.custom-class')
      end

      def test_renders_with_data_attributes
        render_inline(DropdownComponent.new(
                        trigger: { text: 'Click me' },
                        data: { controller: 'dropdown', action: 'click->dropdown#toggle' }
                      ))

        assert_selector('div.dropdown[data-controller="dropdown"][data-action="click->dropdown#toggle"]')
      end

      def test_renders_preview_playground
        render_preview(:playground, params: {
                         position: 'top',
                         hover: true,
                         open: true,
                         align_end: true,
                         variant: 'primary',
                         size: 'lg',
                         trigger_text: 'Custom Text',
                         trigger_icon: warning_icon('h-5 w-5')
                       })

        assert_selector('div.dropdown.dropdown-top.dropdown-hover.dropdown-open.dropdown-end')
        assert_selector('button.btn.btn-primary.btn-lg svg')
        assert_selector('button.btn', text: 'Custom Text')
        assert_selector('ul.dropdown-content')
        assert_selector('li.divider')
        assert_selector('li a.text-error')
      end

      def test_renders_preview_variants
        render_preview(:variants)
        DropdownComponent::VARIANTS.each do |variant|
          assert_selector("button.btn.btn-#{variant}")
        end
      end

      def test_renders_preview_sizes
        render_preview(:sizes)
        DropdownComponent::SIZES.each do |size|
          assert_selector("button.btn.btn-#{size}")
        end
      end

      def test_renders_preview_features
        render_preview(:features)
        assert_selector('button.btn svg')
        assert_selector('li a svg')
        assert_selector('li.divider')
        assert_selector('li a.text-error')
      end
    end
  end
end
