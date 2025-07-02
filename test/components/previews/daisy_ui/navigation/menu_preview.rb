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
        custom_classes: 'bg-base-200 w-56'
      )
        render DaisyUI::Menu.new(
          title: 'Playground Menu',
          size: size,
          direction: direction,
          responsive_direction: responsive_direction,
          rounded: rounded,
          class: custom_classes,
          items: [
            { text: 'Home', href: '#', active: true, icon_start: home_icon(class: 'text-2xl') },
            { text: 'Messages', href: '#', badge: { text: '99+' }, icon_start: email_icon(class: 'text-2xl') },
            { text: 'Analytics', href: '#', icon_start: phosphor_icon('ph-chart-bar', class: 'text-2xl'), badge: { text: 'New', class: 'badge-neutral' } }
          ]
        )
      end

      # @!endgroup

      # Horizontal menu
      # ---
      # Menu with horizontal layout, using the `items` parameter for conciseness.
      def horizontal_menu
        render DaisyUI::Menu.new(
          direction: :horizontal,
          rounded: false,
          class: 'bg-base-200',
          items: [
            { text: 'Item 1' },
            { text: 'Item 2' },
            { text: 'Item 3' }
          ]
        )
      end

      # Menu sizes
      # ---
      # Different menu sizes
      def menu_sizes
        render_with_template
      end

      # Menu
      # ---
      # Basic menu with items, using the `items` parameter.
      def menu
        render DaisyUI::Menu.new(
          class: 'bg-base-200 w-56',
          rounded: true,
          items: [
            { text: 'Item 1', href: '#' },
            { text: 'Item 2', href: '#' },
            { text: 'Item 3', href: '#' }
          ]
        )
      end

      # Menu with a title, using the `title` and `items` parameters.
      def menu_with_title
        render DaisyUI::Menu.new(
          title: 'Title',
          class: 'bg-base-200 w-56',
          items: [
            { text: 'Item 1', href: '#' },
            { text: 'Item 2', href: '#' },
            { text: 'Item 3', href: '#' }
          ],
          rounded: true
        )
      end

      # Menu with disabled items
      # ---
      # Demonstrates disabled items using the `items` parameter.
      def menu_with_disabled_items
        render DaisyUI::Menu.new(
          class: 'bg-base-200 w-56',
          rounded: true,
          items: [
            { text: 'Enabled item', href: '#' },
            { text: 'disabled item', href: '#', disabled: true },
            { text: 'disabled item', href: '#', disabled: true }
          ]
        )
      end

      # Menu with an active item
      # ---
      # Demonstrates an active item using the `items` parameter.
      def menu_with_active_item
        render DaisyUI::Menu.new(
          class: 'bg-base-200 w-56',
          items: [
            { text: 'Item 1', href: '#' },
            { text: 'Item 2', href: '#', active: true },
            { text: 'Item 3', href: '#' }
          ],
          rounded: false
        )
      end

      # def menu_with_icon_only_horizontal_with_tooltip; end TODO once we have tooltip

      def menu_with_icon_only_horizontal
        render DaisyUI::Menu.new(
          direction: :horizontal,
          class: 'bg-base-200 rounded-box',
          items: [
            { href: '#', icon_start: home_icon(class: 'text-2xl') },
            { href: '#', icon_start: info_icon(class: 'text-2xl') },
            { href: '#', icon_start: phosphor_icon('ph-chart-bar', class: 'text-2xl') }
          ]
        )
      end

      # def menu_with_icon_only_with_tooltip; end TODO once we have tooltip
      def menu_with_icon_only
        render DaisyUI::Menu.new(
          class: 'bg-base-200',
          rounded: true,
          items: [
            { href: '#', icon_start: home_icon(class: 'text-2xl') },
            { href: '#', icon_start: info_icon(class: 'text-2xl') },
            { href: '#', icon_start: phosphor_icon('ph-chart-bar', class: 'text-2xl') }
          ]
        )
      end

      def menu_with_icons_and_badge_responsive
        render DaisyUI::Menu.new(
          responsive_direction: :lg_horizontal,
          class: 'bg-base-200',
          rounded: true,
          items: [
            { href: '#', icon_start: phosphor_icon('ph-envelope', class: 'text-2xl'), text: 'Inbox', badge: { text: '99+', size: :xs } },
            { href: '#', icon_start: phosphor_icon('ph-info', class: 'text-2xl'), text: 'Updates', badge: { text: 'New', color: :warning, size: :xs } },
            { href: '#', icon_start: phosphor_icon('ph-chart-bar', class: 'text-2xl'), text: 'Stats', badge: { text: 'New', color: :info, size: :xs } }
          ]
        )
      end

      def menu_with_icons
        render DaisyUI::Menu.new(
          class: 'bg-base-200 w-56',
          rounded: true,
          items: [
            { href: '#', icon_start: phosphor_icon('ph-house', class: 'text-2xl'), text: 'Item 1' },
            { href: '#', icon_start: phosphor_icon('ph-info', class: 'text-2xl'), text: 'Item 2' },
            { href: '#', icon_start: phosphor_icon('ph-chart-bar', class: 'text-2xl'), text: 'Item 3' }
          ]
        )
      end

      # def menu_with_title_as_a_parent; end # TODO
      def menu_without_padding_and_border_radius
        render DaisyUI::Menu.new(
          class: 'bg-base-200 w-56',
          padding: false,
          border_radius: false,
          items: [
            { href: '#', text: 'Item 1' },
            { href: '#', text: 'Item 2' },
            { href: '#', text: 'Item 3' }
          ]
        )
      end

      def responsive_vertical_on_small_screen_horizontal_on_large_screen
        render DaisyUI::Menu.new(
          direction: :vertical,
          responsive_direction: :lg_horizontal,
          class: 'bg-base-200',
          rounded: true,
          items: [
            { href: '#', text: 'Item 1' },
            { href: '#', text: 'Item 2' },
            { href: '#', text: 'Item 3' }
          ]
        )
      end
    end
  end
end
