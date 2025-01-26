# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class BadgeComponent < DaisyComponents::BaseComponent
      VARIANTS = %w[neutral primary secondary accent ghost info success warning error].freeze
      SIZES = %w[lg md sm xs].freeze

      def initialize(text = nil, variant: nil, size: nil, outline: false, icon: nil, **system_arguments)
        @text = text
        @variant = variant if VARIANTS.include?(variant.to_s)
        @size = size if SIZES.include?(size.to_s)
        @outline = outline
        @icon = icon

        super(**system_arguments)
      end

      def call
        tag.div(**html_attributes) do
          safe_join([render_icon, content || @text].compact)
        end
      end

      delegate :to_s, to: :call

      private

      def render_icon
        return unless @icon

        helpers.sanitize(@icon, tags: %w[svg path g circle],
                                attributes: %w[class viewBox fill stroke d])
      end

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
