# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # @label Badge
    class BadgeComponentPreview < ViewComponent::Preview
      # @!group Playground

      # @label Playground
      # @param text text "Badge text"
      # @param variant select [neutral, primary, secondary, accent, ghost, info, success, warning, error]
      # @param size select [xs, sm, md, lg]
      # @param outline toggle
      def playground(
        text: 'Badge',
        variant: nil,
        size: nil,
        outline: false
      )
        render BadgeComponent.new(
          text,
          variant: variant,
          size: size,
          outline: outline
        )
      end

      # @!endgroup

      # @!group Basics

      # @label Default
      # @description Basic badge with default styling
      def default
        render BadgeComponent.new('Badge')
      end

      # @label With Block
      # @description Badge with block content
      def with_block
        render BadgeComponent.new do
          'Block content'
        end
      end

      # @!endgroup

      # @!group Variants

      # @label Colors
      # @description Badges in different colors
      def colors
        render_with_template(locals: {
                               variants: BadgeComponent::VARIANTS
                             })
      end

      # @label Outline
      # @description Outlined badges in different colors
      def outline
        render_with_template(locals: {
                               variants: BadgeComponent::VARIANTS
                             })
      end

      # @!endgroup

      # @!group Sizes

      # @label Sizes
      # @description Badges in different sizes
      def sizes
        render_with_template(locals: {
                               sizes: BadgeComponent::SIZES
                             })
      end

      # @!endgroup

      # @!group Examples

      # @label With Icon
      # @description Badge with an icon
      def with_icon
        render BadgeComponent.new(class: 'gap-2') do
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

      # @label In Button
      # @description Badge used within a button
      def in_button
        render_with_template
      end

      # @!endgroup
    end
  end
end
