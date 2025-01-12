# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent
      class BodyComponent < DaisyComponents::BaseComponent
        # Title is a component slot that renders TitleComponent
        renders_one :title, 'DaisyComponents::DataDisplay::CardComponent::TitleComponent'

        # Actions is a component slot that renders ActionsComponent
        renders_one :actions, 'DaisyComponents::DataDisplay::CardComponent::ActionsComponent'

        # Description is a content slot that can contain any content
        renders_one :description

        def initialize(style: nil, **system_arguments)
          @style = style
          super(**system_arguments)
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
