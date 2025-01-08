# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # @label Avatar
    class AvatarComponentPreview < ViewComponent::Preview
      # @!group Basic

      # @title Default
      # @description Basic avatar example with all available options
      #
      # @param size select { choices: [6, 8, 10, 12, 16, 20] } "Size of the avatar in Tailwind units"
      # @param shape select { choices: [circle, squircle, hexagon, triangle] } "Shape of the avatar"
      # @param online toggle "When true, shows online indicator"
      # @param offline toggle "When true, shows offline indicator"
      # @param classes text "Additional CSS classes to apply"
      def playground(size: 12, shape: :circle, online: false, offline: false, classes: '')
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
      # Simple avatar with image
      def basic
        render(AvatarComponent.new(size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=A', alt: 'Avatar')
          end
        end
      end

      # Avatar Sizes
      # ---------------
      # Different size options
      def sizes
        render_with_template
      end

      # Avatar Shapes
      # ---------------
      # Different shape options
      def shapes
        render_with_template
      end

      # Online Status
      # ---------------
      # Avatar with online indicator
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
      def offline
        render(AvatarComponent.new(offline: true, size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=OFF', alt: 'Offline Avatar')
          end
        end
      end

      # Placeholder
      # ---------------
      # Avatar with placeholder content
      def placeholder
        render(AvatarComponent.new(size: 12)) do |component|
          component.with_placeholder { 'JD' }
        end
      end

      # Avatar Group
      # ---------------
      # Multiple avatars in a group
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
