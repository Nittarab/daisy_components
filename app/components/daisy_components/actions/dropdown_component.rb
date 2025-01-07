# frozen_string_literal: true

module DaisyComponents
  module Actions
    class DropdownComponent < BaseComponent
      POSITIONS = %w[end top bottom left right].freeze

      def initialize(position: nil, hover: false, open: false, align_end: false, **system_arguments)
        @position = position if POSITIONS.include?(position.to_s)
        @hover = hover
        @open = open
        @align_end = align_end
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
            'dropdown-open' => @open,
            'dropdown-end' => @align_end
          ),
          **system_arguments
        }
      end
    end
  end
end
