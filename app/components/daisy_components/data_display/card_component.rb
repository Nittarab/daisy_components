# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent < DaisyComponents::BaseComponent
      renders_one :figure
      renders_one :title, lambda { |text = nil, **system_arguments|
        CardTitleComponent.new(text, **system_arguments)
      }
      renders_one :body, lambda { |**system_arguments|
        CardBodyComponent.new(**system_arguments)
      }
      renders_one :actions, lambda { |**system_arguments|
        CardActionsComponent.new(**system_arguments)
      }

      STYLES = %w[normal compact side].freeze

      def initialize(bordered: false, image_full: false, style: :normal, glass: false, **system_arguments)
        @bordered = bordered
        @image_full = image_full
        @style = style if STYLES.include?(style.to_s)
        @glass = glass

        super(**system_arguments)
      end

      def call
        tag.div(**html_attributes) do
          safe_join([
            figure,
            body,
            actions
          ].compact)
        end
      end

      private

      def default_classes
        class_names(
          'card',
          system_arguments[:class],
          'card-bordered': @bordered,
          'image-full': @image_full,
          "card-#{@style}": @style,
          glass: @glass
        )
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
