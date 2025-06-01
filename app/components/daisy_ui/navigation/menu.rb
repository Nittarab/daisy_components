# frozen_string_literal: true

module DaisyUI
  # Menu component implementing DaisyUI's menu styles
  #
  # @example Basic usage with slots
  #   <%= render(DaisyUI::Menu.new) do |menu| %>
  #     <% menu.with_item_element(text: "Item 1", href: "/item1") %>
  #     <% menu.with_item_element(text: "Item 2", href: "/item2", active: true) %>
  #   <% end %>
  #
  # @example Basic usage with parameters
  #   <%= render DaisyUI::Menu.new(
  #     items: [
  #       { text: "Item 1", href: "/item1" },
  #       { text: "Item 2", href: "/item2", active: true }
  #     ]
  #   ) %>
  #
  # @example Horizontal menu with parameters
  #   <%= render DaisyUI::Menu.new(
  #     direction: :horizontal,
  #     items: [
  #       { text: "Home", href: "/" },
  #       { text: "About", href: "/about" }
  #     ]
  #   ) %>
  #
  # @example With title and items using parameters
  #   <%= render DaisyUI::Menu.new(
  #     title: "Navigation",
  #     items: [
  #       { text: "Dashboard", href: "/dashboard", active: true },
  #       { text: "Settings", href: "/settings" }
  #     ]
  #   ) %>
  #
  # @example With title and items using slots
  #   <%= render(DaisyUI::Menu.new) do |menu| %>
  #     <% menu.with_title_element(text: "Navigation") %>
  #     <% menu.with_item_element(text: "Dashboard", href: "/dashboard", active: true) %>
  #     <% menu.with_item_element(text: "Settings", href: "/settings") %>
  #   <% end %>
  #
  # @note If both `title`/`items` parameters and a block with `with_title_element` or `with_item_element`
  #   are provided, the title and items from parameters will be rendered first,
  #   followed by elements defined in the block.

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

    # Polymorphic slot for menu elements.
    # Allows rendering different types of content like items or titles.
    # To add an item: `menu.with_element_item(**options)`
    # To add a title: `menu.with_element_title(**options)`
    renders_many :elements, types: {
      item: 'DaisyUI::Menu::Item',
      title: 'DaisyUI::Menu::Title'
      # You could add other types like divider: "DaisyUI::Menu::Divider"
    }

    # @param title [String] Optional title text. If provided, a title element is added at the beginning of the menu.
    # @param items [Array<Hash>] Optional array of item hashes. Each hash is passed as keyword arguments to
    #   `DaisyUI::Menu::Item.new`.  If provided, item elements are added after the title (if any).
    # @param size [Symbol] Menu size (:xs, :sm, :md, :lg, :xl)
    # @param direction [Symbol] Menu direction (:vertical, :horizontal)
    # @param responsive_direction [Symbol] Responsive direction (:lg_horizontal, :xl_horizontal)
    # @param rounded [Boolean] Whether to apply `rounded-box` styling (default: false).
    # @param padding [Boolean] Whether to apply `p-2` styling (default: true).
    # @param border_radius [Boolean] Whether to apply `rounded-box` styling (default: true).
    # @param system_arguments [Hash] Additional HTML attributes.
    def initialize(
      title: nil,
      items: nil,
      size: nil,
      direction: nil,
      responsive_direction: nil,
      rounded: false,
      padding: true,
      border_radius: true,
      **system_arguments
    )
      super(**system_arguments)

      with_element_title(text: title) if title.present?
      items&.each do |item_options|
        with_element_item(**item_options)
      end

      @size = build_argument(size, SIZES, 'size')
      @direction = build_argument(direction, DIRECTIONS, 'direction') if direction
      @responsive_direction = build_argument(responsive_direction, RESPONSIVE_DIRECTIONS, 'responsive_direction')
      @rounded = rounded
      @padding = padding
      @border_radius = border_radius
    end

    def call
      tag.ul(class: computed_classes, **system_arguments.except(:class)) do
        safe_join([
                    content,
                    elements
                  ])
      end
    end

    private

    def computed_classes
      modifiers = ['menu']
      modifiers << @size if @size.present?
      modifiers << @direction if @direction.present?
      modifiers << @responsive_direction if @responsive_direction.present?
      modifiers << 'rounded-box' if @rounded
      modifiers << 'p-0' unless @padding
      modifiers << '[&_li>*]:rounded-none' unless @border_radius

      class_names(modifiers, system_arguments[:class])
    end
  end
end
