# frozen_string_literal: true

# @label Badge
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class BadgeComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

      # @!group Playground
      # Default
      # ---------------
      # Interactive badge component with customizable styling
      #
      # @param text text "Text content inside the badge"
      # @param color select {choices: [neutral, primary, secondary, accent, info, success, warning, error, ghost]}
      # @param size select { choices: [xs, sm, md, lg, xl] }
      # @param variant select { choices: [outline, soft, dash, ghost] }
      # @param has_icon toggle "Add icon"
      # @param classes text "Additional CSS classes"
      def playground(
        text: 'Badge',
        color: nil,
        size: nil,
        variant: nil,
        has_icon: false,
        classes: ''
      )
        render(BadgeComponent.new(
                 text,
                 color: color,
                 size: size,
                 variant: variant,
                 icon: has_icon ? check_icon('h-4 w-4') : nil,
                 class: classes
               ))
      end

      # @!endgroup
      #
      def badge
        render(BadgeComponent.new('Badge', tag_type: :span))
      end

      def badge_ghost
        render(BadgeComponent.new('ghost', variant: :ghost))
      end

      def badge_sizes
        render_with_template
      end

      def badge_with_colors
        render_with_template
      end

      def badge_with_icon
        render_with_template(locals: { helper: self })
      end

      def badge_with_outline_style
        render_with_template
      end

      def badge_with_soft_style
        render_with_template
      end

      def empty_badge
        render_with_template
      end
    end
  end
end
