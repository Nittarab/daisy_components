# frozen_string_literal: true

module DaisyComponents
  module Actions
    # @label Swap
    class SwapComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

      # @!group Playground

      # Hamburger Menu
      # ---------------
      # Swap component used as a hamburger menu button
      #
      # @label Hamburger Menu
      # @param effect select ["none", "rotate", "flip"]
      # @param size select ["sm", "md", "lg"]
      def hamburger(effect: 'none', size: 'md')
        render_swap_with_icons(effect, size) do |size_class|
          [hamburger_icon(size_class), close_icon(size_class)]
        end
      end

      # Volume Control
      # ---------------
      # Volume control with different effects and sizes
      #
      # @label Volume Control
      # @param effect select ["none", "rotate", "flip"]
      # @param size select ["sm", "md", "lg"]
      def volume(effect: 'none', size: 'md')
        render_swap_with_icons(effect, size) do |size_class|
          [volume_on_icon(size_class), volume_off_icon(size_class)]
        end
      end

      # Theme Toggle
      # ---------------
      # Theme toggle with sun/moon icons
      #
      # @label Theme Toggle
      # @param effect select ["none", "rotate", "flip"]
      # @param size select ["sm", "md", "lg"]
      def theme(effect: 'none', size: 'md')
        render_swap_with_icons(effect, size) do |size_class|
          [sun_icon(size_class), moon_icon(size_class)]
        end
      end

      # @!endgroup

      # @!group Basic Examples

      # Text Swap
      # ---------------
      # Basic text swap with different effects
      #
      # @label Text Swap
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

      # Emoji Swap
      # ---------------
      # Fun emoji swap with different effects
      #
      # @label Emoji Swap
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
