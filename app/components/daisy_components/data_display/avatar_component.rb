# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AvatarComponent < DaisyComponents::BaseComponent
      renders_one :image
      renders_one :placeholder

      attr_reader :size, :shape, :online, :offline, :src

      def initialize(size: nil, shape: nil, online: false, offline: false, src: nil, **system_arguments)
        @size = size
        @shape = shape
        @online = online
        @offline = offline
        @src = src

        super(**system_arguments)
      end

      private

      def default_classes
        class_names(
          'avatar',
          system_arguments[:class],
          status_classes,
          size_classes,
          shape_classes
        )
      end

      def status_classes
        { online: online, offline: offline }
      end

      def size_classes
        { "w-#{size} h-#{size}": size }
      end

      def shape_classes
        {
          'rounded-full': shape == :circle,
          'mask mask-squircle': shape == :squircle,
          'mask mask-hexagon': shape == :hexagon,
          'mask mask-triangle': shape == :triangle
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
