# frozen_string_literal: true

module DaisyUI
  class Menu
    # Menu title sub-component for section headers
    #
    # @example Basic title
    #   <%= render(DaisyUI::Menu::Title.new(text: "Navigation")) %>
    #
    class Title < BaseComponent
      # @param text [String] Title text content
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(
        text: nil,
        **system_arguments
      )
        @text = text

        super(**system_arguments)
      end

      def call
        tag.li(**html_attributes) do
          content_with_text
        end
      end

      private

      def html_attributes
        attrs = { class: computed_classes }
        attrs.merge(system_arguments.except(:class))
      end

      def computed_classes
        modifiers = ['menu-title']
        class_names(modifiers, system_arguments[:class])
      end

      def content_with_text
        if content.present?
          content
        elsif @text.present?
          @text
        end
      end
    end
  end
end
