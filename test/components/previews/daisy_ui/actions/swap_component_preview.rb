# frozen_string_literal: true

module DaisyUI
  module Actions
    # @label Swap
    # @display bg_color "#fff"
    class SwapComponentPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Playground
      # ---------------
      # Interactive swap component with different effects
      #
      # @param variant select { choices: [neutral, primary, secondary, accent, info, success, warning, error, ghost]} "Color variant"
      # @param size select { choices: [xs, sm, md, lg] } "Size of the content"
      # @param effect select { choices: [rotate, flip, flip_active] } "Animation effect"
      # @param value toggle "Current state"
      # @param active toggle "Active state"
      # @param button toggle "Show as button"
      def playground(variant: :primary, size: :md, effect: nil, value: false, active: false, button: false)
        render(DaisyUI::SwapComponent.new(
                 states: { on: 'ON', off: 'OFF' },
                 variant: variant,
                 size: size,
                 value: value,
                 active: active,
                 button: button,
                 effect: effect
               ))
      end

      # @!endgroup

      def hamburger_button
        render(DaisyUI::SwapComponent.new(
                 states: {
                   on: hamburger_icon('h-6 w-6'),
                   off: close_icon('h-10 w-10')
                 },
                 value: 'on',
                 button: true
               ))
      end

      def swap_icons_with_flip_effect
        render(DaisyUI::SwapComponent.new(states: { on: '😈', off: '😇' }, class: 'text-2xl', effect: :flip))
      end

      def swap_icons_with_rotate_effect
        render(DaisyUI::SwapComponent.new(
                 states: {
                   on: sun_icon('h-10 w-10'),
                   off: moon_icon('h-10 w-10')
                 },
                 effect: :rotate
               ))
      end

      def swap_text
        render(DaisyUI::SwapComponent.new(states: { on: 'ON', off: 'OFF' }))
      end

      def swap_volume_icons
        render(DaisyUI::SwapComponent.new(states: { on: volume_off_icon('h-10'), off: volume_on_icon('h-10') }))
      end
    end
  end
end
