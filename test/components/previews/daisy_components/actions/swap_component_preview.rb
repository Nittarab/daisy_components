# frozen_string_literal: true

module DaisyComponents
  module Actions
    # @label Swap
    # @display bg_color "#fff"
    class SwapComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

      # @!group Playground

      # Playground
      # ---------------
      # Interactive swap component with different effects
      #
      # @param variant select {
      #   choices: [neutral, primary, secondary, accent, info, success, warning, error, ghost]
      # } "Color variant"
      # @param size select { choices: [xs, sm, md, lg] } "Size of the content"
      # @param effect select { choices: [none, rotate, flip, active, flip-active] } "Animation effect"
      # @param value toggle "Current state"
      # @param button toggle "Show as button"
      # @param indeterminate toggle "Show indeterminate state"
      def playground(variant: :primary, size: :md, effect: :none, value: false, button: false, indeterminate: false)
        render(SwapComponent.new(
                 states: { on: 'ON', off: 'OFF' },
                 variant: variant,
                 size: size,
                 value: value,
                 button: button,
                 effect: effect,
                 indeterminate: indeterminate
               ))
      end

      # @!endgroup

      # @!group Examples

      # Initially ON
      # ---------------
      # Shows how to set initial state to ON
      def value_on
        render(SwapComponent.new(
                 states: { on: 'ON', off: 'OFF' },
                 variant: :primary,
                 value: true
               ))
      end

      # Simple Text
      # ---------------
      # Basic text swap with primary color
      #
      # @param value toggle "Current state"
      def text(value: false)
        render(SwapComponent.new(
                 states: { on: 'ON', off: 'OFF' },
                 variant: :primary,
                 value: value
               ))
      end

      # Theme Toggle
      # ---------------
      # Theme toggle with sun/moon icons
      #
      # @param value toggle "Current state"
      def theme(value: false)
        render(SwapComponent.new(
                 states: {
                   on: sun_icon('h-6 w-6'),
                   off: moon_icon('h-6 w-6')
                 },
                 button: true,
                 effect: :rotate,
                 value: value
               ))
      end

      # Emoji Weather
      # ---------------
      # Fun emoji swap with flip effect
      #
      # @param value toggle "Current state"
      def weather(value: false)
        render(SwapComponent.new(
                 states: { on: '🌞', off: '🌚' },
                 size: :lg,
                 effect: :flip,
                 value: value
               ))
      end

      # Hamburger Menu
      # ---------------
      # Hamburger menu button with rotate effect
      #
      # @param value toggle "Current state"
      def hamburger(value: false)
        render(SwapComponent.new(
                 states: {
                   on: hamburger_icon('h-6 w-6'),
                   off: close_icon('h-6 w-6')
                 },
                 button: true,
                 effect: :rotate,
                 value: value
               ))
      end

      # Volume Control
      # ---------------
      # Volume control button
      #
      # @param value toggle "Current state"
      def volume(value: false)
        render(SwapComponent.new(
                 states: {
                   on: volume_on_icon('h-6 w-6'),
                   off: volume_off_icon('h-6 w-6')
                 },
                 button: true,
                 value: value
               ))
      end

      # Active Effect
      # ---------------
      # Shows the active effect animation
      #
      # @param value toggle "Current state"
      def active(value: false)
        render(SwapComponent.new(
                 states: { on: '✓', off: '×' },
                 size: :lg,
                 effect: :active,
                 value: value,
                 variant: :success
               ))
      end

      # Flip Active Effect
      # ---------------
      # Shows the flip-active effect animation
      #
      # @param value toggle "Current state"
      def flip_active(value: false)
        render(SwapComponent.new(
                 states: { on: '✓', off: '×' },
                 size: :lg,
                 effect: :'flip-active',
                 value: value,
                 variant: :error
               ))
      end

      # Indeterminate State
      # ---------------
      # Shows the indeterminate state
      def indeterminate
        render(SwapComponent.new(
                 states: { on: '✓', off: '×' },
                 size: :lg,
                 indeterminate: true,
                 variant: :warning
               ))
      end
    end
  end
end
