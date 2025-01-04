# frozen_string_literal: true

module DaisyComponents
  module Actions
    class ButtonComponent < BaseComponent
      VARIANTS = %w[neutral primary secondary accent info success warning error ghost link].freeze
      SIZES = %w[lg md sm xs].freeze

      def initialize(variant: nil, size: nil, disabled: false, **system_arguments)
        @variant = variant if VARIANTS.include?(variant)
        @size = size if SIZES.include?(size)
        @disabled = disabled

        super(**system_arguments)
      end

      def call
        tag.button(**button_arguments) { content }
      end

      private

      def button_arguments
        {
          class: class_names(
            'btn',
            "btn-#{@variant}" => @variant,
            "btn-#{@size}" => @size,
            disabled: @disabled
          ),
          disabled: @disabled,
          **system_arguments
        }
      end
    end
  end
end
