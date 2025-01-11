# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardTitleComponent < DaisyComponents::BaseComponent
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

      def default_classes
        class_names('card-title', system_arguments[:class])
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
