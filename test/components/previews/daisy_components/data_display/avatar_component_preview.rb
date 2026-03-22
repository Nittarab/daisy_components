# frozen_string_literal: true

# @label Avatar
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class AvatarComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive avatar component with customizable appearance and status
      #
      # @param size select { choices: [xs, sm, md, lg] } "Size of the avatar"
      # @param shape select { choices: [circle, squircle, hexagon, triangle, half_1, half_2] } "Shape of the avatar"
      # @param presence select { choices: [online, offline, away, busy] } "Presence indicator"
      # @param ring toggle "Show ring around avatar"
      # @param img_src text "URL of the avatar image" default: "https://placehold.co/400x400/3B82F6/FFFFFF?text=A"
      # @param img_alt text "Alt text for the avatar image" default: "Avatar"
      # @param classes text "Additional CSS classes"
      def playground(
        size: :md,
        shape: :circle,
        presence: nil,
        ring: false,
        img_src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A',
        img_alt: 'Avatar',
        classes: ''
      )
        render(AvatarComponent.new(
                 size: size,
                 shape: shape,
                 presence: presence,
                 ring: ring,
                 img_src: img_src,
                 img_alt: img_alt,
                 class: classes
               ))
      end
      # @!endgroup

      # @!group Basic Examples
      # Basic Avatar
      # ---------------
      # Simple avatar with an image
      #
      # @label Basic
      def basic
        render(DaisyComponents::DataDisplay::AvatarComponent.new(
                 img_src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A',
                 img_alt: 'Avatar'
               ))
      end

      # Presence States
      # ---------------
      # Avatar with different presence indicators
      #
      # @label Presence
      def presence
        render_with_template
      end

      # Ring Style
      # ---------------
      # Avatar with ring decoration
      #
      # @label Ring
      def ring
        render(DaisyComponents::DataDisplay::AvatarComponent.new(
                 ring: true,
                 img_src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=R',
                 img_alt: 'Ring Avatar'
               ))
      end

      # Text Placeholder
      # ---------------
      # Avatar with text placeholder instead of image
      #
      # @label Placeholder
      def placeholder
        render(DaisyComponents::DataDisplay::AvatarComponent.new(placeholder: 'JD'))
      end
      # @!endgroup

      # @!group Gallery Examples
      # Avatar Sizes
      # ---------------
      # Different size variations
      #
      # @label Sizes
      def sizes
        render_with_template
      end

      # Avatar Shapes
      # ---------------
      # Different shape variations including half masks
      #
      # @label Shapes
      def shapes
        render_with_template
      end

      # Avatar Group
      # ---------------
      # Multiple avatars grouped together
      #
      # @label Group
      def group
        render_with_template
      end
      # @!endgroup
    end
  end
end
