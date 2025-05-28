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
        render(DaisyUI::Swap.new(
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
        render(DaisyUI::Swap.new(
                 states: {
                   on: hamburger_icon(class: 'text-xl'),
                   off: close_icon(class: 'text-xl')
                 },
                 value: 'on',
                 button: true
               ))
      end

      def swap_icons_with_flip_effect
        render(DaisyUI::Swap.new(states: { on: '😈', off: '😇' }, class: 'text-2xl', effect: :flip))
      end

      def swap_icons_with_rotate_effect
        render(DaisyUI::Swap.new(
                 states: {
                   on: sun_icon(class: 'text-xl'),
                   off: moon_icon(class: 'text-xl')
                 },
                 effect: :rotate
               ))
      end

      def swap_text
        render(DaisyUI::Swap.new(states: { on: 'ON', off: 'OFF' }))
      end

      def swap_volume_icons
        render(DaisyUI::Swap.new(states: { on: volume_off_icon(class: 'text-xl'), off: volume_on_icon(class: 'text-xl') }))
      end
    end
  end
end
