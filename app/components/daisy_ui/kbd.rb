# frozen_string_literal: true

module DaisyUI
  class Kbd < DaisyUI::BaseComponent
    # @param text [String] Text content of the kbd component
    # @param size [Symbol] Size of the kbd component (:xs, :sm, :md, :lg)
    def initialize(text: nil, size: nil, **system_arguments)
      @text = text
      @size = size
      super(**system_arguments)
    end

    def call
      tag.kbd(@text, **full_arguments)
    end

    private

    def full_arguments
      {
        class: computed_classes,
        **system_arguments.except(:class)
      }
    end

    def computed_classes
      class_names(
        'kbd',
        size_class,
        system_arguments[:class]
      )
    end

    SIZE_CLASSES = {
      xs: 'kbd-xs',
      sm: 'kbd-sm',
      md: 'kbd-md',
      lg: 'kbd-lg',
      xl: 'kbd-xl'
    }.freeze
    private_constant :SIZE_CLASSES

    def size_class
      SIZE_CLASSES[@size]
    end
  end
end
