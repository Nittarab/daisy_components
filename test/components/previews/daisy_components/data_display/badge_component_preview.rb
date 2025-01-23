# frozen_string_literal: true

# @label Badge
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class BadgeComponentPreview < ViewComponent::Preview
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

      # @!group Examples

      # Basic Badge
      # ---------------
      # Simple badge with default styling
      #
      # @label Basic
      def default
        render(BadgeComponent.new('Default Badge'))
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

      # @!group Variants

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

      # @!group Sizes

      # Badge Sizes
      # ---------------
      # All available badge sizes
      #
      # @label Sizes
      def sizes
        render_with_template(locals: { sizes: BadgeComponent::SIZES })
      end

      # @!endgroup

      # @!group Examples

      # With Icon
      # ---------------
      # Badge with an icon
      #
      # @label Icon
      def with_icon
        icon = '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" /></svg>'
        render(BadgeComponent.new('Icon Badge', icon: icon))
      end

      # In Button
      # ---------------
      # Badge used within a button
      #
      # @label In Button
      def in_button
        render_with_template
      end

      # @!endgroup
    end
  end
end
