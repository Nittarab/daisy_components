# frozen_string_literal: true

module DaisyUI
  class Card
    # Title component for the card, handling the title display
    #
    # @example Basic usage
    #   <%= render(CardComponent.new) do |component| %>
    #     <% component.with_body do |body| %>
    #       <% body.with_title { "Card Title" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With custom tag
    #   <%= render(CardComponent.new) do |component| %>
    #     <% component.with_body do |body| %>
    #       <% body.with_title(tag_name: :h1) { "Large Title" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With text parameter
    #   <%= render(CardComponent.new) do |component| %>
    #     <% component.with_body do |body| %>
    #       <% body.with_title("Simple Title") %>
    #     <% end %>
    #   <% end %>
    class Title < BaseComponent
      # @param text [String] The title text (optional if block given)
      # @param tag_name [Symbol] HTML tag to use for the title
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(text = nil, tag_name: :h2, **system_arguments)
        @text = text
        @tag_name = tag_name
        super(**system_arguments)
      end

      def call
        content_tag(@tag_name, **html_attributes) do
          content || @text
        end
      end

      private

      def computed_classes
        class_names('card-title', system_arguments[:class])
      end

      def html_attributes
        system_arguments.merge(
          class: computed_classes
        )
      end
    end
  end
end
