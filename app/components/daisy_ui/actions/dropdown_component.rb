# frozen_string_literal: true

module DaisyUI
  # Dropdown component implementing DaisyUI's dropdown styles
  #
  # @example Basic usage with text trigger
  #   <%= render(DropdownComponent.new) do |d| %>
  #     <% d.with_trigger(text: "Click me") %>
  #     <% d.with_item(href: "#") { "Item 1" } %>
  #     <% d.with_item(href: "#") { "Item 2" } %>
  #   <% end %>
  #
  # @example With custom trigger content
  #   <%= render(DropdownComponent.new) do |d| %>
  #     <% d.with_trigger do %>
  #       <%= helpers.cog_icon("h-5 w-5") %> Settings
  #     <% end %>
  #     <% d.with_item(href: "#") { "Item 1" } %>
  #     <% d.with_item(href: "#") { "Item 2" } %>
  #     <% d.with_divider %>
  #     <% d.with_item(href: "#", class: "text-error") { "Delete" } %>
  #   <% end %>
  class DropdownComponent < BaseComponent
    renders_one :trigger, lambda { |**kwargs, &block|
      return block if block

      defaults = { tag_type: :div, tabindex: '0', role: :button, class: 'm-1' }
      args = defaults.merge(kwargs)
      render(ButtonComponent.new(**args))
    }

    renders_many :items, types: {
      item: { renders: DaisyUI::ItemComponent, as: :item },
      divider: { renders: DaisyUI::DividerComponent, as: :divider },
      title: { renders: DaisyUI::TitleComponent, as: :title }
    }

    renders_one :custom_content

    # Available dropdown positions from DaisyUI
    POSITIONS = {
      top: 'dropdown-top',
      top_end: 'dropdown-top-end',
      top_center: 'dropdown-top-center',
      bottom: 'dropdown-bottom',
      bottom_end: 'dropdown-bottom-end',
      bottom_center: 'dropdown-bottom-center',
      left: 'dropdown-left',
      left_end: 'dropdown-left-end',
      left_center: 'dropdown-left-center',
      right: 'dropdown-right',
      right_end: 'dropdown-right-end',
      right_center: 'dropdown-right-center'
    }.freeze

    ALIGNMENTS = {
      start: 'dropdown-start',
      end: 'dropdown-end',
      center: 'dropdown-center'
    }.freeze

    # @param position [Symbol] Position of the dropdown content relative to the trigger
    # @param hover [Boolean, String] When true or 'content', opens the dropdown on hover instead of click
    # @param open [Boolean] When true, forces the dropdown to stay open
    # @param align [Symbol] When :start, :end, or :center, aligns the dropdown content
    # @param menu_class [String] Additional classes for the menu
    # @param menu_tabindex [Integer, nil] Tabindex for the menu (defaults to 0)
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(position: nil, hover: false, open: false, align: nil,
                   menu_class: nil, menu_tabindex: 0, **system_arguments)
      @position = build_argument(position, POSITIONS, 'position')
      @hover = hover
      @open = open
      @align = build_argument(align, ALIGNMENTS, 'align')
      @menu_class = menu_class
      @menu_tabindex = menu_tabindex
      super(**system_arguments)
    end

    def call
      tag.div(**dropdown_arguments) do
        safe_join([
          trigger,
          render_menu
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
      modifiers = ['dropdown']
      modifiers << @position if @position
      modifiers << 'dropdown-hover' if @hover == true
      modifiers << 'dropdown-hover-content' if @hover == 'content'
      modifiers << 'dropdown-open' if @open
      modifiers << @align if @align

      class_names(modifiers, system_arguments[:class])
    end

    def render_menu
      return custom_content if custom_content
      return unless items.any?

      tag.ul(tabindex: @menu_tabindex, class: computed_menu_classes) do
        safe_join(items)
      end
    end

    def computed_menu_classes
      class_names(
        'dropdown-content menu',
        @menu_class || 'bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm'
      )
    end
  end
end
