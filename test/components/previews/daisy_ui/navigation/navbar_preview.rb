# frozen_string_literal: true

module DaisyUI
  module Navigation
    class NavbarPreview < ViewComponent::Preview
      # layout 'full_width'
      # @!group Playground

      # Playground
      # ---
      # Interactive playground for Navbar component
      def playground
        render_with_template
      end

      # @!endgroup

      # Navbar with colors
      # ---
      # Navbar with different colors
      def navbar_with_colors
        render_with_template
      end
    end
  end
end
