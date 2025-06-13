# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  class ThemeControllerTest < DaisyUI::ComponentTestCase
    include DaisyUI::PreviewTestConcern

    test_all_preview_examples(
      preview_class: ThemeControllerPreview,
      component_name: 'theme-controller'
    )

    # Basic behavior tests ---------------------------------------------------

    def test_checkbox_variant_renders
      render_inline DaisyUI::ThemeController.new(variant: :checkbox, value: 'synthwave')
      assert_selector 'input.checkbox.theme-controller[value="synthwave"]'
    end

    def test_toggle_variant_renders
      render_inline DaisyUI::ThemeController.new(variant: :toggle, value: 'synthwave')
      assert_selector 'input.toggle.theme-controller[value="synthwave"]'
    end

    def test_dropdown_variant_renders
      render_inline DaisyUI::ThemeController.new(variant: :dropdown, values: %w[default retro])
      assert_selector 'div.dropdown'
      assert_selector 'input.theme-controller[type="radio"]', count: 2
    end
  end
end
