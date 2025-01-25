# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent < DaisyComponents::BaseComponent
      renders_one :figure, lambda { |**system_arguments|
        FigureComponent.new(image_url: @image_url, **system_arguments)
      }
      renders_one :body, lambda { |**system_arguments|
        BodyComponent.new(style: @style, title: @title, description: @description, button_text: @button_text,
                          button_class: @button_class, **system_arguments)
      }

      STYLES = %w[normal compact side].freeze

      def initialize(bordered: false, image_full: false, style: :normal, glass: false, title: nil, description: nil,
                     button_text: nil, button_class: nil, image_url: nil, **system_arguments)
        @bordered = bordered
        @image_full = image_full
        @style = STYLES.include?(style.to_s) ? style : :normal
        @glass = glass
        @title = title
        @description = description
        @button_text = button_text
        @button_class = button_class
        @image_url = image_url
        super(**system_arguments)
      end

      def before_render
        with_figure if @image_url && !figure?
        with_body unless body?
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
