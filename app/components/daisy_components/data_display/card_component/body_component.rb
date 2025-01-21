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

        def initialize(style: nil, description: nil, title: nil, button_text: nil, button_class: nil,
                       **system_arguments)
          @style = style
          @description = description
          @title = title
          @button_text = button_text
          @button_class = button_class
          super(**system_arguments)
        end

        def before_render
          with_title(@title) if @title && !title?
          with_description { @description } if @description && !description?
          with_actions { tag.button(@button_text, class: @button_class) } if @button_text && !actions?
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
