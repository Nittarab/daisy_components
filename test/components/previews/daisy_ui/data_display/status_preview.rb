# frozen_string_literal: true

# @label Status
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class StatusPreview < ViewComponent::Preview
      # @!group Playground
      # Default
      # ---------------
      # Interactive status component with customizable styling
      #
      # @param color select {choices: [neutral, primary, secondary, accent, info, success, warning, error]}
      # @param size select { choices: [xs, sm, md, lg, xl] }
      # @param classes text "Additional CSS classes"
      def playground(
        color: nil,
        size: nil,
        classes: ''
      )
        render(DaisyUI::Status.new(
                 color: color,
                 size: size,
                 class: classes
               ))
      end

      # @!endgroup
      #
      def status
        render(DaisyUI::Status.new(tag_type: :span))
      end

      def status_with_colors
        render_with_template
      end

      def status_with_sizes
        render_with_template
      end

      def status_online
        render(DaisyUI::Status.new(color: :success))
      end

      def status_offline
        render(DaisyUI::Status.new(color: :error))
      end
    end
  end
end
