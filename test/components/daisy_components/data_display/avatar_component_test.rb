# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_avatar
        render_preview(:basic)
        assert_selector('.avatar')
        assert_selector('img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=A"]')
      end

      def test_renders_with_size
        render_preview(:sizes)
        assert_selector('.avatar.w-16.h-16')
        assert_selector('.avatar.w-24.h-24')
        assert_selector('.avatar.w-32.h-32')
      end

      def test_renders_with_shapes
        render_preview(:shapes)
        assert_selector('.avatar.rounded-full')
        assert_selector('.avatar.mask.mask-squircle')
        assert_selector('.avatar.mask.mask-hexagon')
        assert_selector('.avatar.mask.mask-triangle')
      end

      def test_renders_with_online_status
        render_preview(:online)
        assert_selector('.avatar.online')
        assert_selector('img[src="https://placehold.co/400x400/22C55E/FFFFFF?text=ON"]')
      end

      def test_renders_with_offline_status
        render_preview(:offline)
        assert_selector('.avatar.offline')
        assert_selector('img[src="https://placehold.co/400x400/EF4444/FFFFFF?text=OFF"]')
      end

      def test_renders_with_placeholder
        render_preview(:placeholder)
        assert_selector('.avatar')
        assert_selector('.bg-neutral.text-neutral-content')
        assert_text('JD')
      end

      def test_renders_with_custom_classes
        render_inline(AvatarComponent.new(class: 'custom-class', size: 12)) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/400x400', alt: 'Avatar')
          end
        end
        assert_selector('.avatar.custom-class')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         size: 24,
                         shape: :circle,
                         online: true,
                         classes: 'custom-class'
                       })

        assert_selector('.avatar.w-24.h-24.rounded-full.online.custom-class')
      end
    end
  end
end
