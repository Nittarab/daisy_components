# frozen_string_literal: true

module DaisyUI
  module Layout
    class StackPreview < ViewComponent::Preview
      # @!group Playground

      # Playground
      # ---
      # Interactive playground for Stack component
      def playground
        render_with_template
      end

      def stacked_divs
        render_with_template
      end

      def stacked_cards_with_shadow
        render_with_template
      end

      def stacked_images
        render_with_template
      end
    end
  end
end
