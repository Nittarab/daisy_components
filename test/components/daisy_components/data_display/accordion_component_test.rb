# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_accordion
        render_preview(:basic)
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
        assert_selector('input[checked]')
      end

      def test_renders_joined_accordion
        render_preview(:joined)
        assert_selector('.join')
        assert_selector('.join-item', count: 3)
        assert_selector('.join.join-vertical')
        assert_selector('.collapse.join-item', count: 3)
      end

      def test_renders_with_arrow
        render_preview(:with_arrow)
        assert_selector('.collapse.collapse-arrow')
        assert_selector('.collapse-title', text: 'Expand me')
        assert_selector('.collapse-title', text: 'Expand me too')
        refute_selector('.collapse-plus')
      end

      def test_renders_with_plus
        render_preview(:with_plus)
        assert_selector('.collapse.collapse-plus')
        assert_selector('.collapse-title', text: 'Click to expand')
        assert_selector('.collapse-title', text: 'Click me as well')
        refute_selector('.collapse-arrow')
      end

      def test_renders_with_radio
        render_preview(:radio_group)
        assert_selector('input[type="radio"][name="radio-group"]', count: 3)
        assert_selector('.collapse-title', text: 'Option 1')
        assert_selector('.collapse-title', text: 'Option 2')
        assert_selector('.collapse-title', text: 'Option 3')
        assert_selector('input[checked]')
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_with_custom_classes
        render_inline(AccordionComponent.new(class: 'custom-class')) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
        end
        assert_selector('.custom-class')
      end

      def test_renders_with_list
        render_preview(:with_list)
        assert_selector('.collapse-content ul.list-disc.list-inside')
        assert_selector('.collapse-content li', count: 3)
        assert_selector('.collapse-content li', text: 'First item')
        assert_selector('.collapse-content li', text: 'Second item')
        assert_selector('.collapse-content li', text: 'Third item')
      end

      def test_renders_with_card
        render_preview(:with_card)
        assert_selector('.collapse-content .card')
        assert_selector('.collapse-content .card-body')
        assert_selector('.collapse-content .card-title', text: 'Simple Card')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         join: true,
                         arrow: true,
                         plus: false,
                         radio: false,
                         classes: 'custom-class'
                       })

        assert_selector('.join')
        assert_selector('.collapse.collapse-arrow')
        assert_selector('.custom-class')
      end
    end
  end
end
