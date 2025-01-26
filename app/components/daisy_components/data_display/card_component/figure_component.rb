# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent
      class FigureComponent < DaisyComponents::BaseComponent
        renders_one :image

        def initialize(image_url: nil, **system_arguments)
          @image_url = image_url
          super(**system_arguments)
        end

        def before_render
          with_image { tag.img(src: @image_url) } if @image_url && !image?
        end

        private

        def default_classes
          class_names(
            'figure',
            system_arguments[:class]
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
end
