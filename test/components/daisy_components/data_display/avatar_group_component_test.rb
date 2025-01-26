# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarGroupComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_group
        render_inline(AvatarGroupComponent.new) do |group|
          group.with_avatar(img_src: 'test.jpg', img_alt: 'Test')
          group.with_avatar(img_src: 'test2.jpg', img_alt: 'Test 2')
        end

        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 2)
        assert_selector('.avatar div img[src="test.jpg"]')
        assert_selector('.avatar div img[src="test2.jpg"]')
      end

      def test_renders_with_size
        render_inline(AvatarGroupComponent.new(size: 32)) do |group|
          group.with_avatar(img_src: 'test.jpg')
        end

        assert_selector('.avatar div.w-32')
      end

      def test_renders_with_shape
        render_inline(AvatarGroupComponent.new(shape: :squircle)) do |group|
          group.with_avatar(img_src: 'test.jpg')
        end

        assert_selector('.avatar div.mask.mask-squircle')
      end

      def test_renders_with_custom_spacing
        render_inline(AvatarGroupComponent.new(spacing: 1.5)) do |group|
          group.with_avatar(img_src: 'test.jpg')
          group.with_avatar(img_src: 'test2.jpg')
        end

        assert_selector('.avatar-group.-space-x-6')
      end

      def test_renders_with_max_display_and_counter
        render_inline(AvatarGroupComponent.new(max_display: 2)) do |group|
          group.with_avatar(img_src: 'test1.jpg')
          group.with_avatar(img_src: 'test2.jpg')
          group.with_avatar(img_src: 'test3.jpg')
          group.with_avatar(img_src: 'test4.jpg')
        end

        assert_selector('.avatar', count: 3)
        assert_selector('.avatar-group')
        assert_text('+2')
      end

      def test_renders_with_placeholder
        render_inline(AvatarGroupComponent.new) do |group|
          group.with_avatar(placeholder_text: 'JD')
        end

        assert_selector('.avatar.placeholder div', text: 'JD')
      end

      def test_spacing_conversion
        {
          1.5 => 6,    # 1.5rem * 4 = 6
          2.0 => 8,    # 2.0rem * 4 = 8
          0.5 => 2     # 0.5rem * 4 = 2
        }.each do |rem, units|
          render_inline(AvatarGroupComponent.new(spacing: rem)) do |group|
            group.with_avatar(img_src: 'test.jpg')
          end

          assert_selector(".avatar-group.-space-x-#{units}")
        end
      end

      def test_preview_playground
        render_preview(:playground)

        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 5)
        assert_selector('.avatar div img[src="https://placehold.co/100"]', count: 5)
      end

      def test_preview_default
        render_preview(:default)

        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 3)
        assert_selector('.avatar div img[src="https://placehold.co/100"]', count: 3)
      end

      def test_preview_with_size
        render_preview(:with_size)

        assert_selector('.avatar-group')
        assert_selector('.avatar div.w-32', count: 3)
      end

      def test_preview_with_shape
        render_preview(:with_shape)

        assert_selector('.avatar-group')
        assert_selector('.avatar div.mask.mask-squircle', count: 3)
      end

      def test_preview_with_spacing
        render_preview(:with_spacing)

        assert_selector('.avatar-group.-space-x-12')
      end

      def test_preview_with_counter
        render_preview(:with_counter)

        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 3)
        assert_selector('.avatar.placeholder div', text: '+2')
      end

      def test_preview_with_placeholders
        render_preview(:with_placeholders)

        assert_selector('.avatar-group')
        assert_selector('.avatar.placeholder div', text: 'JD')
        assert_selector('.avatar.placeholder div', text: 'AB')
        assert_selector('.avatar.placeholder div', text: 'CD')
      end

      def test_preview_shapes
        render_preview(:shapes)

        # Circle
        assert_selector('.avatar-group .avatar div.rounded-full', count: 3)

        # Squircle
        assert_selector('.avatar-group .avatar div.mask.mask-squircle', count: 3)

        # Hexagon
        assert_selector('.avatar-group .avatar div.mask.mask-hexagon', count: 3)

        # Triangle
        assert_selector('.avatar-group .avatar div.mask.mask-triangle', count: 3)
      end

      def test_shape_classes_with_nil_shape
        render_inline(AvatarGroupComponent.new(shape: nil)) do |group|
          group.with_avatar(img_src: 'test.jpg')
        end
        assert_selector('.avatar div.rounded-full')
      end

      def test_html_attributes_handling
        render_inline(AvatarGroupComponent.new(
                        class: 'custom-class',
                        data: { controller: 'test' },
                        aria: { label: 'Avatar Group' }
                      )) do |group|
          group.with_avatar(img_src: 'test.jpg')
        end
        assert_selector('.avatar-group.custom-class[data-controller="test"][aria-label="Avatar Group"]')
      end
    end
  end
end
