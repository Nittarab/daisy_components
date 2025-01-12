# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent
      class FigureComponent < DaisyComponents::BaseComponent
        private

        def default_classes
          class_names(
            'card-figure',
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
