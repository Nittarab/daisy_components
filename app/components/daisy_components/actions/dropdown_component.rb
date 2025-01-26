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
      POSITIONS = %w[top top-end bottom bottom-end left left-end right right-end].freeze
      VARIANTS = %w[primary secondary accent info success warning error ghost neutral].freeze
      SIZES = %w[xs sm md lg].freeze

      # @param position [String] Position of the dropdown content relative to the trigger (top/bottom/left/right)
      # @param hover [Boolean, String] When true or 'content', opens the dropdown on hover instead of click
      # @param open [Boolean] When true, forces the dropdown to stay open
      # @param align_end [Boolean] When true, aligns the dropdown content to the end (right) of the trigger
      # @param variant [String] Button variant for the trigger (primary/secondary/accent/etc)
      # @param size [String] Size of the trigger button (xs/sm/md/lg)
      # @param trigger [Hash] Configuration for the trigger button
      # @param items [Array<Hash>] Array of menu items
      # @param header [Hash] Configuration for the dropdown header
      # @param footer [Hash] Configuration for the dropdown footer
      # @param system_arguments [Hash] Additional HTML attributes to be applied to the dropdown container
      def initialize(position: nil, hover: false, open: false, align_end: false,
                     variant: nil, size: nil, trigger: nil, items: nil,
                     header: nil, footer: nil, **system_arguments)
        @position = position if POSITIONS.include?(position.to_s)
        @hover = hover
        @open = open
        @align_end = align_end
        @variant = variant if VARIANTS.include?(variant.to_s)
        @size = size if SIZES.include?(size.to_s)
        @trigger = trigger || {}
        @items = items || []
        @header = header
        @footer = footer
        super(**system_arguments)
      end

      def call
        tag.div(**dropdown_arguments) do
          safe_join([
                      render_trigger,
                      render_menu
                    ])
        end
      end

      private

      def dropdown_arguments
        classes = class_names(
          'dropdown',
          "dropdown-#{@position}" => @position,
          'dropdown-hover' => @hover == true,
          'dropdown-hover-content' => @hover == 'content',
          'dropdown-open' => @open,
          'dropdown-end' => @align_end
        )

        {
          class: [classes, system_arguments[:class]].compact.join(' '),
          **system_arguments.except(:class)
        }.compact
      end

      def render_trigger
        trigger_classes = class_names(
          'btn',
          "btn-#{@variant}" => @variant,
          "btn-#{@size}" => @size,
          @trigger[:class] => @trigger[:class]
        )

        tag.button(class: trigger_classes) do
          safe_join([
            @trigger[:icon],
            @trigger[:text]
          ].compact)
        end
      end

      def render_menu
        return unless @items.any?

        tag.ul(class: 'dropdown-content menu menu-sm z-[1] p-2 shadow bg-base-100 rounded-box w-52') do
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
          tag.a(href: item[:href], class: item[:variant] ? "text-#{item[:variant]}" : nil) do
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
