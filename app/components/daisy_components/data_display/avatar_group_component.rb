# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # Avatar group component that displays a collection of avatars with customizable styling
    #
    # @example Basic usage
    #   <%= render(AvatarGroupComponent.new) do |group| %>
    #     <% group.with_avatar(img_src: "path/to/image.jpg", img_alt: "User 1") %>
    #     <% group.with_avatar(img_src: "path/to/image.jpg", img_alt: "User 2") %>
    #   <% end %>
    #
    # @example With max display and counter
    #   <%= render(AvatarGroupComponent.new(max_display: 2)) do |group| %>
    #     <% group.with_avatar(img_src: "path/to/image.jpg", img_alt: "User 1") %>
    #     <% group.with_avatar(img_src: "path/to/image.jpg", img_alt: "User 2") %>
    #     <% group.with_avatar(img_src: "path/to/image.jpg", img_alt: "User 3") %>
    #   <% end %>
    class AvatarGroupComponent < DaisyComponents::BaseComponent
      SIZES = AvatarComponent::SIZES
      SHAPES = AvatarComponent::SHAPES
      DEFAULT_SPACING = 1.5

      renders_many :avatars, lambda { |**system_arguments|
        AvatarComponent.new(
          size: @size,
          shape: @shape&.to_sym,
          inner_class: system_arguments.delete(:inner_class),
          **system_arguments
        )
      }

      # Initializes a new Avatar Group component
      #
      # @param size [Symbol, nil] Size of the avatars. Must be one of: w8, w12, w16, w20, w24, w32
      # @param shape [Symbol, nil] Shape of the avatars. Must be one of: circle, squircle, hexagon, triangle
      # @param spacing [Float] Space between avatars in rem units (default: 1.5)
      # @param max_display [Integer, nil] Maximum number of avatars to display before showing a counter
      # @param system_arguments [Hash] Additional HTML attributes to be applied to the wrapper element
      def initialize(size: nil, shape: nil, spacing: DEFAULT_SPACING, max_display: nil, **system_arguments)
        @size = size
        @shape = shape
        @spacing = spacing.to_f
        @max_display = max_display&.to_i

        super(**system_arguments)
      end

      # @return [String] Rendered HTML for the avatar group
      def call
        tag.div(**html_attributes) do
          content = []
          content.concat(displayed_avatars)
          content << render_counter if remaining_count
          safe_join(content)
        end
      end

      private

      def build_argument(key, valid_values, attr_name)
        return unless key

        class_name = valid_values[key.to_sym]
        return class_name if class_name

        raise ArgumentError, "Invalid #{attr_name}: #{key}. Must be one of: #{valid_values.keys.join(', ')}"
      end

      def default_classes
        class_names(
          'avatar-group',
          spacing_class,
          system_arguments[:class]
        )
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end

      def displayed_avatars
        return avatars if avatars.empty? || !@max_display

        avatars.first(@max_display)
      end

      def remaining_count
        return unless @max_display && avatars.size > @max_display

        avatars.size - @max_display
      end

      def render_counter
        AvatarComponent.new(
          size: @size,
          shape: @shape,
          placeholder_text: "+#{remaining_count}",
          inner_class: 'bg-neutral text-neutral-content'
        ).call
      end

      def spacing_class
        # Convert rem to tailwind spacing units (1rem = 4 units)
        # Clamp between 0 and 16 (4rem) to ensure valid Tailwind classes
        rem = [(@spacing * 4).round, 0].max.clamp(0, 16)
        "-space-x-#{rem}"
      end
    end
  end
end
