# frozen_string_literal: true

# @label Avatar Group
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class AvatarGroupComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Avatar Group Playground
      # ---------------
      # Interactive avatar group component with customizable styling. Try different combinations
      # of sizes, shapes, and spacing to see how the avatars group together.
      #
      # @param size select { choices: [w8, w12, w16, w20, w24, w32], default: w24 } "Size of avatars"
      # @param shape select { choices: [circle, squircle, hexagon, triangle], default: circle } "Shape of avatars"
      # @param spacing number { min: 0, max: 4, step: 0.5, default: 1.5 } "Spacing between avatars in rem"
      # @param max_display number { min: 1, max: 10, default: nil } "Maximum number of avatars to display"
      def playground(size: :w24, shape: :circle, spacing: 1.5, max_display: nil)
        render(DaisyUI::AvatarGroup.new(
                 size: size,
                 shape: shape,
                 spacing: spacing.to_f,
                 max_display: max_display
               )) do |group|
          5.times do |i|
            group.with_avatar(
              img_src: "https://picsum.photos/seed/user#{i}/200/200",
              img_alt: "User #{i + 1}"
            )
          end
        end
      end

      # @!endgroup

      def avatar_group_with_counter
        render(DaisyUI::AvatarGroup.new(
                 size: :w24,
                 shape: :circle,
                 spacing: 1.5,
                 max_display: 2
               )) do |group|
          group.with_avatar(img_src: 'https://picsum.photos/200/200')
          group.with_avatar(img_src: 'https://picsum.photos/200/200')
          group.with_avatar(img_src: 'https://picsum.photos/200/200')
        end
      end

      def avatar_group
        render(DaisyUI::AvatarGroup.new(
                 size: :w12,
                 shape: :circle,
                 spacing: 1.5
               )) do |group|
          group.with_avatar(placeholder_text: 'A')
          group.with_avatar(placeholder_text: 'B')
          group.with_avatar(placeholder_text: 'C')
          group.with_avatar(placeholder_text: 'D')
        end
      end
      # @!endgroup
    end
  end
end
