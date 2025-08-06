# frozen_string_literal: true

# @label Loading
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class LoadingPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground
      # Default
      # ---------------
      # Interactive loading component with customizable styling
      #
      # @param type select {choices: [spinner, dots, ring, ball, bars, infinity]}
      # @param size select { choices: [xs, sm, md, lg] }
      # @param color select { choices: [primary, secondary, accent, neutral, info, success, warning, error] }
      # @param text text "Text to display below loading animation"
      # @param classes text "Additional CSS classes"
      def playground(
        type: :spinner,
        size: nil,
        color: nil,
        text: '',
        classes: ''
      )
        render(DaisyUI::Loading.new(
                 type: type,
                 size: size,
                 color: color,
                 text: text.presence,
                 class: classes
               ))
      end

      # @!endgroup

      def loading_spinner
        render(DaisyUI::Loading.new(type: :spinner))
      end

      def loading_dots
        render(DaisyUI::Loading.new(type: :dots))
      end

      def loading_ring
        render(DaisyUI::Loading.new(type: :ring))
      end

      def loading_ball
        render(DaisyUI::Loading.new(type: :ball))
      end

      def loading_bars
        render(DaisyUI::Loading.new(type: :bars))
      end

      def loading_infinity
        render(DaisyUI::Loading.new(type: :infinity))
      end

      def loading_sizes
        render_with_template
      end

      def loading_with_colors
        render_with_template
      end

      def loading_with_text
        render_with_template
      end
    end
  end
end
