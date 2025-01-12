# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent
      class ActionsComponent < DaisyComponents::BaseComponent
        JUSTIFY_OPTIONS = %w[start end center between around evenly].freeze

        def initialize(justify: nil, **system_arguments)
          @justify = justify if JUSTIFY_OPTIONS.include?(justify.to_s)
          super(**system_arguments)
        end

        private

        def default_classes
          class_names(
            'card-actions',
            'mt-4',
            system_arguments[:class],
            "justify-#{@justify}": @justify
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
