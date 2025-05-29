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
    class Submenu < BaseComponent
      renders_many :items, lambda { |**system_arguments|
        DaisyUI::Menu::Item.new(**system_arguments)
      }

      renders_many :submenus, lambda { |**system_arguments|
        DaisyUI::Menu::Submenu.new(**system_arguments)
      }

      # @param parent_text [String] Text for the parent menu item
      # @param parent_href [String] Link for the parent menu item
      # @param parent_active [Boolean] Whether parent item is active
      # @param items [Array<Hash>] Simple array of submenu items (optional)
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(
        parent_text: nil,
        parent_href: nil,
        parent_active: false,
        items: nil,
        **system_arguments
      )
        @parent_text = parent_text
        @parent_href = parent_href
        @parent_active = parent_active
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
        tag.li(**html_attributes) do
          safe_join([
            parent_link,
            submenu_content
          ].compact)
        end
      end

      private

      def html_attributes
        system_arguments.except(:class).merge(class: system_arguments[:class])
      end

      def parent_link
        return unless @parent_text

        if @parent_href
          tag.a(@parent_text, href: @parent_href, class: parent_classes)
        else
          tag.a(@parent_text, class: parent_classes)
        end
      end

      def parent_classes
        modifiers = []
        modifiers << 'menu-active' if @parent_active
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
