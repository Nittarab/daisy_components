# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardBodyComponent < DaisyComponents::BaseComponent
      renders_one :title, lambda { |text = nil, **system_arguments|
        CardTitleComponent.new(text, **system_arguments)
      }

      def call
        tag.div(**html_attributes) do
          safe_join([title, content].compact)
        end
      end

      private

      def default_classes
        class_names('card-body', system_arguments[:class])
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
