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

      # Navbar with icon at start and end
      # ---
      # Navbar with icon at start and end
      def navbar_with_icon_at_start_and_end
        render_with_template(locals: { helper: self })
      end

      # Navbar with icon indicator and dropdown
      # ---
      # Navbar with icon indicator and dropdown
      # TODO we need to refactor the dropdown component at the moment only a buttons a trigger
      # def navbar_with_icon_indicator_and_dropdown
      #   render_with_template(locals: { helper: self })
      # end
      #
      #
      # Navbar with menu and submenu
      # ---
      # Navbar with menu and submenu
      # TODO add once we have a submenu component
      # def navbar_with_menu_and_submenu
      #   render_with_template(locals: { helper: self })
      # end

      # # Navbar with search input and dropdown
      # # ---
      # # Navbar with search input and dropdown
      # TODO we need to refactor the dropdown component at the moment only a buttons a trigger
      # def navbar_with_search_input_and_dropdown
      #   render_with_template(locals: { helper: self })
      # end

      # Navbar with title and icon
      # ---
      # Navbar with title and icon
      def navbar_with_title_and_icon
        render_with_template(locals: { helper: self })
      end

      # Navbar with title only
      # ---
      # Navbar with title only
      def navbar_with_title_only
        render_with_template
      end

      # Responsive dropdown menu on small screen center menu on large screen
      # ---
      # Responsive dropdown menu on small screen center menu on large screen
      def responsive_dropdown_menu_on_small_screen_center_menu_on_large_screen
        render_with_template(locals: { helper: self })
      end
    end
  end
end
