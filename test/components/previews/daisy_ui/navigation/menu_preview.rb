# frozen_string_literal: true

# @label Menu
module DaisyUI
  module Navigation
    class MenuPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Playground
      # ---
      # Interactive playground for Menu component
      # @param size [Symbol] select { choices: [xs, sm, md, lg, xl] }
      # @param direction [Symbol] select { choices: [vertical, horizontal] }
      # @param responsive_direction [Symbol] select { choices: [lg_horizontal, xl_horizontal] }
      # @param bg_color [String] text "Background color classes"
      # @param rounded [Boolean] toggle
      # @param width [String] text "Width classes"
      # @param padding [Boolean] toggle
      def playground(
        size: :md,
        direction: :vertical,
        responsive_direction: nil,
        bg_color: 'bg-base-200',
        rounded: true,
        width: 'w-56',
        padding: true
      )
        render DaisyUI::Menu.new(
          size: size,
          direction: direction,
          responsive_direction: responsive_direction,
          bg_color: bg_color,
          rounded: rounded,
          width: width,
          padding: padding
        ) do |menu|
          menu.with_title(text: 'Navigation')
          menu.with_item(text: 'Home', href: '#', active: true)
          menu.with_item(text: 'About', href: '#')
          menu.with_submenu(parent_text: 'Products') do |submenu|
            submenu.with_item(text: 'Laptops', href: '#')
            submenu.with_item(text: 'Phones', href: '#')
          end
        end
      end

      # @!endgroup

      # def collapsible_submenu_that_works_with_class_names; end
      # def collapsible_submenu; end
      # def collapsible_with_submenu_responsive; end

      # File tree
      # ---
      # Complex nested menu structure
      def file_tree
        render_with_template(locals: {
                               helper: self
                             })
      end

      # Horizontal menu
      # ---
      # Menu with horizontal layout
      def horizontal_menu
        render DaisyUI::Menu.new(
          direction: :horizontal,
          bg_color: 'bg-base-200',
          rounded: false,
          items: [
            { text: 'Item 1', href: nil },
            { text: 'Item 2', href: nil },
            { text: 'Item 3', href: nil }
          ]
        )
      end

      # def horizontal_submenu; end
      # def mega_menu_with_submenu_responsive; end

      # Menu sizes
      # ---
      # Different menu sizes
      def menu_sizes
        render_with_template
      end

      # def menu_with_active_item; end
      # def menu_with_disabled_items; end
      # def menu_with_icon_only_horizontal_with_tooltip; end
      # def menu_with_icon_only_horizontal; end
      # def menu_with_icon_only_with_tooltip; end
      # def menu_with_icon_only; end
      # def menu_with_icons_and_badge_responsive; end
      # def menu_with_icons; end
      # def menu_with_title_as_a_parent; end
      # def menu_with_title; end
      # def menu_without_padding_and_border_radius; end

      # Menu
      # ---
      # Basic menu with items
      def menu
        render DaisyUI::Menu.new(
          items: [
            { text: 'Item 1', href: '#' },
            { text: 'Item 2', href: '#' },
            { text: 'Item 3', href: '#' }
          ]
        )
      end

      # def responsive_vertical_on_small_screen_horizontal_on_large_screen; end

      # Submenu
      # ---
      # Menu with submenu
      def submenu
        render_with_template
      end
    end
  end
end
