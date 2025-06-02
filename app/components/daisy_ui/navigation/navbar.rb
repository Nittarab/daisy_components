# frozen_string_literal: true

module DaisyUI
  # Navbar component
  #
  # @param color [Symbol] The color of the navbar
  # @param **system_arguments [Hash] The system arguments
  #
  # @return [String] The rendered navbar
  #
  #
  #
  class Navbar < BaseComponent
    renders_one :navbar_start
    renders_one :navbar_center
    renders_one :navbar_end

    # @param shadow [Boolean] Whether to add a shadow to the navbar
    # @param **system_arguments [Hash] The system arguments
    def initialize(shadow: false, **system_arguments)
      @shadow = shadow
      super(**system_arguments)
    end

    def call
      tag.div(**full_arguments) { computed_content }
    end

    private

    def full_arguments
      base = {
        class: computed_classes
      }
      base.merge(system_arguments.except(:class))
    end

    def computed_content
      content.presence || safe_join([navbar_start, navbar_center, navbar_end].compact)
    end

    def computed_classes
      modifiers = %w[navbar]
      modifiers << 'shadow-sm' if @shadow

      class_names(modifiers, system_arguments[:class])
    end
  end
end
