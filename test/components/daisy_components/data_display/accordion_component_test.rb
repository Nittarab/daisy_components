# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_accordion
        render_preview(:default)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.bg-base-100')
        assert_selector('.collapse-title.font-semibold', text: 'How do I create an account?')
        assert_selector('.collapse-content.text-sm',
                        text: 'Click the "Sign Up" button in the top right corner and follow the registration process.')
        assert_selector('.collapse.collapse-arrow')
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_default_items
        render_preview(:default)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.bg-base-100', count: 3)
        assert_selector('.collapse-title.font-semibold', text: 'How do I create an account?')
        assert_selector('.collapse-title.font-semibold', text: 'I forgot my password. What should I do?')
        assert_selector('.collapse-title.font-semibold', text: 'How do I update my profile information?')
        assert_selector('.collapse-content.text-sm', count: 3)
      end

      def test_renders_with_arrow
        render_preview(:with_arrow)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.collapse-arrow.bg-base-100')
        assert_selector('.collapse-title.font-semibold', text: 'Expand me')
        assert_selector('.collapse-title.font-semibold', text: 'Expand me too')
        refute_selector('.collapse-plus')
      end

      def test_renders_with_plus
        render_preview(:with_plus)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.collapse-plus.bg-base-100')
        assert_selector('.collapse-title.font-semibold', text: 'Click to expand')
        assert_selector('.collapse-title.font-semibold', text: 'Click me as well')
        refute_selector('.collapse-arrow')
      end

      def test_renders_with_radio
        render_preview(:radio_group)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('input[type="radio"].collapse-radio', count: 3)
        assert_selector('input[type="radio"][name="radio-group"].collapse-radio', count: 3)
        assert_selector('input[type="radio"][checked].collapse-radio', count: 1)
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_joined_items
        render_preview(:joined)
        assert_selector('.join.join-vertical')
        refute_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.join-item.bg-base-100', count: 3)
        assert_selector('.collapse-title.font-semibold', text: 'Item 1')
        assert_selector('.collapse-title.font-semibold', text: 'Item 2')
        assert_selector('.collapse-title.font-semibold', text: 'Item 3')
      end

      def test_renders_with_custom_colors
        render_preview(:custom_colors)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.bg-primary')
        assert_selector('.collapse-title.font-semibold.text-primary-content')
        assert_selector('.collapse-content.text-sm.text-primary-content')
        assert_selector('.border-primary')
        assert_selector('.p-4')
      end

      def test_renders_with_list
        render_preview(:with_list)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.bg-base-100')
        assert_selector('ul.list-disc.list-inside')
        assert_selector('li', count: 3)
      end

      def test_renders_with_card
        render_preview(:with_card)
        assert_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.bg-base-100')
        assert_selector('.card')
        assert_selector('.card-body')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         join: true,
                         arrow: true,
                         plus: false,
                         radio: true,
                         bg_color: 'bg-primary',
                         text_color: 'text-primary-content',
                         border_color: 'border-primary',
                         padding: 'p-4',
                         classes: 'custom-class'
                       })
        assert_selector('.join.join-vertical.custom-class')
        refute_selector('.flex.flex-col.gap-2')
        assert_selector('.collapse.join-item', count: 3)
        assert_selector('.collapse.collapse-arrow')
        assert_selector('.bg-primary')
        assert_selector('.text-primary-content')
        assert_selector('.border-primary')
        assert_selector('.p-4')
        assert_selector('input[type="radio"].collapse-radio', count: 3)
        assert_selector('input[type="radio"][checked].collapse-radio', count: 1)
      end
    end
  end
end
