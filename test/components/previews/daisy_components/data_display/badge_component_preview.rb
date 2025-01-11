# frozen_string_literal: true

# @label Badge
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class BadgeComponentPreview < Lookbook::Preview
      # @!group Playground

      # @title Default
      # @description Interactive badge component with customizable styling
      #
      # @param text text "Text content inside the badge"
      # @param variant select { choices: [neutral, primary, secondary, accent, ghost, info, success, warning, error] } "Visual style"
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
        render(BadgeComponent.new(
                 text,
                 variant:,
                 size:,
                 outline:,
                 class: classes
               ))
      end

      # @!endgroup

      # @!group Examples

      # Basic Badge
      # ---------------
      # Simple badge with default styling
      #
      # @label Basic
      def default
        render(BadgeComponent.new('Badge'))
      end

      # Block Content
      # ---------------
      # Badge with custom block content
      #
      # @label Block
      def with_block
        render(BadgeComponent.new) do
          'Block content'
        end
      end

      # @!endgroup

      # @!group Variants

      # Badge Colors
      # ---------------
      # All available badge colors
      #
      # @label Colors
      def colors
        render_with_template(locals: {
                               variants: BadgeComponent::VARIANTS
                             })
      end

      # Outline Style
      # ---------------
      # Badges with outline style
      #
      # @label Outline
      def outline
        render_with_template(locals: {
                               variants: BadgeComponent::VARIANTS
                             })
      end

      # @!endgroup

      # @!group Sizes

      # Badge Sizes
      # ---------------
      # All available badge sizes
      #
      # @label Sizes
      def sizes
        render_with_template(locals: {
                               sizes: BadgeComponent::SIZES
                             })
      end

      # @!endgroup

      # @!group Examples

      # With Icon
      # ---------------
      # Badge with an icon
      #
      # @label Icon
      def with_icon
        render(BadgeComponent.new(class: 'gap-2')) do
          safe_join([
                      tag.svg(
                        xmlns: 'http://www.w3.org/2000/svg',
                        fill: 'none',
                        viewBox: '0 0 24 24',
                        class: 'inline-block w-4 h-4 stroke-current'
                      ) do
                        tag.path(
                          'stroke-linecap': 'round',
                          'stroke-linejoin': 'round',
                          'stroke-width': '2',
                          d: 'M6 18L18 6M6 6l12 12'
                        )
                      end,
                      'Badge'
                    ])
        end
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
