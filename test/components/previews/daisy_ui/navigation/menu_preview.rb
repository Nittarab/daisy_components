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
      # @param rounded [Boolean] toggle Apply `rounded-box` styling (default: true). Only if not horizontal and no other `rounded-*` class is provided.
      # @param custom_classes [String] text "Custom CSS classes (e.g., 'bg-neutral w-64 text-primary')"
      def playground(
        size: :md,
        direction: :vertical,
        responsive_direction: nil,
        rounded: true,
        custom_classes: 'bg-base-200 w-56' # Default to show component defaults
      )
        render DaisyUI::Menu.new(
          size: size,
          direction: direction,
          responsive_direction: responsive_direction,
          rounded: rounded,
          class: custom_classes
        ) do |menu|
          menu.with_title(text: 'Navigation')
          menu.with_item(text: 'Home', href: '#', active: true, icon_start: home_icon(class: 'w-4 h-4'))
          menu.with_item(text: 'Messages', href: '#', badge: '99+', icon_start: email_icon(class: 'w-4 h-4'))
          menu.with_item(text: 'Analytics', href: '#', icon_start: phosphor_icon('ph-chart-bar', class: 'w-4 h-4'), icon_end: chevron_down_icon(class: 'w-4 h-4'))
          menu.with_submenu(parent_text: 'Products') do |submenu|
            submenu.with_item(text: 'Laptops', href: '#')
            submenu.with_item(text: 'Phones', href: '#')
          end
        end
      end

      # @!endgroup

      # def collapsible_submenu_that_works_with_class_names; end
      def collapsible_submenu; end
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
          rounded: false,
          class: 'bg-base-200',
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

      # Collapsible submenu
      # ---
      # Menu with collapsible nested submenus
      def collapsible_submenu
        render DaisyUI::Menu.new(
          rounded: true,
          class: 'bg-base-200 w-56'
        ) do |menu|
          menu.with_item(text: 'Item 1', href: '#')
          menu.with_submenu(collapsible: true, open: true) do |submenu|
            submenu.with_summary(text: 'Parent')
            submenu.with_item(text: 'Submenu 1', href: '#')
            submenu.with_item(text: 'Submenu 2', href: '#')
            submenu.with_submenu(collapsible: true, open: true) do |nested_submenu|
              nested_submenu.with_summary(text: 'Nested Parent')
              nested_submenu.with_item(text: 'Submenu 1', href: '#')
              nested_submenu.with_item(text: 'Submenu 2', href: '#')
            end
          end
          menu.with_item(text: 'Item 3', href: nil)
        end
      end
    end
  end
end
