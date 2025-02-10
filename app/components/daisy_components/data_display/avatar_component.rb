# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # Avatar component implementing DaisyUI's avatar styles
    #
    # @example Basic usage with image
    #   <%= render(AvatarComponent.new(img_src: "user.jpg", img_alt: "User")) %>
    #
    # @example With placeholder text
    #   <%= render(AvatarComponent.new(placeholder_text: "JD")) %>
    #
    # @example Custom size
    #   <%= render(AvatarComponent.new(size: :w32, img_src: "user.jpg")) %>
    #
    # @example Different shapes
    #   <%= render(AvatarComponent.new(
    #     img_src: "user.jpg",
    #     shape: :squircle
    #   )) %>
    #
    # @example With online status
    #   <%= render(AvatarComponent.new(
    #     img_src: "user.jpg",
    #     status: :online
    #   )) %>
    #
    # @example With custom placeholder content
    #   <%= render(AvatarComponent.new) do |c|
    #     c.with_placeholder do
    #       helpers.user_icon
    #     end
    #   end %>
    class AvatarComponent < DaisyComponents::BaseComponent
      # Available avatar sizes in pixels
      SIZES = {
        w8: 'w-8',
        w12: 'w-12',
        w16: 'w-16',
        w20: 'w-20',
        w24: 'w-24',
        w32: 'w-32'
      }.freeze

      # Text sizes mapped to avatar sizes
      TEXT_SIZES = {
        w8: 'text-xs',
        w12: nil, # default text size
        w16: 'text-xl',
        w20: 'text-2xl',
        w24: 'text-3xl',
        w32: 'text-4xl'
      }.freeze

      # Available avatar shapes
      SHAPES = {
        circle: 'rounded-full',
        squircle: 'mask mask-squircle',
        hexagon: 'mask mask-hexagon',
        triangle: 'mask mask-triangle'
      }.freeze

      # Available status indicators
      STATUSES = {
        online: 'avatar-online',
        offline: 'avatar-offline'
      }.freeze

      # @param size [Symbol] Size of the avatar (w8/w12/w16/w20/w24/w32)
      # @param shape [Symbol] Shape of the avatar (circle/squircle/hexagon/triangle)
      # @param status [Symbol] Status indicator (online/offline)
      # @param img_src [String] URL of the avatar image
      # @param img_alt [String] Alt text for the avatar image
      # @param placeholder_text [String] Text to show when no image is provided
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(size: nil, shape: nil, status: nil, img_src: nil, img_alt: nil, placeholder_text: nil,
                     inner_class: nil,
                     **system_arguments)
        @size = build_argument(size, SIZES, 'size')
        @shape = build_argument(shape, SHAPES, 'shape')
        @status = build_argument(status, STATUSES, 'status')
        @img_src = img_src
        @img_alt = img_alt
        @placeholder_text = placeholder_text
        @size_key = size # Keep original size key for text size lookup
        @inner_class = inner_class
        super(**system_arguments)
      end

      def call
        tag.div(**html_attributes) do
          tag.div(class: inner_classes) do
            if @img_src.present?
              tag.img(src: @img_src, alt: @img_alt)
            elsif @placeholder_text.present?
              tag.span(@placeholder_text, class: text_size_class)
            end
          end
        end
      end

      private

      def text_size_class
        return unless @size_key

        TEXT_SIZES[@size_key]
      end

      def default_classes
        modifiers = ['avatar']
        modifiers << @status
        modifiers << 'avatar-placeholder' if @placeholder_text.present?
        class_names(modifiers, system_arguments[:class])
      end

      def inner_classes
        class_names(
          @size,
          @shape || @inner_class || 'rounded',
          { 'bg-neutral text-neutral-content': @placeholder_text.present? }
        )
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
