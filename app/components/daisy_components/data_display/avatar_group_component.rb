# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AvatarGroupComponent < DaisyComponents::BaseComponent
      VALID_SIZES = AvatarComponent::VALID_SIZES
      VALID_SHAPES = AvatarComponent::VALID_SHAPES

      renders_many :avatars, lambda { |**system_arguments|
        AvatarComponent.new(
          size: @size,
          shape: @shape,
          **system_arguments
        )
      }

      attr_reader :size, :shape, :spacing, :max_display

      def initialize(size: nil, shape: nil, spacing: -6, max_display: nil, **system_arguments)
        @size = VALID_SIZES.include?(size) ? size : nil
        @shape = VALID_SHAPES.include?(shape) ? shape : nil
        @spacing = spacing
        @max_display = max_display

        super(**system_arguments)
      end

      private

      def default_classes
        class_names(
          'avatar-group',
          system_arguments[:class]
        )
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs[:style] = "#{attrs[:style]} --avatar-spacing: #{spacing}px;".strip
        attrs
      end

      def displayed_avatars
        return avatars if avatars.empty? || !max_display

        avatars.first(max_display)
      end

      def remaining_count
        return unless max_display && avatars.size > max_display

        avatars.size - max_display
      end

      def counter_classes
        class_names(
          'avatar placeholder',
          { "w-#{size}": size },
          shape_classes,
          'flex items-center justify-center',
          'bg-neutral text-neutral-content'
        )
      end

      def shape_classes
        return 'rounded-full' unless shape

        {
          circle: 'rounded-full',
          squircle: 'mask mask-squircle',
          hexagon: 'mask mask-hexagon',
          triangle: 'mask mask-triangle'
        }[shape]
      end
    end
  end
end
