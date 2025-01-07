# frozen_string_literal: true

module DaisyComponents
  module Actions
    # Dropdown component implementing DaisyUI's dropdown styles
    #
    # @example Basic usage
    #   <%= render(DropdownComponent.new) do %>
    #     <%= render(ButtonComponent.new(text: "Click me")) %>
    #     <ul class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52">
    #       <li><a>Item 1</a></li>
    #       <li><a>Item 2</a></li>
    #     </ul>
    #   <% end %>
    #
    # @example With position
    #   <%= render(DropdownComponent.new(position: "top")) do %>
    #     <%= render(ButtonComponent.new(text: "Dropdown")) %>
    #     <ul class="dropdown-content menu">
    #       <li><a>Item</a></li>
    #     </ul>
    #   <% end %>
    #
    # @example With hover
    #   <%= render(DropdownComponent.new(hover: true)) do %>
    #     <%= render(ButtonComponent.new(text: "Hover me")) %>
    #     <ul class="dropdown-content menu">
    #       <li><a>Item</a></li>
    #     </ul>
    #   <% end %>
    #
    # @example Forced open state
    #   <%= render(DropdownComponent.new(open: true)) do %>
    #     <%= render(ButtonComponent.new(text: "Always open")) %>
    #     <ul class="dropdown-content menu">
    #       <li><a>Item</a></li>
    #     </ul>
    #   <% end %>
    #
    # @example Right aligned
    #   <%= render(DropdownComponent.new(align_end: true)) do %>
    #     <%= render(ButtonComponent.new(text: "Right aligned")) %>
    #     <ul class="dropdown-content menu">
    #       <li><a>Item</a></li>
    #     </ul>
    #   <% end %>
    class DropdownComponent < BaseComponent
      # Available dropdown positions from DaisyUI
      POSITIONS = %w[end top bottom left right].freeze

      # @param position [String] Position of the dropdown content relative to the trigger (end/top/bottom/left/right)
      # @param hover [Boolean] When true, opens the dropdown on hover instead of click
      # @param open [Boolean] When true, forces the dropdown to stay open
      # @param align_end [Boolean] When true, aligns the dropdown content to the end (right) of the trigger
      # @param system_arguments [Hash] Additional HTML attributes to be applied to the dropdown container
      def initialize(position: nil, hover: false, open: false, align_end: false, **system_arguments)
        @position = position if POSITIONS.include?(position.to_s)
        @hover = hover
        @open = open
        @align_end = align_end
        super(**system_arguments)
      end

      def call
        tag.div(**dropdown_arguments) { content }
      end

      private

      def dropdown_arguments
        classes = class_names(
          'dropdown',
          "dropdown-#{@position}" => @position,
          'dropdown-hover' => @hover,
          'dropdown-open' => @open,
          'dropdown-end' => @align_end
        )

        {
          class: [classes, system_arguments[:class]].compact.join(' '),
          **system_arguments.except(:class)
        }.compact
      end
    end
  end
end
