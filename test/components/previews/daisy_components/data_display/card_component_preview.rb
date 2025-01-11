# frozen_string_literal: true

# @label Card
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class CardComponentPreview < Lookbook::Preview
      # @!group Playground

      # @title Default
      # @description Interactive card component with customizable content and styling
      #
      # @param bordered toggle "Add a border around the card"
      # @param glass toggle "Apply a glass morphism effect"
      # @param compact toggle "Use less padding for a more compact look"
      # @param image_full toggle "Make the figure/image span full width"
      # @param classes text "Additional CSS classes to apply to the card container"
      def playground(bordered: false, glass: false, compact: false, image_full: false, classes: '')
        render(CardComponent.new(
                 bordered:,
                 glass:,
                 compact:,
                 image_full:,
                 class: classes
               )) do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/400x200') }
          component.with_title { 'Card Title' }
          component.with_body { 'Card content goes here.' }
          component.with_actions do
            tag.button('Action', class: 'btn btn-primary')
          end
        end
      end

      # @!endgroup

      # @!group Variants

      # Card Variants
      # ---------------
      # Basic card with default styling
      #
      # @label Basic
      def basic
        render_with_template
      end

      # Card with Border
      # ---------------
      # Card with a border around its edges
      #
      # @label Bordered
      def bordered
        render_with_template
      end

      # Glass Effect
      # ---------------
      # Card with glass morphism effect
      #
      # @label Glass
      def glass
        render_with_template
      end

      # Full Width Image
      # ---------------
      # Card with image spanning full width
      #
      # @label Image Full
      def image_full
        render_with_template
      end

      # Side Image Layout
      # ---------------
      # Card with image placed on the side
      #
      # @label Side Image
      def side_image
        render_with_template
      end

      # Compact Layout
      # ---------------
      # Card with reduced padding
      #
      # @label Compact
      def compact
        render_with_template
      end

      # @!endgroup
    end
  end
end
