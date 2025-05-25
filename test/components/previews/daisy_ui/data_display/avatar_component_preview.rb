# frozen_string_literal: true

# @label Avatar
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class AvatarComponentPreview < ViewComponent::Preview
      # @!group Playground

      # @label Playground
      # @description Interactive avatar component with customizable appearance and status
      #
      # @param size select { choices: [w8, w12, w16, w20, w24, w32] } "Size in pixels"
      # @param shape select { choices: [circle, squircle, hexagon, triangle] } "Shape of the avatar"
      # @param status select { choices: [none, online, offline] } "Status indicator"
      # @param img_src text "Image URL (leave empty for placeholder)"
      # @param img_alt text "Image alt text"
      # @param placeholder_text text "Text to display when no image"
      # @param classes text "Additional CSS classes"
      def playground(
        size: :w24,
        shape: :circle,
        status: nil,
        img_src: nil,
        img_alt: 'Avatar',
        placeholder_text: nil,
        classes: ''
      )
        # Use placeholder image if no custom image or placeholder text
        default_img = 'https://picsum.photos/200/300'
        img_src = img_src.presence || (placeholder_text.blank? ? default_img : nil)

        render(AvatarComponent.new(
                 size:,
                 shape:,
                 status:,
                 img_src:,
                 img_alt:,
                 placeholder_text:,
                 class: classes
               ))
      end

      # @!endgroup
      #

      def avatar
        render(AvatarComponent.new(
                 size: :w24,
                 img_src: 'https://picsum.photos/200/300'
               ))
      end

      def avatar_in_custom_sizes
        render_with_template
      end

      def avatar_placeholder
        render_with_template
      end

      def avatar_rounded
        render_with_template
      end

      def avatar_with_mask
        render_with_template
      end

      def avatar_with_presence_indicator
        render_with_template
      end

      # def avatar_with_ring
      #   render_with_template
      # end
    end
  end
end
