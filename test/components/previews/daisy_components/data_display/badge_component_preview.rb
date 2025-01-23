# frozen_string_literal: true

# @label Badge
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class BadgeComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Defaulttest/components/previews/daisy_components/data_display/badge_component_preview.rb
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
        component = BadgeComponent.new(text, variant: variant, size: size, outline: outline, class: classes)
        render_with_template(template: 'playground', locals: { component: component })
      end

      # @!endgroup

      # @!group Examples

      # Basic Badge
      # ---------------
      # Simple badge with default styling
      #
      # @label Basic
      def default
        component = BadgeComponent.new('Badge')
        render_with_template(template: 'default', locals: { component: component })
      end

      # Block Content
      # ---------------
      # Badge with custom block content
      #
      # @label Block
      def with_block
        component = BadgeComponent.new
        render_with_template(template: 'with_block', locals: { component: component })
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
        component = BadgeComponent.new(class: 'gap-2')
        render_with_template(template: 'with_icon', locals: { component: component })
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
