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
      # @param button_text text "Button text"
      # @param position select {choices: [top, bottom, left, right]}
      # @param color select {choices: [primary, secondary, accent, neutral, info, success, warning, error]}
      # @param force_open toggle "Force tooltip to be visible"
      # @param responsive select {choices: [sm, md, lg, xl]}
      # @param button_color select {choices: [primary, secondary, accent, neutral, info, success, warning, error]} "Button color"
      # @param button_size select {choices: [xs, sm, md, lg, xl]} "Button size"
      # @param button_variant select {choices: [outline, soft, dash, ghost, link]} "Button variant"
      # @param classes text "Additional CSS classes"
      def playground(
        tip: 'Hello world',
        button_text: 'Hover me',
        position: nil,
        color: nil,
        force_open: true,
        responsive: nil,
        button_color: nil,
        button_size: nil,
        button_variant: nil,
        classes: ''
      )
        button_config = { text: button_text }
        button_config[:color] = button_color if button_color
        button_config[:size] = button_size if button_size
        button_config[:variant] = button_variant if button_variant
        
        render(DaisyUI::Tooltip.new(
                 tip: tip,
                 button: button_config,
                 position: position,
                 color: color, 
                 force_open: force_open,
                 responsive: responsive,
                 class: classes
               ))
      end

      # @!endgroup

      def tooltip
        render(DaisyUI::Tooltip.new(tip: 'hello', button: { text: 'Hover me' }))
      end

      def top
        render(DaisyUI::Tooltip.new(position: :top, tip: 'hello', button: { text: 'Top' }, force_open: true))
      end

      def bottom
        render(DaisyUI::Tooltip.new(position: :bottom, tip: 'hello', button: { text: 'Bottom' }, force_open: true))
      end

      def left
        render(DaisyUI::Tooltip.new(position: :left, tip: 'hello', button: { text: 'Left' }, force_open: true))
      end

      def right
        render(DaisyUI::Tooltip.new(position: :right, tip: 'hello', button: { text: 'Right' }, force_open: true))
      end

      def force_open
        render(DaisyUI::Tooltip.new(tip: 'hello', button: { text: 'Forced open' }, force_open: true))
      end

      def primary_color
        render(DaisyUI::Tooltip.new(color: :primary, tip: 'primary', button: { text: 'primary', color: :primary }, force_open: true))
      end

      def secondary_color
        render(DaisyUI::Tooltip.new(color: :secondary, tip: 'secondary', button: { text: 'secondary', color: :secondary }, force_open: true))
      end

      def accent_color
        render(DaisyUI::Tooltip.new(color: :accent, tip: 'accent', button: { text: 'accent', color: :accent }, force_open: true))
      end

      def neutral_color
        render(DaisyUI::Tooltip.new(color: :neutral, tip: 'neutral', button: { text: 'neutral', color: :neutral }, force_open: true))
      end

      def info_color
        render(DaisyUI::Tooltip.new(color: :info, tip: 'info', button: { text: 'info', color: :info }, force_open: true))
      end

      def success_color
        render(DaisyUI::Tooltip.new(color: :success, tip: 'success', button: { text: 'success', color: :success }, force_open: true))
      end

      def warning_color
        render(DaisyUI::Tooltip.new(color: :warning, tip: 'warning', button: { text: 'warning', color: :warning }, force_open: true))
      end

      def error_color
        render(DaisyUI::Tooltip.new(color: :error, tip: 'error', button: { text: 'error', color: :error }, force_open: true))
      end

      def responsive_tooltip_only_show_for_large_screen
        render(DaisyUI::Tooltip.new(responsive: :lg, tip: 'Large screen and up', button: { text: 'lg+ only' }, force_open: true))
      end

      def tooltip_with_tooltip_content
        render(DaisyUI::Tooltip.new(tip: 'Tooltip', force_open: true)) do
          tag.span('I have a tooltip')
        end
      end

      def button_customization_example
        render(DaisyUI::Tooltip.new(
          tip: 'Custom button', 
          button: { text: 'Custom', color: :primary, size: :lg, variant: :outline },
          force_open: true
        ))
      end
    end
  end
end