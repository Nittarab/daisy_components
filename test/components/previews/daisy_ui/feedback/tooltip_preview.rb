# frozen_string_literal: true

# @label Tooltip
# @display bg_color "#fff"
module DaisyUI
  module Feedback
    class TooltipPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Default
      # ---------------
      # Interactive tooltip component with customizable styling
      #
      # @param tip text "Tooltip text content"
      # @param text text "Button text (when provided, creates a button automatically)"
      # @param position select {choices: [top, bottom, left, right]}
      # @param color select {choices: [primary, secondary, accent, neutral, info, success, warning, error]}
      # @param force_open toggle "Force tooltip to be visible"
      # @param responsive select {choices: [sm, md, lg, xl]}
      # @param button_color select {choices: [primary, secondary, accent, neutral, info, success, warning, error]} "Button color (when text provided)"
      # @param button_size select {choices: [xs, sm, md, lg, xl]} "Button size (when text provided)"
      # @param button_variant select {choices: [outline, soft, dash, ghost, link]} "Button variant (when text provided)"
      # @param classes text "Additional CSS classes"
      def playground(
        tip: 'Hello world',
        text: 'Hover me',
        position: nil,
        color: nil,
        force_open: true,
        responsive: nil,
        button_color: nil,
        button_size: nil,
        button_variant: nil,
        classes: ''
      )
        render(DaisyUI::Tooltip.new(
                 tip: tip,
                 text: text,
                 position: position,
                 color: color, 
                 force_open: force_open,
                 responsive: responsive,
                 button_color: button_color,
                 button_size: button_size,
                 button_variant: button_variant,
                 class: classes
               ))
      end

      # @!endgroup

      def tooltip
        render(DaisyUI::Tooltip.new(tip: 'hello', text: 'Hover me'))
      end

      def top
        render(DaisyUI::Tooltip.new(position: :top, tip: 'hello', text: 'Top', force_open: true))
      end

      def bottom
        render(DaisyUI::Tooltip.new(position: :bottom, tip: 'hello', text: 'Bottom', force_open: true))
      end

      def left
        render(DaisyUI::Tooltip.new(position: :left, tip: 'hello', text: 'Left', force_open: true))
      end

      def right
        render(DaisyUI::Tooltip.new(position: :right, tip: 'hello', text: 'Right', force_open: true))
      end

      def force_open
        render(DaisyUI::Tooltip.new(tip: 'hello', text: 'Forced open', force_open: true))
      end

      def primary_color
        render(DaisyUI::Tooltip.new(color: :primary, tip: 'primary', text: 'primary', button_color: :primary, force_open: true))
      end

      def secondary_color
        render(DaisyUI::Tooltip.new(color: :secondary, tip: 'secondary', text: 'secondary', button_color: :secondary, force_open: true))
      end

      def accent_color
        render(DaisyUI::Tooltip.new(color: :accent, tip: 'accent', text: 'accent', button_color: :accent, force_open: true))
      end

      def neutral_color
        render(DaisyUI::Tooltip.new(color: :neutral, tip: 'neutral', text: 'neutral', button_color: :neutral, force_open: true))
      end

      def info_color
        render(DaisyUI::Tooltip.new(color: :info, tip: 'info', text: 'info', button_color: :info, force_open: true))
      end

      def success_color
        render(DaisyUI::Tooltip.new(color: :success, tip: 'success', text: 'success', button_color: :success, force_open: true))
      end

      def warning_color
        render(DaisyUI::Tooltip.new(color: :warning, tip: 'warning', text: 'warning', button_color: :warning, force_open: true))
      end

      def error_color
        render(DaisyUI::Tooltip.new(color: :error, tip: 'error', text: 'error', button_color: :error, force_open: true))
      end

      def responsive_tooltip_only_show_for_large_screen
        render(DaisyUI::Tooltip.new(responsive: :lg, tip: 'Large screen and up', text: 'lg+ only', force_open: true))
      end

      def tooltip_with_tooltip_content
        render(DaisyUI::Tooltip.new(tip: 'Tooltip', force_open: true)) do
          tag.span('I have a tooltip')
        end
      end

      def button_customization_example
        render(DaisyUI::Tooltip.new(
          tip: 'Custom button', 
          text: 'Custom',
          button_color: :primary,
          button_size: :lg,
          button_variant: :outline,
          force_open: true
        ))
      end
    end
  end
end