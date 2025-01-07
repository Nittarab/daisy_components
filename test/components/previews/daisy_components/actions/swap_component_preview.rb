# frozen_string_literal: true

module DaisyComponents
  module Actions
    # @label Swap
    class SwapComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

      # @!group Basic Examples

      # @label Text Swap
      # @description Basic text swap with different effects
      # @param effect select ["none", "rotate", "flip"]
      def text(effect: 'none')
        render(SwapComponent.new(
                 rotate: effect == 'rotate',
                 flip: effect == 'flip'
               )) do |component|
          component.with_on { tag.div('ON', class: 'font-bold text-primary') }
          component.with_off { tag.div('OFF', class: 'font-bold text-base-content') }
        end
      end

      # @label Emoji Swap
      # @description Fun emoji swap with different effects
      # @param effect select ["none", "rotate", "flip"]
      def emoji(effect: 'none')
        render(SwapComponent.new(
                 rotate: effect == 'rotate',
                 flip: effect == 'flip'
               )) do |component|
          component.with_on { tag.div('😄', class: 'text-2xl') }
          component.with_off { tag.div('😴', class: 'text-2xl') }
        end
      end

      # @!endgroup

      # @!group UI Controls

      # @label Hamburger Menu
      # @description Swap component used as a hamburger menu button
      # @param effect select ["none", "rotate", "flip"]
      # @param size select ["sm", "md", "lg"]
      def hamburger(effect: 'none', size: 'md')
        render_swap_with_icons(effect, size) do |size_class|
          [hamburger_icon(size_class), close_icon(size_class)]
        end
      end

      # @label Volume Control
      # @description Volume control with different effects and sizes
      # @param effect select ["none", "rotate", "flip"]
      # @param size select ["sm", "md", "lg"]
      def volume(effect: 'none', size: 'md')
        render_swap_with_icons(effect, size) do |size_class|
          [volume_on_icon(size_class), volume_off_icon(size_class)]
        end
      end

      # @label Theme Toggle
      # @description Theme toggle with sun/moon icons
      # @param effect select ["none", "rotate", "flip"]
      # @param size select ["sm", "md", "lg"]
      def theme(effect: 'none', size: 'md')
        render_swap_with_icons(effect, size) do |size_class|
          [sun_icon(size_class), moon_icon(size_class)]
        end
      end

      # @!endgroup

      private

      def render_swap_with_icons(effect, size)
        size_class = icon_size_class(size)
        on_icon, off_icon = yield(size_class)
        render_swap_component(effect, on_icon, off_icon)
      end

      def icon_size_class(size)
        sizes = { 'sm' => 4, 'md' => 6, 'lg' => 8 }
        "h-#{sizes[size]} w-#{sizes[size]}"
      end

      def render_swap_component(effect, on_icon, off_icon)
        render(SwapComponent.new(
                 rotate: effect == 'rotate',
                 flip: effect == 'flip',
                 class: 'btn btn-ghost btn-circle'
               )) do |component|
          component.with_on { on_icon }
          component.with_off { off_icon }
        end
      end
    end
  end
end
