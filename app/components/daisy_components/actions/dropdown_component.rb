# frozen_string_literal: true

module DaisyComponents
  module Actions
    # Dropdown component implementing DaisyUI's dropdown styles
    #
    # @example Basic usage
    #   <%= render(DropdownComponent.new(
    #     trigger: { text: "Click me" },
    #     items: [
    #       { text: "Item 1", href: "#" },
    #       { text: "Item 2", href: "#" }
    #     ]
    #   )) %>
    #
    # @example With position and hover
    #   <%= render(DropdownComponent.new(
    #     position: :top,
    #     hover: true,
    #     trigger: {
    #       text: "Settings",
    #       icon: helpers.cog_icon("h-5 w-5"),
    #       variant: :ghost
    #     },
    #     items: [
    #       { text: "Profile", href: "/profile", icon: helpers.user_icon("h-5 w-5") },
    #       { text: "Settings", href: "/settings", icon: helpers.cog_icon("h-5 w-5") },
    #       { type: :divider },
    #       { text: "Logout", href: "/logout", variant: :error }
    #     ]
    #   )) %>
    class DropdownComponent < BaseComponent
      # Available dropdown positions from DaisyUI
      POSITIONS = %w[top top-end top-center bottom bottom-end bottom-center left left-end left-center right right-end
                     right-center].freeze
      VARIANTS = %w[primary secondary accent info success warning error ghost neutral].freeze
      SIZES = %w[xs sm md lg].freeze
      ALIGNMENTS = %w[start end center].freeze

      # @param position [String] Position of the dropdown content relative to the trigger (top/bottom/left/right)
      # @param hover [Boolean, String] When true or 'content', opens the dropdown on hover instead of click
      # @param open [Boolean] When true, forces the dropdown to stay open
      # @param align [String] When start, end, or center, aligns the dropdown content to the trigger
      # @param variant [String] Button variant for the trigger (primary/secondary/accent/etc)
      # @param size [String] Size of the trigger button (xs/sm/md/lg)
      # @param trigger [Hash] Configuration for the trigger button
      # @param items [Array<Hash>] Array of menu items
      # @param header [Hash] Configuration for the dropdown header
      # @param footer [Hash] Configuration for the dropdown footer
      # @param menu_class [String] Additional classes for the menu
      # @param menu_tabindex [Integer, nil] Tabindex for the menu (defaults to 0)
      # @param system_arguments [Hash] Additional HTML attributes to be applied to the dropdown container
      def initialize(position: nil, hover: false, open: false, align: nil,
                     variant: nil, size: nil, trigger: {}, items: [],
                     header: nil, footer: nil, menu_class: nil, menu_tabindex: 0, **system_arguments)
        @position = position if POSITIONS.include?(position.to_s)
        @hover = hover
        @open = open
        @align = align if ALIGNMENTS.include?(align.to_s)
        @variant = variant if VARIANTS.include?(variant.to_s)
        @size = size if SIZES.include?(size.to_s)
        @trigger = trigger
        @items = items
        @header = header
        @footer = footer
        @menu_class = menu_class
        @menu_tabindex = menu_tabindex
        super(**system_arguments)
      end

      def call
        tag.div(**dropdown_arguments) do
          safe_join([
            render_trigger,
            content || render_menu
          ].compact)
        end
      end

      private

      def dropdown_arguments
        {
          class: computed_dropdown_classes,
          **system_arguments.except(:class)
        }.compact
      end

      def computed_dropdown_classes
        modifiers = []
        modifiers << 'dropdown'
        modifiers << "dropdown-#{@position}" if @position
        modifiers << 'dropdown-hover' if @hover == true
        modifiers << 'dropdown-hover-content' if @hover == 'content'
        modifiers << 'dropdown-open' if @open
        modifiers << "dropdown-#{@align}" if @align

        class_names(modifiers.join(' '), system_arguments[:class])
      end

      def computed_trigger_classes
        # Order: base -> variant -> size -> custom
        modifiers = []
        modifiers << 'btn'
        modifiers << "btn-#{@variant}" if @variant
        modifiers << "btn-#{@size}" if @size

        class_names(modifiers.join(' '), @trigger[:class])
      end

      def computed_menu_classes
        # Order: base -> custom/default
        modifiers = []
        modifiers << 'dropdown-content menu'
        modifiers << (@menu_class || 'bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm')

        class_names(modifiers.join(' '))
      end

      def render_trigger
        tag.div(
          tabindex: 0,
          role: 'button',
          class: computed_trigger_classes
        ) do
          safe_join([
            @trigger[:icon],
            @trigger[:text]
          ].compact)
        end
      end

      def render_menu
        return unless @items.any?

        menu_classes = @menu_class || 'dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm'

        tag.ul(tabindex: @menu_tabindex, class: menu_classes) do
          safe_join([
            render_header,
            render_items,
            render_footer
          ].compact)
        end
      end

      def render_header
        return unless @header

        tag.div(class: 'dropdown-header') do
          if @header[:title]
            tag.div(class: 'text-lg font-bold') { @header[:title] }
          else
            @header[:content]
          end
        end
      end

      def render_footer
        return unless @footer

        tag.div(class: 'dropdown-footer mt-2 border-t pt-2') do
          @footer[:content]
        end
      end

      def render_items
        safe_join(@items.map { |item| render_menu_item(item) })
      end

      def render_menu_item(item)
        return tag.li(class: 'divider') if item[:type] == :divider

        tag.li do
          tag.a(class: item[:variant] ? "text-#{item[:variant]}" : nil) do
            safe_join([
              item[:icon],
              item[:text]
            ].compact)
          end
        end
      end
    end
  end
end
