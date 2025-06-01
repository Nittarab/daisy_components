# frozen_string_literal: true

module DaisyUI
  class Stack < DaisyUI::BaseComponent
    def call
      tag.div(class: computed_classes, **system_arguments.except(:class)) do
        content
      end
    end

    def computed_classes
      class_names(
        'stack',
        system_arguments[:class]
      )
    end
  end
end
