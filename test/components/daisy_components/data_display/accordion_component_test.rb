# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_accordion
        render_preview(:basic)
        assert_selector('.w-full')
        assert_selector('.collapse')
        assert_selector('.collapse-title', text: 'Click me')
        assert_selector('.collapse-content', text: 'Hidden content')
        assert_selector('input[type="checkbox"]')
      end

      def test_renders_multiple_items
        render_preview(:multiple)
        assert_selector('.collapse', count: 3)
        assert_selector('.collapse-title', text: 'Item 1')
        assert_selector('.collapse-title', text: 'Item 2')
        assert_selector('.collapse-title', text: 'Item 3')
        assert_selector('.collapse-content', text: 'Content 1')
        assert_selector('.collapse-content', text: 'Content 2')
        assert_selector('.collapse-content', text: 'Content 3')
        assert_selector('input[type="checkbox"][checked]', count: 1)
      end

      def test_renders_with_join
        render_preview(:playground, params: { join: true })
        assert_selector('.join.join-vertical')
        assert_selector('.join-item', count: 3)
        assert_selector('.collapse-title', text: 'Item 1')
        assert_selector('.collapse-title', text: 'Item 2')
        assert_selector('.collapse-title', text: 'Item 3')
      end

      def test_renders_with_arrow
        render_preview(:playground, params: { arrow: true })
        assert_selector('.collapse.collapse-arrow')
        refute_selector('.collapse-plus')
      end

      def test_renders_with_plus
        render_preview(:playground, params: { plus: true })
        assert_selector('.collapse.collapse-plus')
        refute_selector('.collapse-arrow')
      end

      def test_renders_with_radio
        render_preview(:playground, params: { radio: true })
        assert_selector('input[type="radio"]', count: 3)
        assert_selector('input[type="radio"][name="group1"]', count: 3)
        assert_selector('input[type="radio"][checked]', count: 1)
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_with_custom_colors
        render_preview(:playground, params: {
                         bg_color: 'bg-primary',
                         text_color: 'text-primary-content',
                         border_color: 'border-primary'
                       })
        assert_selector('.bg-primary')
        assert_selector('.text-primary-content')
        assert_selector('.border-primary')
      end

      def test_renders_with_custom_padding
        render_preview(:playground, params: { padding: 'p-4' })
        assert_selector('.collapse-title.p-4')
        assert_selector('.collapse-content.p-4')
      end

      def test_renders_with_custom_classes
        render_preview(:playground, params: { classes: 'custom-class' })
        assert_selector('.w-full.custom-class')
      end

      def test_renders_with_data_attributes
        render_inline(AccordionComponent.new(data: { controller: 'accordion' })) do |component|
          component.with_item(title: 'Click me') { 'Content' }
        end

        assert_selector('div[data-controller="accordion"]')
      end

      def test_renders_with_aria_attributes
        render_inline(AccordionComponent.new(aria: { label: 'Accordion menu' })) do |component|
          component.with_item(title: 'Click me') { 'Content' }
        end

        assert_selector('div[aria-label="Accordion menu"]')
      end

      def test_renders_with_complex_content
        render_inline(AccordionComponent.new) do |component|
          component.with_item(title: 'Complex') do
            tag.div(class: 'card') do
              tag.div(class: 'card-body') do
                'Card content'
              end
            end
          end
        end

        assert_selector('.collapse-content .card')
        assert_selector('.collapse-content .card-body')
        assert_selector('.collapse-content .card-body', text: 'Card content')
      end

      def test_playground_preview
        render_preview(:playground)
        assert_selector('.w-full')
        assert_selector('.collapse', count: 3)
        assert_selector('.collapse-title', text: 'Item 1')
        assert_selector('.collapse-title', text: 'Item 2')
        assert_selector('.collapse-title', text: 'Item 3')
        assert_selector('input[type="checkbox"][checked]', count: 1)
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: { join: true, arrow: true, plus: false, radio: true,
                                              bg_color: 'bg-primary', text_color: 'text-primary-content',
                                              border_color: 'border-primary', padding: 'p-4', classes: 'custom-class' })

        assert_selector('.w-full.custom-class')
        assert_selector('.join.join-vertical')
        assert_selector('.join-item', count: 3)
        assert_selector('.collapse.collapse-arrow')
        assert_selector('.bg-primary')
        assert_selector('.text-primary-content')
        assert_selector('.border-primary')
        assert_selector('.collapse-title.p-4')
        assert_selector('.collapse-content.p-4')
        assert_selector('input[type="radio"]', count: 3)
        assert_selector('input[type="radio"][checked]', count: 1)
      end

      def test_basic_preview
        render_preview(:basic)
        assert_selector('.collapse')
      end

      def test_joined_preview
        render_preview(:joined)
        assert_selector('.join.join-vertical')
      end

      def test_with_list_preview
        render_preview(:with_list)
        assert_selector('.collapse')
        assert_selector('ul.list-disc.list-inside')
        assert_selector('li', count: 3)
      end

      def test_with_card_preview
        render_preview(:with_card)
        assert_selector('.collapse')
        assert_selector('.card')
        assert_selector('.card-body')
      end
    end
  end
end
