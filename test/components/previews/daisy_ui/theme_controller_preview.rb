# frozen_string_literal: true

# @label Theme Controller
module DaisyUI
  class ThemeControllerPreview < ViewComponent::Preview
    # @!group Playground
    # Theme Controller playground
    # ---------------------------
    # Interactive playground for the ThemeController component.
    #
    # @param variant select { choices: [checkbox, toggle, swap, radio_button, radio_input, dropdown] }
    # @param value text "Theme value (single controllers)"
    # @param classes text "Additional classes"
    def playground(variant: :checkbox, value: 'synthwave', classes: '')
      render DaisyUI::ThemeController.new(
        variant: variant.to_sym,
        value: value,
        values: %w[default retro cyberpunk valentine aqua],
        class: classes
      )
    end
    # @!endgroup

    # Theme controller using a checkbox
    # ---------------------------
    def theme_controller_using_a_checkbox
      render DaisyUI::ThemeController.new(
        variant: :checkbox,
        value: 'synthwave'
      )
    end

    # Theme controller using a dropdown
    # ---------------------------
    def theme_controller_using_a_dropdown
      render DaisyUI::ThemeController.new(
        variant: :dropdown,
        values: %w[default retro cyberpunk valentine aqua],
        trigger_icon: chevron_down_icon(class: 'inline-block h-2 w-2 opacity-60')
      )
    end

    # Theme controller using a radio button
    # ---------------------------
    def theme_controller_using_a_radio_button
      render DaisyUI::ThemeController.new(
        variant: :radio_button,
        values: %w[default retro cyberpunk valentine aqua]
      )
    end

    # Theme controller using a radio input
    # ---------------------------
    def theme_controller_using_a_radio_input
      render DaisyUI::ThemeController.new(
        variant: :radio_input,
        values: %w[default retro cyberpunk valentine aqua]
      )
    end

    # Theme controller using a swap
    # ---------------------------
    def theme_controller_using_a_swap
      render DaisyUI::ThemeController.new(
        variant: :swap,
        value: 'synthwave',
        effect: :rotate,
        icon_off: sun_icon(class: 'h-10 w-10 fill-current'),
        icon_on: moon_icon(class: 'h-10 w-10 fill-current')
      )
    end

    # Theme controller using a toggle
    # ---------------------------
    def theme_controller_using_a_toggle
      render DaisyUI::ThemeController.new(
        variant: :toggle,
        value: 'synthwave'
      )
    end

    # Theme controller using a toggle with custom colors
    # ---------------------------
    def theme_controller_using_a_toggle_with_custom_colors
      render DaisyUI::ThemeController.new(
        variant: :toggle,
        value: 'synthwave',
        class: 'col-span-2 col-start-1 row-start-1 border-sky-400 bg-amber-300 [--tglbg:var(--color-sky-500)] checked:border-blue-800 checked:bg-blue-300 checked:[--tglbg:var(--color-blue-900)]'
      )
    end

    # Theme controller using a toggle with icons
    # ---------------------------
    def theme_controller_using_a_toggle_with_icons
      render DaisyUI::ThemeController.new(
        variant: :toggle,
        value: 'synthwave',
        icon_on: sun_icon(class: 'w-5 h-5'),
        icon_off: moon_icon(class: 'w-5 h-5')
      )
    end

    # Theme controller using a toggle with icons inside
    # ---------------------------
    def theme_controller_using_a_toggle_with_icons_inside
      render DaisyUI::ThemeController.new(
        variant: :toggle,
        value: 'synthwave',
        class: 'toggle text-base-content',
        icon_on: sun_icon(class: 'w-4 h-4'),
        icon_off: moon_icon(class: 'w-4 h-4')
      )
    end

    # Theme controller using a toggle with text
    # ---------------------------
    def theme_controller_using_a_toggle_with_text
      render DaisyUI::ThemeController.new(
        variant: :toggle,
        value: 'synthwave',
        label_before: 'Current',
        label_after: 'Synthwave'
      )
    end

    private

    include DaisyUI::IconsHelper
  end
end
