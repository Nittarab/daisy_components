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
      # @param position select {choices: [top, bottom, left, right]}
      # @param color select {choices: [primary, secondary, accent, neutral, info, success, warning, error]}
      # @param force_open toggle "Force tooltip to be visible"
      # @param responsive select {choices: [sm, md, lg, xl]}
      # @param button_text text "Button text"
      # @param button_color select {choices: [primary, secondary, accent, neutral, info, success, warning, error]}
      # @param classes text "Additional CSS classes"
      def playground(
        tip: 'Hello world',
        position: nil,
        color: nil,
        force_open: true,
        responsive: nil,
        button_text: 'Hover me',
        button_color: nil,
        classes: ''
      )
        render(DaisyUI::Tooltip.new(
                 tip: tip,
                 position: position,
                 color: color, 
                 force_open: force_open,
                 responsive: responsive,
                 class: classes
               )) do
          render(DaisyUI::Button.new(text: button_text, color: button_color))
        end
      end

      # @!endgroup

      def tooltip
        render(DaisyUI::Tooltip.new(tip: 'hello')) do
          render(DaisyUI::Button.new(text: 'Hover me'))
        end
      end

      def top
        render(DaisyUI::Tooltip.new(position: :top, tip: 'hello', force_open: true)) do
          render(DaisyUI::Button.new(text: 'Top'))
        end
      end

      def bottom
        render(DaisyUI::Tooltip.new(position: :bottom, tip: 'hello', force_open: true)) do
          render(DaisyUI::Button.new(text: 'Bottom'))
        end
      end

      def left
        render(DaisyUI::Tooltip.new(position: :left, tip: 'hello', force_open: true)) do
          render(DaisyUI::Button.new(text: 'Left'))
        end
      end

      def right
        render(DaisyUI::Tooltip.new(position: :right, tip: 'hello', force_open: true)) do
          render(DaisyUI::Button.new(text: 'Right'))
        end
      end

      def force_open
        render(DaisyUI::Tooltip.new(tip: 'hello', force_open: true)) do
          render(DaisyUI::Button.new(text: 'Forced open'))
        end
      end

      def primary_color
        render(DaisyUI::Tooltip.new(color: :primary, tip: 'primary', force_open: true)) do
          render(DaisyUI::Button.new(text: 'primary', color: :primary))
        end
      end

      def secondary_color
        render(DaisyUI::Tooltip.new(color: :secondary, tip: 'secondary', force_open: true)) do
          render(DaisyUI::Button.new(text: 'secondary', color: :secondary))
        end
      end

      def accent_color
        render(DaisyUI::Tooltip.new(color: :accent, tip: 'accent', force_open: true)) do
          render(DaisyUI::Button.new(text: 'accent', color: :accent))
        end
      end

      def neutral_color
        render(DaisyUI::Tooltip.new(color: :neutral, tip: 'neutral', force_open: true)) do
          render(DaisyUI::Button.new(text: 'neutral', color: :neutral))
        end
      end

      def info_color
        render(DaisyUI::Tooltip.new(color: :info, tip: 'info', force_open: true)) do
          render(DaisyUI::Button.new(text: 'info', color: :info))
        end
      end

      def success_color
        render(DaisyUI::Tooltip.new(color: :success, tip: 'success', force_open: true)) do
          render(DaisyUI::Button.new(text: 'success', color: :success))
        end
      end

      def warning_color
        render(DaisyUI::Tooltip.new(color: :warning, tip: 'warning', force_open: true)) do
          render(DaisyUI::Button.new(text: 'warning', color: :warning))
        end
      end

      def error_color
        render(DaisyUI::Tooltip.new(color: :error, tip: 'error', force_open: true)) do
          render(DaisyUI::Button.new(text: 'error', color: :error))
        end
      end

      def responsive_tooltip_only_show_for_large_screen
        render(DaisyUI::Tooltip.new(responsive: :lg, tip: 'Large screen and up', force_open: true)) do
          render(DaisyUI::Button.new(text: 'lg+ only'))
        end
      end

      def tooltip_with_tooltip_content
        render(DaisyUI::Tooltip.new(tip: 'Tooltip', force_open: true)) do
          tag.span('I have a tooltip')
        end
      end
    end
  end
end