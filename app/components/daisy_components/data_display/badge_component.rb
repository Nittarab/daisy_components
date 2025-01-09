# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class BadgeComponent < DaisyComponents::BaseComponent
      VARIANTS = %w[neutral primary secondary accent ghost info success warning error].freeze
      SIZES = %w[lg md sm xs].freeze

      def initialize(text = nil, variant: nil, size: nil, outline: false, **system_arguments)
        @text = text
        @variant = variant if VARIANTS.include?(variant.to_s)
        @size = size if SIZES.include?(size.to_s)
        @outline = outline

        super(**system_arguments)
      end

      def call
        tag.div(**html_attributes) do
          content || @text
        end
      end

      private

      def default_classes
        class_names('badge', system_arguments[:class], variant_classes)
      end

      def variant_classes
        {
          "badge-#{@variant}": @variant,
          "badge-#{@size}": @size,
          'badge-outline': @outline
        }
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
