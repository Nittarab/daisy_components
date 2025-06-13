# frozen_string_literal: true

module DaisyUI
  # Breadcrumbs component implementing DaisyUI's breadcrumbs styles
  #
  # @example Basic usage with parameters
  #   <%= render DaisyUI::Breadcrumbs.new(
  #     items: [
  #       { text: "Home", href: "/" },
  #       { text: "Documents", href: "/documents" },
  #       { text: "Add Document" }
  #     ]
  #   ) %>
  #
  # @example With icons using parameters
  #   <%= render DaisyUI::Breadcrumbs.new(
  #     items: [
  #       { text: "Home", href: "/", icon: phosphor_icon('ph-house') },
  #       { text: "Documents", href: "/documents", icon: phosphor_icon('ph-folder') },
  #       { text: "Add Document", icon: phosphor_icon('ph-plus') }
  #     ]
  #   ) %>
  #
  # @example With size and custom styling
  #   <%= render DaisyUI::Breadcrumbs.new(
  #     size: :lg,
  #     class: "max-w-xs",
  #     items: [
  #       { text: "Long text 1" },
  #       { text: "Long text 2" },
  #       { text: "Long text 3" }
  #     ]
  #   ) %>
  #
  # @example Using slots for complex items
  #   <%= render(DaisyUI::Breadcrumbs.new) do |breadcrumbs| %>
  #     <% breadcrumbs.with_item(href: "/") { "Home" } %>
  #     <% breadcrumbs.with_item(href: "/documents") { "Documents" } %>
  #     <% breadcrumbs.with_item { "Add Document" } %>
  #   <% end %>
  #
  # @example Hybrid approach (parameters + slots)
  #   <%= render DaisyUI::Breadcrumbs.new(
  #     size: :sm,
  #     items: [
  #       { text: "Home", href: "/" },
  #       { text: "Documents", href: "/documents" }
  #     ]
  #   ) do |breadcrumbs| %>
  #     <% breadcrumbs.with_item { "Add Document" } %>
  #   <% end %>
  #
  # @note If both `items` parameters and a block with `with_item` are provided,
  #   the items from parameters will be rendered first, followed by items defined in the block.

  class Breadcrumbs < BaseComponent
    # Available breadcrumb sizes from DaisyUI/Tailwind
    SIZES = {
      xs: 'text-xs',
      sm: 'text-sm',
      md: 'text-base',
      lg: 'text-lg',
      xl: 'text-xl'
    }.freeze

    # Polymorphic slot for breadcrumb items using the existing DaisyUI::Item component
    renders_many :items, 'DaisyUI::Item'

    # @param items [Array<Hash>] Optional array of item hashes. Each hash is passed as keyword arguments to
    #   `DaisyUI::Item.new`. If provided, item elements are added to the breadcrumbs.
    # @param size [Symbol] Breadcrumb text size (:xs, :sm, :md, :lg, :xl)
    # @param system_arguments [Hash] Additional HTML attributes for the breadcrumbs container.
    def initialize(
      items: nil,
      size: :sm,
      **system_arguments
    )
      super(**system_arguments)

      items&.each do |item_options|
        # Transform 'text' and 'icon' parameters to block content for DaisyUI::Item
        text = item_options.delete(:text)
        icon = item_options.delete(:icon)

        # Add icon_span parameter if there's an icon and no href (nil or empty)
        item_options[:icon_span] = true if icon && item_options[:href].nil?

        with_item(**item_options) do
          join_text_and_icon(text, icon)
        end
      end

      @size = build_argument(size, SIZES, 'size')
    end

    def call
      tag.div(class: computed_classes, **system_arguments.except(:class)) do
        tag.ul do
          safe_join([
                      content,
                      items
                    ])
        end
      end
    end

    private

    def computed_classes
      modifiers = ['breadcrumbs']
      modifiers << @size if @size.present?

      class_names(modifiers, system_arguments[:class])
    end

    def join_text_and_icon(text, icon)
      if icon
        safe_join([icon, text].compact)
      else
        text
      end
    end
  end
end
