# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent
      class BodyComponent < DaisyComponents::BaseComponent
        renders_one :title, lambda { |text = nil, **system_arguments|
          TitleComponent.new(text, **system_arguments)
        }
        renders_one :actions, lambda { |**system_arguments|
          ActionsComponent.new(justify: :end, **system_arguments)
        }

        def initialize(style: nil, description: nil, **system_arguments)
          @style = style
          @description = description
          super(**system_arguments)
        end

        def description
          tag.p(@description) if @description
        end

        private

        def default_classes
          class_names(
            'card-body',
            'p-6',
            { 'flex flex-col justify-between': @style == :side },
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
