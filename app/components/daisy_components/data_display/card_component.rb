# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent < DaisyComponents::BaseComponent
      renders_one :figure, lambda { |**system_arguments|
        FigureComponent.new(**system_arguments)
      }
      renders_one :body, lambda { |**system_arguments|
        BodyComponent.new(style: @style, **system_arguments)
      }

      STYLES = %w[normal compact side].freeze

      def initialize(bordered: false, image_full: false, style: :normal, glass: false, **system_arguments)
        @bordered = bordered
        @image_full = image_full
        @style = STYLES.include?(style.to_s) ? style : :normal
        @glass = glass

        super(**system_arguments)
      end

      private

      def default_classes
        class_names(
          'card',
          'bg-base-100',
          'w-96',
          'shadow-xl',
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
