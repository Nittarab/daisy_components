# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AvatarComponent < DaisyComponents::BaseComponent
      renders_one :image

      renders_many :group, DaisyComponents::DataDisplay::AvatarItemComponent

      SIZES = {
        xs: 'w-8',
        sm: 'w-12',
        md: 'w-16',
        lg: 'w-20'
      }.freeze

      attr_reader :size, :shape, :presence, :ring, :img_src, :img_alt, :placeholder

      def initialize(size: :md, shape: nil, presence: nil, ring: false, img_src: nil, img_alt: nil,
                     placeholder: nil, **system_arguments)
        @size = size
        @shape = shape
        @presence = presence
        @ring = ring
        @img_src = img_src
        @img_alt = img_alt
        @placeholder = placeholder

        super(**system_arguments)
      end

      private

      def default_classes
        group.any? ? group_classes : single_classes
      end

      def group_classes
        class_names(
          'avatar-group -space-x-6',
          system_arguments[:class]
        )
      end

      def single_classes
        class_names(
          'avatar',
          system_arguments[:class],
          presence_classes,
          ring_classes,
          placeholder_classes
        )
      end

      def inner_classes
        class_names(
          size_classes,
          shape_classes
        )
      end

      def presence_classes
        return unless presence

        {
          online: presence == :online,
          offline: presence == :offline,
          away: presence == :away,
          busy: presence == :busy
        }
      end

      def size_classes
        SIZES[size]
      end

      def shape_classes
        case shape
        when :circle
          'rounded-full'
        when :squircle
          'mask mask-squircle'
        when :hexagon
          'mask mask-hexagon'
        when :triangle
          'mask mask-triangle'
        when :half_1
          'mask mask-half-1'
        when :half_2
          'mask mask-half-2'
        else
          'rounded'
        end
      end

      def ring_classes
        { 'ring ring-offset-base-100 ring-offset-2': ring }
      end

      def placeholder_classes
        { placeholder: placeholder.present? }
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
