# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Actions
    class ThemeControllerTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(
        preview_class: ThemeControllerPreview,
        component_name: 'theme-controller',
        exclude: ['playground']
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'input.checkbox.theme-controller[value="synthwave"]', count: 1
      end

      def test_playground_preview_toggle_type
        render_preview('playground', params: { type: 'toggle' })
        assert_selector 'input.toggle.theme-controller[value="synthwave"]', count: 1
      end

      def test_playground_preview_with_text
        render_preview('playground', params: { 
          type: 'toggle',
          text_before: 'Light',
          text_after: 'Dark'
        })
        assert_selector 'label.flex.cursor-pointer.gap-2', count: 1
        assert_text 'Light'
        assert_text 'Dark'
      end

      def test_playground_preview_with_icons
        render_preview('playground', params: {
          type: 'toggle',
          has_icons: true
        })
        assert_selector 'label.flex.cursor-pointer.gap-2', count: 1
        assert_selector 'i.ph', count: 2
      end

      def test_playground_preview_radio_type
        render_preview('playground', params: { type: 'radio' })
        assert_selector 'fieldset.fieldset', count: 1
        assert_selector 'input[type="radio"].radio.theme-controller', count: 3
      end

      def test_playground_preview_radio_button_type
        render_preview('playground', params: { type: 'radio_button' })
        assert_selector 'div.join.join-vertical', count: 1
        assert_selector 'input[type="radio"].btn.theme-controller.join-item', count: 3
      end

      def test_playground_preview_dropdown_type
        render_preview('playground', params: { type: 'dropdown' })
        assert_selector 'div.dropdown.mb-72', count: 1
        assert_selector 'div[role="button"].btn.m-1', count: 1
        assert_selector 'ul.dropdown-content', count: 1
        assert_selector 'input[type="radio"].theme-controller', count: 3
      end

      def test_playground_preview_swap_type
        render_preview('playground', params: { type: 'swap' })
        assert_selector 'label.swap.swap-rotate', count: 1
        assert_selector 'input[type="checkbox"].theme-controller', count: 1
        assert_selector 'svg.swap-off', count: 1
        assert_selector 'svg.swap-on', count: 1
      end

      def test_playground_preview_toggle_icons_inside_type
        render_preview('playground', params: { type: 'toggle_icons_inside' })
        assert_selector 'label.toggle.text-base-content', count: 1
        assert_selector 'input[type="checkbox"].theme-controller', count: 1
        assert_selector 'i.ph.ph-sun', count: 1
        assert_selector 'i.ph.ph-moon', count: 1
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { classes: 'test-class' })
        assert_selector 'input.checkbox.theme-controller.test-class', count: 1
      end

      def test_playground_preview_checked_state
        render_preview('playground', params: { checked: true })
        assert_selector 'input.checkbox.theme-controller[checked]', count: 1
      end

      def test_playground_preview_custom_value
        render_preview('playground', params: { value: 'dark' })
        assert_selector 'input.checkbox.theme-controller[value="dark"]', count: 1
      end
    end
  end
end