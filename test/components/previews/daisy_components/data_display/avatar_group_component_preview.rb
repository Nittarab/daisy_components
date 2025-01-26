# frozen_string_literal: true

# @label Avatar Group
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class AvatarGroupComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Default
      # ---------------
      # Interactive avatar group component with customizable styling
      #
      # @param size select { choices: [8, 12, 16, 20, 24, 32] } "Size of avatars"
      # @param shape select { choices: [circle, squircle, hexagon, triangle] } "Shape of avatars"
      # @param spacing number { default: "1.5" } "Spacing between avatars in rem"
      # @param max_display number "Maximum number of avatars to display"
      def playground(size: nil, shape: nil, spacing: '1.5', max_display: nil)
        render(DaisyComponents::DataDisplay::AvatarGroupComponent.new(
                 size: size,
                 shape: shape,
                 spacing: spacing.to_f,
                 max_display: max_display
               )) do |group|
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 1')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 2')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 3')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 4')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 5')
        end
      end

      # @!endgroup

      # @!group Template Examples

      # Avatar Shapes
      # ---------------
      # Different shape variations for avatar groups
      #
      # @label Shapes
      def shapes
        render_with_template
      end

      # @!endgroup

      # @!group Examples

      # Basic Usage
      # ---------------
      # Simple avatar group with default styling
      def default
        render(AvatarGroupComponent.new) do |group|
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 1')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 2')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 3')
        end
      end

      # With Size
      # ---------------
      # Avatar group with custom size
      def with_size
        render(AvatarGroupComponent.new(size: 32)) do |group|
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 1')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 2')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 3')
        end
      end

      # With Shape
      # ---------------
      # Avatar group with custom shape
      def with_shape
        render(AvatarGroupComponent.new(shape: :squircle)) do |group|
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 1')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 2')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 3')
        end
      end

      # With Spacing
      # ---------------
      # Avatar group with custom spacing
      def with_spacing
        render(AvatarGroupComponent.new(spacing: 3)) do |group|
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 1')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 2')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 3')
        end
      end

      # With Counter
      # ---------------
      # Avatar group with max display and counter
      def with_counter
        render(AvatarGroupComponent.new(max_display: 2)) do |group|
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 1')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 2')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 3')
          group.with_avatar(img_src: 'https://placehold.co/100', img_alt: 'User 4')
        end
      end

      # With Placeholders
      # ---------------
      # Avatar group with text and custom placeholders
      def with_placeholders
        render(AvatarGroupComponent.new) do |group|
          group.with_avatar(placeholder_text: 'JD')
          group.with_avatar(placeholder_text: 'AB')
          group.with_avatar do |avatar|
            avatar.with_placeholder { 'CD' }
          end
        end
      end

      # @!endgroup
    end
  end
end
