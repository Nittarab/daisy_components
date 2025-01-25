# frozen_string_literal: true

# @label Avatar Group
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class AvatarGroupComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive avatar group component with customizable appearance
      #
      # @param classes text "Additional CSS classes to apply to the avatar group container"
      def playground(classes: '')
        render(AvatarGroupComponent.new(class: classes)) do |component|
          # First avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=1', alt: 'Avatar 1')
            end
          end
          # Second avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/22C55E/FFFFFF?text=2', alt: 'Avatar 2')
            end
          end
          # Third avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=3', alt: 'Avatar 3')
            end
          end
          # Counter avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_placeholder { '+2' }
          end
        end
      end

      # @!endgroup

      # @!group Examples

      # Basic Avatar Group
      # ---------------
      # Multiple avatars grouped together
      #
      # @label Basic
      def basic
        render(AvatarGroupComponent.new(class: 'h-12')) do |component|
          # First avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/3B82F6/FFFFFF?text=1', alt: 'Avatar 1')
            end
          end
          # Second avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/22C55E/FFFFFF?text=2', alt: 'Avatar 2')
            end
          end
          # Third avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=3', alt: 'Avatar 3')
            end
          end
          # Counter avatar
          component.with_avatar(size: 12) do |avatar|
            avatar.with_placeholder { '+2' }
          end
        end
      end

      # @!endgroup
    end
  end
end
