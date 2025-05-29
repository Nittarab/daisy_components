# frozen_string_literal: true

module DaisyUI
  # Menu component implementing DaisyUI's menu styles
  #
  # @example Basic usage
  #   <%= render(DaisyUI::Menu.new(
  #     items: [
  #       { text: "Item 1", href: "/item1" },
  #       { text: "Item 2", href: "/item2", active: true }
  #     ]
  #   )) %>
  #
  # @example Horizontal menu
  #   <%= render(DaisyUI::Menu.new(
  #     direction: :horizontal,
  #     items: [
  #       { text: "Home", href: "/" },
  #       { text: "About", href: "/about" }
  #     ]
  #   )) %>
  #
  # @example With block content
  #   <%= render(DaisyUI::Menu.new) do |menu| %>
  #     <% menu.with_title(text: "Navigation") %>
  #     <% menu.with_item(text: "Dashboard", href: "/dashboard", active: true) %>
  #     <% menu.with_item(text: "Settings", href: "/settings") %>
  #   <% end %>
  #
  # @example With submenu
  #   <%= render(DaisyUI::Menu.new) do |menu| %>
  #     <% menu.with_item(text: "Home", href: "/") %>
  #     <% menu.with_submenu do |submenu| %>
  #       <% submenu.with_item(text: "Sub 1", href: "/sub1") %>
  #       <% submenu.with_item(text: "Sub 2", href: "/sub2") %>
  #     <% end %>
  #   <% end %>
  class Menu < BaseComponent
    # Available menu sizes from DaisyUI
    SIZES = {
      xs: 'menu-xs',
      sm: 'menu-sm',
      md: 'menu-md',
      lg: 'menu-lg',
      xl: 'menu-xl'
    }.freeze

    # Available menu directions
    DIRECTIONS = {
      vertical: 'menu-vertical',
      horizontal: 'menu-horizontal'
    }.freeze

    # Responsive direction modifiers
    RESPONSIVE_DIRECTIONS = {
      lg_horizontal: 'lg:menu-horizontal',
      xl_horizontal: 'xl:menu-horizontal'
    }.freeze

    renders_many :items, lambda { |**system_arguments|
      DaisyUI::Menu::Item.new(**system_arguments)
    }

    renders_many :titles, lambda { |**system_arguments|
      DaisyUI::Menu::Title.new(**system_arguments)
    }

    renders_many :submenus, lambda { |collapsible: false, open: false, **system_arguments|
      DaisyUI::Menu::Submenu.new(collapsible: collapsible, open: open, **system_arguments)
    }

    # @param items [Array<Hash>] Simple array of menu items (optional)
    # @param size [Symbol] Menu size (:xs, :sm, :md, :lg, :xl)
    # @param direction [Symbol] Menu direction (:vertical, :horizontal)
    # @param responsive_direction [Symbol] Responsive direction (:lg_horizontal, :xl_horizontal)
    # @param padding [Boolean] Whether to include default padding (default: true)
    # @param rounded [Boolean] Whether to apply `rounded-box` styling (default: true).
    #   Only applies if menu is not horizontal and no other `rounded-*` class is provided via `system_arguments[:class]`.
    # @param system_arguments [Hash] Additional HTML attributes.
    #   Use `class` to pass specific `bg-*` (defaults to `bg-base-200` if none provided)
    #   and `w-*` (defaults to `w-56` for non-horizontal menus if none provided) utility classes.
    #   Also, providing a `rounded-*` class here will override the `rounded` parameter.
    def initialize(
      items: nil,
      size: nil,
      direction: nil,
      responsive_direction: nil,
      rounded: true,
      **system_arguments
    )
      @items_data = items
      @size = build_argument(size, SIZES, 'size')
      @direction = build_argument(direction, DIRECTIONS, 'direction') if direction
      @responsive_direction = build_argument(responsive_direction, RESPONSIVE_DIRECTIONS, 'responsive_direction')
      @rounded = rounded

      super(**system_arguments)
    end

    def before_render
      return unless @items_data

      @items_data.each do |item_data|
        with_item(**item_data)
      end
    end

    def call
      tag.ul(**html_attributes) do
        safe_join([
                    content,
                    items,
                    titles,
                    submenus
                  ])
      end
    end

    # # Override with_item to track order
    # def with_item(**system_arguments)
    #   item = super
    #   @ordered_elements << { type: :item, element: item }
    #   item
    # end

    # # Override with_submenu to track order
    # def with_submenu(collapsible: false, open: false, **system_arguments, &)
    #   submenu = super(**system_arguments, &)
    #   submenu.collapsible = collapsible
    #   submenu.open = open
    #   @ordered_elements << { type: :submenu, element: submenu }
    #   submenu
    # end

    # # Override with_title to track order
    # def with_title(**system_arguments)
    #   title = super
    #   @ordered_elements << { type: :title, element: title }
    #   title
    # end

    private

    def computed_classes
      modifiers = ['menu']
      modifiers << @size if @size.present?
      modifiers << @direction if @direction.present?
      modifiers << @responsive_direction if @responsive_direction.present?
      modifiers << 'rounded-box' if @rounded

      class_names(modifiers, system_arguments[:class])
    end

    def html_attributes
      system_arguments.merge(class: computed_classes)
    end
  end
end
