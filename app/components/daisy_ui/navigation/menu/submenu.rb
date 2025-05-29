# frozen_string_literal: true

module DaisyUI
  class Menu
    # Menu submenu sub-component for nested menu structures
    #
    # @example Basic submenu
    #   <%= render(DaisyUI::Menu::Submenu.new) do |submenu| %>
    #     <% submenu.with_item(text: "Sub 1", href: "/sub1") %>
    #     <% submenu.with_item(text: "Sub 2", href: "/sub2") %>
    #   <% end %>
    #
    # @example With parent item
    #   <%= render(DaisyUI::Menu::Submenu.new(parent_text: "Products")) do |submenu| %>
    #     <% submenu.with_item(text: "Laptops", href: "/laptops") %>
    #     <% submenu.with_item(text: "Phones", href: "/phones") %>
    #   <% end %>
    #
    # @example Collapsible submenu
    #   <%= render(DaisyUI::Menu::Submenu.new(parent_text: "Products", collapsible: true, open: true)) do |submenu| %>
    #     <% submenu.with_item(text: "Laptops", href: "/laptops") %>
    #     <% submenu.with_item(text: "Phones", href: "/phones") %>
    #   <% end %>
    class Submenu < BaseComponent
      attr_accessor :collapsible, :open

      renders_many :items, 'DaisyUI::Menu::Item'
      renders_one :summary, 'DaisyUI::Menu::Item'

      renders_many :submenus, lambda { |**system_arguments|
        DaisyUI::Menu::Submenu.new(**system_arguments)
      }

      # @param parent_text [String] Text for the parent menu item
      # @param parent_href [String] Link for the parent menu item
      # @param parent_active [Boolean] Whether parent item is active
      # @param collapsible [Boolean] Whether submenu is collapsible using details/summary
      # @param open [Boolean] Whether collapsible submenu is open by default
      # @param items [Array<Hash>] Simple array of submenu items (optional)
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(
        parent_text: nil,
        parent_href: nil,
        parent_active: false,
        collapsible: false,
        open: false,
        items: nil,
        **system_arguments
      )
        @parent_text = parent_text
        @parent_href = parent_href
        @parent_active = parent_active
        @collapsible = collapsible
        @open = open
        @items_data = items

        super(**system_arguments)
      end

      def before_render
        return unless @items_data

        @items_data.each do |item_data|
          with_item(**item_data)
        end
      end

      def call
        if @collapsible
          render_collapsible_submenu
        else
          render_regular_submenu
        end
      end

      private

      def html_attributes
        system_arguments.except(:class).merge(class: system_arguments[:class])
      end

      def render_collapsible_submenu
        tag.li(**html_attributes) do
          details_attrs = {}
          details_attrs[:open] = '' if @open

          tag.details(**details_attrs) do
            safe_join([
                        tag.summary(summary),
                        submenu_content
                      ])
          end
        end
      end

      def render_regular_submenu
        tag.li(**html_attributes) do
          safe_join([
            parent_link,
            submenu_content
          ].compact)
        end
      end

      def parent_link
        return unless @parent_text

        attrs = {}
        attrs[:href] = @parent_href if @parent_href
        classes = parent_classes
        attrs[:class] = classes if classes.present?

        tag.a(@parent_text, **attrs)
      end

      def parent_classes
        modifiers = []
        modifiers << 'menu-active' if @parent_active
        return nil if modifiers.empty?

        class_names(modifiers)
      end

      def submenu_content
        tag.ul do
          safe_join([items, submenus, content].flatten.compact)
        end
      end
    end
  end
end
