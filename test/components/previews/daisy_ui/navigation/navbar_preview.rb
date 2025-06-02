# frozen_string_literal: true

module DaisyUI
  module Navigation
    class NavbarPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper
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

      # Navbar with dropdown center logo and icon
      # ---
      # Navbar with dropdown center logo and icon
      def navbar_with_dropdown_center_logo_and_icon
        render_with_template(locals: { helper: self })
      end
    end
  end
end
