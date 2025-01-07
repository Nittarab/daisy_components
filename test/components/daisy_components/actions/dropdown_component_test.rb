# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class DropdownComponentTest < ViewComponent::TestCase
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
    end
  end
end
