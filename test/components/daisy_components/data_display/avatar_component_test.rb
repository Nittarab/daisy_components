# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_avatar
        render_preview(:basic_direct)
        assert_selector('.avatar')
        assert_selector('.avatar > div.w-12')
        assert_selector('img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=A"]')
      end

      def test_renders_with_size
        render_preview(:sizes)
        assert_selector('.avatar > div.w-16')
        assert_selector('.avatar > div.w-24')
        assert_selector('.avatar > div.w-32')
      end

      def test_renders_with_shapes
        render_preview(:shapes)
        assert_selector('.avatar > div.rounded-full')
        assert_selector('.avatar > div.mask.mask-squircle')
        assert_selector('.avatar > div.mask.mask-hexagon')
        assert_selector('.avatar > div.mask.mask-triangle')
      end

      def test_renders_with_online_status
        render_inline(AvatarComponent.new(
                        status: :online,
                        size: 12,
                        img_src: 'https://placehold.co/400x400/22C55E/FFFFFF?text=ON',
                        img_alt: 'Online Avatar'
                      ))
        assert_selector('.avatar.online')
        assert_selector('.avatar > div.w-12')
        assert_selector('img[src="https://placehold.co/400x400/22C55E/FFFFFF?text=ON"]')
      end

      def test_renders_with_offline_status
        render_inline(AvatarComponent.new(
                        status: :offline,
                        size: 12,
                        img_src: 'https://placehold.co/400x400/EF4444/FFFFFF?text=OFF',
                        img_alt: 'Offline Avatar'
                      ))
        assert_selector('.avatar.offline')
        assert_selector('.avatar > div.w-12')
        assert_selector('img[src="https://placehold.co/400x400/EF4444/FFFFFF?text=OFF"]')
      end

      def test_renders_with_placeholder
        render_preview(:placeholder)
        assert_selector('.avatar')
        assert_selector('.avatar > div.w-12')
        assert_selector('.bg-neutral.text-neutral-content')
        assert_text('JD')
      end

      def test_renders_with_custom_classes
        render_inline(AvatarComponent.new(
                        class: 'custom-class',
                        size: 12,
                        img_src: 'https://placehold.co/400x400',
                        img_alt: 'Avatar'
                      ))
        assert_selector('.avatar.custom-class')
        assert_selector('.avatar > div.w-12')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         size: 24,
                         shape: :circle,
                         status: :online,
                         classes: 'custom-class'
                       })

        assert_selector('.avatar.online.custom-class')
        assert_selector('.avatar > div.w-24.rounded-full')
      end

      def test_invalid_status_is_ignored
        render_inline(AvatarComponent.new(
                        status: :invalid_status,
                        img_src: 'https://placehold.co/400x400'
                      ))
        refute_selector('.avatar.invalid_status')
        refute_selector('.avatar.online')
        refute_selector('.avatar.offline')
      end

      def test_image_alt_text_fallback
        render_inline(AvatarComponent.new(img_src: 'https://placehold.co/400x400'))
        assert_selector('img[alt="Avatar"]')
      end

      def test_invalid_size_value_is_ignored
        render_inline(AvatarComponent.new(
                        size: 999,
                        img_src: 'https://placehold.co/400x400'
                      ))
        refute_selector('.avatar > div.w-999')
      end

      def test_invalid_shape_value_defaults_to_rounded
        render_inline(AvatarComponent.new(
                        shape: :invalid_shape,
                        img_src: 'https://placehold.co/400x400'
                      ))
        assert_selector('.avatar > div')
      end

      def test_renders_with_block_syntax
        render_preview(:basic_block)
        assert_selector('.avatar')
        assert_selector('.avatar > div.w-12')
        assert_selector('img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=A"]')
      end

      def test_placeholder_and_image_are_mutually_exclusive
        render_inline(AvatarComponent.new(img_src: 'https://placehold.co/400x400')) do |component|
          component.with_placeholder { 'JD' }
        end
        assert_selector('img[src="https://placehold.co/400x400"]')
        refute_text('JD')
      end
    end
  end
end
