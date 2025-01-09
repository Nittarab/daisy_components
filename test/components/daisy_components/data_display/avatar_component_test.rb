# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_avatar_with_src
        render_inline(AvatarComponent.new(src: 'https://placehold.co/100x100'))

        assert_selector('.avatar')
        assert_selector('img[src="https://placehold.co/100x100"]')
      end

      def test_renders_basic_avatar_with_image_slot
        render_inline(AvatarComponent.new) do |component|
          component.with_image { tag.img(src: 'https://placehold.co/100x100', alt: 'Avatar') }
        end

        assert_selector('.avatar')
        assert_selector('img[src="https://placehold.co/100x100"]')
      end

      def test_renders_with_size
        render_inline(AvatarComponent.new(size: 16, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.w-16.h-16')
      end

      def test_renders_with_circle_shape
        render_inline(AvatarComponent.new(shape: :circle, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.rounded-full')
      end

      def test_renders_with_squircle_shape
        render_inline(AvatarComponent.new(shape: :squircle, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.mask.mask-squircle')
      end

      def test_renders_with_hexagon_shape
        render_inline(AvatarComponent.new(shape: :hexagon, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.mask.mask-hexagon')
      end

      def test_renders_with_triangle_shape
        render_inline(AvatarComponent.new(shape: :triangle, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.mask.mask-triangle')
      end

      def test_renders_with_online_status
        render_inline(AvatarComponent.new(online: true, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.online')
      end

      def test_renders_with_offline_status
        render_inline(AvatarComponent.new(offline: true, src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.offline')
      end

      def test_renders_with_placeholder
        render_inline(AvatarComponent.new) do |component|
          component.with_placeholder { 'PB' }
        end

        assert_selector('.avatar')
        assert_selector('.bg-neutral.text-neutral-content')
        assert_text('PB')
      end

      def test_renders_avatar_group
        render_inline(AvatarComponent.new) do |component|
          component.with_group(src: 'https://placehold.co/100x100')
          component.with_group(src: 'https://placehold.co/100x100')
        end

        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 2)
        assert_selector('img[src="https://placehold.co/100x100"]', count: 2)
      end

      def test_renders_with_custom_classes
        render_inline(AvatarComponent.new(class: 'custom-class', src: 'https://placehold.co/100x100'))

        assert_selector('.avatar.custom-class')
      end

      def test_renders_with_alt_text
        render_inline(AvatarComponent.new(src: 'https://placehold.co/100x100', alt: 'User Avatar'))

        assert_selector('img[alt="User Avatar"]')
      end

      def test_renders_with_multiple_attributes
        render_inline(AvatarComponent.new(
                        size: 24,
                        shape: :circle,
                        online: true,
                        src: 'https://placehold.co/100x100',
                        class: 'custom-class'
                      ))

        assert_selector('.avatar.w-24.h-24.rounded-full.online.custom-class')
      end
    end
  end
end
