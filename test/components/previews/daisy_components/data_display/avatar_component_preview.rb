# frozen_string_literal: true

# @label Avatar
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class AvatarComponentPreview < Lookbook::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive avatar component with customizable appearance and status
      #
      # @param size select { choices: [8, 12, 16, 20, 24, 32] } "Size of the avatar in Tailwind units"
      # @param shape select { choices: [circle, squircle, hexagon, triangle] } "Shape of the avatar container"
      # @param online toggle "Show an online status indicator"
      # @param offline toggle "Show an offline status indicator"
      # @param classes text "Additional CSS classes to apply to the avatar container"
      def playground(size: 24, shape: :circle, online: false, offline: false, classes: '')
        render(AvatarComponent.new(
                 size:, shape:, online:, offline:, class: classes
               )) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A', alt: 'Avatar')
          end
        end
      end

      # @!endgroup

      # @!group Examples

      # Basic Avatar
      # ---------------
      # Simple avatar with an image
      #
      # @label Basic
      def basic
        render(AvatarComponent.new(size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A', alt: 'Avatar')
          end
        end
      end

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

      # Online Status
      # ---------------
      # Avatar with online indicator
      #
      # @label Online
      def online
        render(AvatarComponent.new(online: true, size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/22C55E/FFFFFF?text=ON', alt: 'Online Avatar')
          end
        end
      end

      # Offline Status
      # ---------------
      # Avatar with offline indicator
      #
      # @label Offline
      def offline
        render(AvatarComponent.new(offline: true, size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=OFF', alt: 'Offline Avatar')
          end
        end
      end

      # Text Placeholder
      # ---------------
      # Avatar with text placeholder instead of image
      #
      # @label Placeholder
      def placeholder
        render(AvatarComponent.new(size: 12)) do |component|
          component.with_placeholder { 'JD' }
        end
      end

      # Avatar Group
      # ---------------
      # Multiple avatars grouped together
      #
      # @label Group
      def group
        render(AvatarComponent.new(size: 12, class: 'avatar-group h-12')) do |component|
          # First avatar
          component.with_group do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=1', alt: 'Avatar 1')
            end
          end
          # Second avatar
          component.with_group do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/22C55E/FFFFFF?text=2', alt: 'Avatar 2')
            end
          end
          # Third avatar
          component.with_group do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=3', alt: 'Avatar 3')
            end
          end
          # Counter avatar
          component.with_group do |avatar|
            avatar.with_placeholder { '+2' }
          end
        end
      end

      # @!endgroup
    end
  end
end
