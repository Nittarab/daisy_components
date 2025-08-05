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
        assert_selector 'input.toggle.theme-controller[value="synthwave"]', count: 1
      end

      def test_playground_preview_checkbox_type
        render_preview('playground', params: { type: 'checkbox' })
        assert_selector 'input.checkbox.theme-controller[value="synthwave"]', count: 1
      end

      def test_playground_preview_radio_buttons_type
        render_preview('playground', params: { type: 'radio_buttons' })
        assert_selector 'div.join.join-vertical', count: 1
        assert_selector 'input.btn.theme-controller.join-item[type="radio"]', count: 5
      end

      def test_playground_preview_radio_inputs_type
        render_preview('playground', params: { type: 'radio_inputs' })
        assert_selector 'fieldset.fieldset', count: 1
        assert_selector 'input.radio.radio-sm.theme-controller[type="radio"]', count: 5
      end

      def test_playground_preview_dropdown_type
        render_preview('playground', params: { type: 'dropdown' })
        assert_selector 'div.dropdown', count: 1
        assert_selector 'div.btn[tabindex="0"][role="button"]', count: 1
        assert_selector 'ul.dropdown-content', count: 1
        assert_selector 'input.theme-controller[type="radio"]', count: 5
      end

      def test_playground_preview_swap_type
        render_preview('playground', params: { type: 'swap' })
        assert_selector 'label.swap.swap-rotate', count: 1
        assert_selector 'input.theme-controller[type="checkbox"][value="synthwave"]', count: 1
      end

      def test_playground_preview_with_custom_value
        render_preview('playground', params: { value: 'dark' })
        assert_selector 'input.theme-controller[value="dark"]', count: 1
      end

      def test_playground_preview_with_checked_state
        render_preview('playground', params: { checked: true })
        assert_selector 'input.theme-controller[checked]', count: 1
      end

      def test_playground_preview_with_labels
        render_preview('playground', params: { label_before: 'Light', label_after: 'Dark' })
        assert_selector 'label.flex.cursor-pointer', count: 1
        assert_text 'Light'
        assert_text 'Dark'
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { custom_classes: 'test-class' })
        assert_selector 'input.theme-controller.test-class', count: 1
      end
    end
  end
end