# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class DropdownComponentTest < DaisyComponents::ComponentTestCase
      include ActionView::Helpers::TagHelper
      include ActionView::Context

      def test_renders_basic_dropdown
        render_inline(DropdownComponent.new) { 'Dropdown content' }

        assert_selector('div.dropdown')
        assert_text('Dropdown content')
      end

      def test_renders_with_position
        render_inline(DropdownComponent.new(position: 'top')) { 'Content' }

        assert_selector('div.dropdown')
        assert_includes rendered_content, 'dropdown-top'
      end

      def test_invalid_position_is_ignored
        render_inline(DropdownComponent.new(position: 'invalid-position')) { 'Content' }

        assert_selector('div.dropdown')
        refute_includes rendered_content, 'invalid-position'
      end

      def test_renders_with_hover
        render_inline(DropdownComponent.new(hover: true)) { 'Content' }

        assert_selector('div.dropdown.dropdown-hover')
      end

      def test_renders_without_hover_by_default
        render_inline(DropdownComponent.new) { 'Content' }

        refute_selector('div.dropdown-hover')
      end

      def test_renders_with_open_state
        render_inline(DropdownComponent.new(open: true)) { 'Content' }

        assert_selector('div.dropdown.dropdown-open')
      end

      def test_renders_without_open_state_by_default
        render_inline(DropdownComponent.new) { 'Content' }

        refute_selector('div.dropdown-open')
      end

      def test_renders_with_end_alignment
        render_inline(DropdownComponent.new(align_end: true)) { 'Content' }

        assert_selector('div.dropdown.dropdown-end')
      end

      def test_renders_without_end_alignment_by_default
        render_inline(DropdownComponent.new) { 'Content' }

        refute_selector('div.dropdown-end')
      end

      def test_renders_with_additional_classes
        render_inline(DropdownComponent.new(class: 'custom-class another-class')) { 'Content' }

        assert_selector('div.dropdown.custom-class.another-class')
      end

      def test_renders_with_data_attributes
        render_inline(DropdownComponent.new(
                        data: { controller: 'dropdown', action: 'click->dropdown#toggle' }
                      )) { 'Content' }

        assert_selector('div.dropdown[data-controller="dropdown"][data-action="click->dropdown#toggle"]')
      end

      def test_renders_with_aria_attributes
        render_inline(DropdownComponent.new(
                        'aria-label': 'Dropdown menu',
                        'aria-expanded': 'true'
                      )) { 'Content' }

        assert_selector('div.dropdown[aria-label="Dropdown menu"][aria-expanded="true"]')
      end

      def test_renders_with_complex_content
        content = content_tag(:button, 'Trigger', class: 'btn') +
                  content_tag(:ul, class: 'dropdown-content') do
                    content_tag(:li) { content_tag(:a, 'Item 1') } +
                      content_tag(:li) { content_tag(:a, 'Item 2') }
                  end

        render_inline(DropdownComponent.new) { content }

        assert_selector('div.dropdown button.btn', text: 'Trigger')
        assert_selector('div.dropdown ul.dropdown-content')
        assert_selector('div.dropdown li a', text: 'Item 1')
        assert_selector('div.dropdown li a', text: 'Item 2')
      end

      def test_renders_with_multiple_state_combinations
        render_inline(DropdownComponent.new(
                        position: 'top',
                        hover: true,
                        open: true,
                        align_end: true
                      )) { 'Content' }

        assert_selector('div.dropdown.dropdown-top.dropdown-hover.dropdown-open.dropdown-end')
      end

      def test_renders_with_html_content
        render_inline(DropdownComponent.new) do
          '<button>Trigger</button><div>Content</div>'.html_safe
        end

        assert_selector('div.dropdown button', text: 'Trigger')
        assert_selector('div.dropdown div', text: 'Content')
      end

      def test_renders_with_button_component
        render_inline(DropdownComponent.new) do
          button = render_inline(ButtonComponent.new(text: 'Dropdown')).to_html
          button + tag.ul('Menu', class: 'dropdown-content')
        end

        assert_includes rendered_content, 'btn'
        assert_includes rendered_content, 'Dropdown'
        assert_includes rendered_content, 'dropdown-content'
        assert_includes rendered_content, 'Menu'
      end

      def test_renders_dropdown_positions
        render_preview(:positions)
        DropdownComponent::POSITIONS.each do |position|
          assert_selector("div.dropdown.dropdown-#{position}")
          assert_selector('label.btn')
          assert_selector('ul.dropdown-content')
          assert_selector('li a', text: 'Item 1')
          assert_selector('li a', text: 'Item 2')
        end
      end

      def test_renders_dropdown_alignments
        render_preview(:alignments)
        # Default alignment
        assert_selector('div.dropdown:not(.dropdown-end)')
        # End alignment
        assert_selector('div.dropdown.dropdown-end')
        # Top alignment
        assert_selector('div.dropdown.dropdown-top')
        # Top end alignment
        assert_selector('div.dropdown.dropdown-top.dropdown-end')
        # Left alignment
        assert_selector('div.dropdown.dropdown-left')
        # Left end alignment
        assert_selector('div.dropdown.dropdown-left.dropdown-end')
      end

      def test_renders_dropdown_behaviors
        render_preview(:behaviors)
        # Hover behavior
        assert_selector('div.dropdown.dropdown-hover')
        assert_selector('label.btn', text: 'Hover me')
        # Force open
        assert_selector('div.dropdown.dropdown-open')
        assert_selector('label.btn', text: 'Always Open')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         position: 'top',
                         hover: true,
                         open: true,
                         align_end: true,
                         classes: 'custom-class'
                       })

        assert_selector('div.dropdown.dropdown-top.dropdown-hover.dropdown-open.dropdown-end.custom-class')
        assert_selector('button.btn', text: 'Click me')
        assert_selector('ul.dropdown-content')
        assert_selector('li a', text: 'Item 1')
        assert_selector('li a', text: 'Item 2')
      end

      def test_renders_with_custom_classes
        render_inline(DropdownComponent.new(class: 'custom-class')) do
          tag.button('Click me', class: 'btn')
        end
        assert_selector('div.dropdown.custom-class')
      end
    end
  end
end
