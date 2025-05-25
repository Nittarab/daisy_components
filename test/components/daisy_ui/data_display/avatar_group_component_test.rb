# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class AvatarGroupComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: AvatarGroupComponentPreview, component_name: 'avatar_group')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.avatar-group', count: 1
        assert_selector '.avatar', count: 5
        assert_selector '.avatar > div.w-24', count: 5
        assert_selector '.avatar > div.rounded-full', count: 5
        assert_selector 'img[src*="picsum.photos/seed/user"]', count: 5
      end

      def test_playground_preview_with_custom_size
        render_preview('playground', params: { size: 'w16' })
        assert_selector '.avatar > div.w-16', count: 5
      end

      def test_playground_preview_with_shape_squircle
        render_preview('playground', params: { shape: 'squircle' })
        assert_selector '.avatar > div.mask.mask-squircle', count: 5
      end

      def test_playground_preview_with_shape_hexagon
        render_preview('playground', params: { shape: 'hexagon' })
        assert_selector '.avatar > div.mask.mask-hexagon', count: 5
      end

      def test_playground_preview_with_shape_triangle
        render_preview('playground', params: { shape: 'triangle' })
        assert_selector '.avatar > div.mask.mask-triangle', count: 5
      end

      def test_playground_preview_with_custom_spacing
        render_preview('playground', params: { spacing: 2.5 })
        assert_selector '.avatar-group.-space-x-10', count: 1
      end

      def test_playground_preview_with_max_display
        render_preview('playground', params: { max_display: 3 })
        assert_selector '.avatar > div > img[src*="picsum.photos/seed/user"]', count: 3
        assert_selector '.avatar > div.bg-neutral.text-neutral-content', count: 1
        assert_text '+2'
      end

      def test_playground_preview_with_max_display_one
        render_preview('playground', params: { max_display: 1 })
        assert_selector '.avatar > div > img[src*="picsum.photos/seed/user"]', count: 1
        assert_selector '.avatar > div.bg-neutral.text-neutral-content', count: 1
        assert_text '+4'
      end
    end
  end
end
