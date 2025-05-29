# frozen_string_literal: true

# @label Menu
module DaisyUI
  module Navigation
    class MenuComponentPreview < ViewComponent::Preview
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
          menu.with_item(text: 'Home', href: '/', active: true)
          menu.with_item(text: 'About', href: '/about')
          menu.with_submenu(parent_text: 'Products') do |submenu|
            submenu.with_item(text: 'Laptops', href: '/laptops')
            submenu.with_item(text: 'Phones', href: '/phones')
          end
        end
      end

      # @!endgroup

      # Menu
      # ---
      # Basic menu with items
      def menu
        render DaisyUI::Menu.new(
          items: [
            { text: 'Item 1', href: '/item1' },
            { text: 'Item 2', href: '/item2', active: true },
            { text: 'Item 3', href: '/item3' }
          ]
        )
      end

      # Menu title
      # ---
      # Menu with title
      def menu_title
        render DaisyUI::Menu.new do |menu|
          menu.with_title(text: 'Title')
          menu.with_item(text: 'Item 1', href: '/item1')
          menu.with_item(text: 'Item 2', href: '/item2')
          menu.with_item(text: 'Item 3', href: '/item3')
        end
      end

      # Menu with icon
      # ---
      # Menu items with icons
      def menu_with_icon
        render DaisyUI::Menu.new do |menu|
          menu.with_item(text: 'Home', href: '/', icon_start: home_icon)
          menu.with_item(text: 'Details', href: '/details', icon_start: information_circle_icon)
          menu.with_item(text: 'Stats', href: '/stats', icon_start: chart_bar_icon)
        end
      end

      # Menu with badge
      # ---
      # Menu items with badges
      def menu_with_badge
        render DaisyUI::Menu.new do |menu|
          menu.with_item(text: 'Inbox', href: '/inbox', badge: '99+')
          menu.with_item(text: 'Updates', href: '/updates', badge: 'NEW')
          menu.with_item(text: 'Important', href: '/important', badge: '!')
        end
      end

      # Menu sizes
      # ---
      # Different menu sizes
      def menu_sizes
        render_with_template
      end

      # Horizontal menu
      # ---
      # Menu with horizontal layout
      def horizontal_menu
        render DaisyUI::Menu.new(
          direction: :horizontal,
          bg_color: 'bg-base-200',
          rounded: true,
          items: [
            { text: 'Item 1', href: '/item1' },
            { text: 'Item 2', href: '/item2', active: true },
            { text: 'Item 3', href: '/item3' }
          ]
        )
      end

      # Responsive menu
      # ---
      # Menu that becomes horizontal on large screens
      def responsive_menu
        render DaisyUI::Menu.new(
          responsive_direction: :lg_horizontal,
          items: [
            { text: 'Item 1', href: '/item1' },
            { text: 'Item 2', href: '/item2', active: true },
            { text: 'Item 3', href: '/item3' }
          ]
        )
      end

      # Submenu
      # ---
      # Menu with submenu
      def submenu
        render DaisyUI::Menu.new do |menu|
          menu.with_item(text: 'Item 1', href: '/item1')
          menu.with_submenu(parent_text: 'Parent') do |submenu|
            submenu.with_item(text: 'Submenu 1', href: '/sub1')
            submenu.with_item(text: 'Submenu 2', href: '/sub2')
          end
          menu.with_item(text: 'Item 3', href: '/item3')
        end
      end

      # File tree
      # ---
      # Complex nested menu structure
      def file_tree
        render_with_template
      end

      # Mega menu
      # ---
      # Large menu with multiple sections
      def mega_menu
        render DaisyUI::Menu.new(width: 'w-80') do |menu|
          menu.with_title(text: 'Navigation')

          menu.with_submenu(parent_text: 'Products') do |products|
            products.with_item(text: 'Laptops', href: '/laptops')
            products.with_item(text: 'Phones', href: '/phones')
            products.with_item(text: 'Tablets', href: '/tablets')
          end

          menu.with_submenu(parent_text: 'Services') do |services|
            services.with_item(text: 'Support', href: '/support')
            services.with_item(text: 'Training', href: '/training')
            services.with_item(text: 'Consulting', href: '/consulting')
          end

          menu.with_title(text: 'Account')
          menu.with_item(text: 'Profile', href: '/profile', icon_start: user_icon)
          menu.with_item(text: 'Settings', href: '/settings', icon_start: cog_icon)
          menu.with_item(text: 'Logout', href: '/logout', icon_start: logout_icon)
        end
      end

      private

      def home_icon(classes = 'h-6 w-6')
        svg_icon(classes: classes, viewbox: '0 0 24 24', stroke: 'currentColor', fill: 'none') do
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6')
        end
      end

      def information_circle_icon(classes = 'h-6 w-6')
        svg_icon(classes: classes, viewbox: '0 0 24 24', stroke: 'currentColor', fill: 'none') do
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z')
        end
      end

      def chart_bar_icon(classes = 'h-6 w-6')
        svg_icon(classes: classes, viewbox: '0 0 24 24', stroke: 'currentColor', fill: 'none') do
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z')
        end
      end

      def user_icon(classes = 'h-6 w-6')
        svg_icon(classes: classes, viewbox: '0 0 24 24', stroke: 'currentColor', fill: 'none') do
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z')
        end
      end

      def logout_icon(classes = 'h-6 w-6')
        svg_icon(classes: classes, viewbox: '0 0 24 24', stroke: 'currentColor', fill: 'none') do
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1')
        end
      end

      def cog_icon(classes = 'h-6 w-6')
        svg_icon(classes: classes, viewbox: '0 0 24 24', stroke: 'currentColor', fill: 'none') do
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z')
          path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: 'M15 12a3 3 0 11-6 0 3 3 0 016 0z')
        end
      end

      def svg_icon(classes:, viewbox:, stroke: nil, fill: nil, &)
        content_tag(:svg,
                    xmlns: 'http://www.w3.org/2000/svg',
                    class: classes,
                    fill: fill,
                    viewBox: viewbox,
                    stroke: stroke,
                    &)
      end

      def path(**attributes)
        tag.path(**attributes)
      end
    end
  end
end
