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
      # @param variant select { choices: [neutral, primary, secondary, accent, info, success, warning, error, ghost] } "Color variant"
      # @param size select { choices: [xs, sm, md, lg] } "Size of the content"
      # @param effect select { choices: [none, rotate, flip] } "Animation effect"
      # @param value toggle "Current state"
      # @param button toggle "Show as button"
      def playground(variant: :primary, size: :md, effect: :none, value: false, button: false)
        render(SwapComponent.new(
                 states: { on: 'ON', off: 'OFF' },
                 variant: variant,
                 size: size,
                 value: value,
                 button: button,
                 effect: effect
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
    end
  end
end
