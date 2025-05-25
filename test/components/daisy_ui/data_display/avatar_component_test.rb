# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class AvatarComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: AvatarComponentPreview, component_name: 'avatar')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.avatar', count: 1
        assert_selector '.avatar > div.w-24', count: 1
        assert_selector '.avatar > div.rounded-full', count: 1
        assert_selector 'img[src]', count: 1
      end

      def test_playground_preview_with_custom_size
        render_preview('playground', params: { size: 'w16' })
        assert_selector '.avatar > div.w-16', count: 1
      end

      def test_playground_preview_with_shape_squircle
        render_preview('playground', params: { shape: 'squircle' })
        assert_selector '.avatar > div.mask.mask-squircle', count: 1
      end

      def test_playground_preview_with_shape_hexagon
        render_preview('playground', params: { shape: 'hexagon' })
        assert_selector '.avatar > div.mask.mask-hexagon', count: 1
      end

      def test_playground_preview_with_shape_triangle
        render_preview('playground', params: { shape: 'triangle' })
        assert_selector '.avatar > div.mask.mask-triangle', count: 1
      end

      def test_playground_preview_with_status_online
        render_preview('playground', params: { status: 'online' })
        assert_selector '.avatar.avatar-online', count: 1
      end

      def test_playground_preview_with_status_offline
        render_preview('playground', params: { status: 'offline' })
        assert_selector '.avatar.avatar-offline', count: 1
      end

      def test_playground_preview_with_custom_image
        custom_img = 'https://example.com/image.jpg'
        render_preview('playground', params: { img_src: custom_img })
        assert_selector "img[src='#{custom_img}']", count: 1
      end

      def test_playground_preview_with_custom_alt
        render_preview('playground', params: { img_alt: 'Custom alt text' })
        assert_selector "img[alt='Custom alt text']", count: 1
      end

      def test_playground_preview_with_placeholder_text
        render_preview('playground', params: { placeholder_text: 'AB', img_src: '' })
        assert_selector '.avatar.avatar-placeholder', count: 1
        assert_selector '.avatar > div.bg-neutral.text-neutral-content', count: 1
        assert_text 'AB'
        assert_selector 'img', count: 0
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { classes: 'test-class' })
        assert_selector '.avatar.test-class', count: 1
      end
    end
  end
end
