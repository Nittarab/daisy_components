# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AvatarComponent < DaisyComponents::BaseComponent
      renders_one :image
      renders_one :placeholder

      VALID_SIZES = [8, 12, 16, 20, 24, 32].freeze
      VALID_SHAPES = %i[circle squircle hexagon triangle].freeze
      VALID_STATUSES = %i[online offline].freeze

      attr_reader :size, :shape, :status, :img_src, :img_alt, :placeholder_text

      def initialize(size: nil, shape: nil, status: nil, img_src: nil, img_alt: nil, placeholder_text: nil,
                     **system_arguments)
        @size = VALID_SIZES.include?(size) ? size : nil
        @shape = VALID_SHAPES.include?(shape) ? shape : nil
        @status = VALID_STATUSES.include?(status) ? status : nil
        @img_src = img_src
        @img_alt = img_alt
        @placeholder_text = placeholder_text

        super(**system_arguments)
      end

      private

      def default_classes
        class_names(
          'avatar',
          { placeholder: placeholder_text.present? || placeholder.present? },
          system_arguments[:class],
          status
        )
      end

      def inner_classes
        class_names(
          { "w-#{size}": size },
          shape_classes,
          'flex items-center justify-center',
          { 'bg-neutral text-neutral-content': placeholder_text.present? || placeholder.present? }
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

      def image_classes
        'w-full h-full object-cover'
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
