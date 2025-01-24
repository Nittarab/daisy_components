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
      # @param variant select { choices: [neutral, primary, secondary, accent, ghost, info, success, warning, error] }
      #  "Visual style"
      # @param size select { choices: [xs, sm, md, lg] } "Badge size"
      # @param outline toggle "Show outlined style"
      # @param classes text "Additional CSS classes"
      def playground(
        text: 'Badge',
        variant: nil,
        size: nil,
        outline: false,
        classes: ''
      )
        render(BadgeComponent.new(text, variant: variant, size: size, outline: outline, class: classes))
      end
      # @!endgroup

      # @!group Simple Examples
      # Basic Badge
      # ---------------
      # Simple badge with default styling
      #
      # @label Basic
      def default
        render(BadgeComponent.new('Default Badge'))
      end

      # With Icon
      # ---------------
      # Badge with an icon
      #
      # @label Icon
      def with_icon
        render(BadgeComponent.new('Icon Badge', icon: chevron_down_icon('h-6 w-6')))
      end

      # Block Content
      # ---------------
      # Badge with custom block content
      #
      # @label Block
      def with_block
        render(BadgeComponent.new('Block Badge'))
      end
      # @!endgroup

      # @!group Complex Examples
      # In Button
      # ---------------
      # Badge used within a button
      #
      # @label In Button
      def in_button
        render_with_template
      end
      # @!endgroup

      # @!group Variants Gallery
      # Badge Colors
      # ---------------
      # All available badge colors
      #
      # @label Colors
      def colors
        render_with_template(locals: { variants: BadgeComponent::VARIANTS })
      end

      # Outline Style
      # ---------------
      # Badges with outline style
      #
      # @label Outline
      def outline
        render_with_template(locals: { variants: BadgeComponent::VARIANTS })
      end
      # @!endgroup

      # @!group Sizes Gallery
      # Badge Sizes
      # ---------------
      # All available badge sizes
      #
      # @label Sizes
      def sizes
        render_with_template(locals: { sizes: BadgeComponent::SIZES })
      end
      # @!endgroup
    end
  end
end
