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
      # @param size select { choices: [8, 12, 16, 20, 24, 32] } "Size of the avatar in Tailwind units"
      # @param shape select { choices: [circle, squircle, hexagon, triangle] } "Shape of the avatar container"
      # @param status select { choices: [online, offline] } "Status indicator"
      # @param classes text "Additional CSS classes to apply to the avatar container"
      # @param placeholder_text text "Text to display as placeholder"
      def playground(size: 24, shape: :circle, status: nil, classes: '', placeholder_text: nil)
        render(AvatarComponent.new(
                 size:,
                 shape:,
                 status:,
                 class: classes,
                 placeholder_text:,
                 img_src: placeholder_text.nil? ? 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A' : nil,
                 img_alt: 'Avatar'
               ))
      end

      # @!endgroup

      # @!group Template Examples

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
      # Different shape variations
      #
      # @label Shapes
      def shapes
        render_with_template
      end

      # @!endgroup

      # @!group Basic Examples

      # Basic Avatar (Direct)
      # ---------------
      # Simple avatar using direct img_src parameter
      #
      # @label Basic Direct
      def basic_direct
        render(AvatarComponent.new(
                 size: 12,
                 img_src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A',
                 img_alt: 'Avatar'
               ))
      end

      # Basic Avatar (Block)
      # ---------------
      # Simple avatar using block syntax
      #
      # @label Basic Block
      def basic_block
        render(AvatarComponent.new(size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A', alt: 'Avatar')
          end
        end
      end

      # Online Status
      # ---------------
      # Avatar with online indicator
      #
      # @label Online
      def online
        render(AvatarComponent.new(
                 status: :online,
                 size: 12,
                 img_src: 'https://placehold.co/400x400/22C55E/FFFFFF?text=ON',
                 img_alt: 'Online Avatar',
                 shape: :circle
               ))
      end

      # Offline Status
      # ---------------
      # Avatar with offline indicator
      #
      # @label Offline
      def offline
        render(AvatarComponent.new(
                 status: :offline,
                 size: 12,
                 img_src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=OFF',
                 img_alt: 'Offline Avatar',
                 shape: :circle
               ))
      end

      # Text Placeholder
      # ---------------
      # Avatar with text placeholder instead of image
      #
      # @label Placeholder
      def placeholder
        render(AvatarComponent.new(size: 12, placeholder_text: 'JD'))
      end

      # @!endgroup
    end
  end
end
