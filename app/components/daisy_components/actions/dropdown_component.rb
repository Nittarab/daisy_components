# frozen_string_literal: true

module DaisyComponents
  module Actions
    class DropdownComponent < BaseComponent
      POSITIONS = %w[end top bottom left right].freeze

      def initialize(position: nil, hover: false, open: false, **system_arguments)
        @position = position if POSITIONS.include?(position.to_s)
        @hover = hover
        @open = open
        super(**system_arguments)
      end

      def call
        tag.div(**dropdown_arguments) { content }
      end

      private

      def dropdown_arguments
        {
          class: class_names(
            'dropdown',
            "dropdown-#{@position}" => @position,
            'dropdown-hover' => @hover,
            'dropdown-open' => @open
          ),
          **system_arguments
        }
      end
    end
  end
end
