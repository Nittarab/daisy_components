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
        assert_selector("img[src='test.jpg']")
        assert_selector("img[src='test2.jpg']")
      end

      def test_renders_with_size
        render_inline(AvatarGroupComponent.new(size: 32)) do |group|
          group.with_avatar(img_src: 'test.jpg')
        end

        assert_selector('.avatar .w-32')
      end

      def test_renders_with_shape
        render_inline(AvatarGroupComponent.new(shape: :squircle)) do |group|
          group.with_avatar(img_src: 'test.jpg')
        end

        assert_selector('.avatar .mask.mask-squircle')
      end

      def test_renders_with_custom_spacing
        render_inline(AvatarGroupComponent.new(spacing: -12)) do |group|
          group.with_avatar(img_src: 'test.jpg')
          group.with_avatar(img_src: 'test2.jpg')
        end

        assert_selector("[style*='--avatar-spacing: -12px']")
      end

      def test_renders_with_max_display_and_counter
        render_inline(AvatarGroupComponent.new(max_display: 2)) do |group|
          group.with_avatar(img_src: 'test1.jpg')
          group.with_avatar(img_src: 'test2.jpg')
          group.with_avatar(img_src: 'test3.jpg')
          group.with_avatar(img_src: 'test4.jpg')
        end

        assert_selector('.avatar', count: 3) # 2 avatars + counter
        assert_selector('.avatar.placeholder', text: '+2')
      end

      def test_renders_with_placeholder
        render_inline(AvatarGroupComponent.new) do |group|
          group.with_avatar(placeholder_text: 'JD')
        end

        assert_selector('.avatar.placeholder', text: 'JD')
      end

      def test_preview_playground
        render_preview(:playground)
        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 5)
        assert_selector("img[src='https://placehold.co/100']", count: 5)
      end

      def test_preview_default
        render_preview(:default)
        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 3)
        assert_selector("img[src='https://placehold.co/100']", count: 3)
      end

      def test_preview_with_size
        render_preview(:with_size)
        assert_selector('.avatar-group')
        assert_selector('.avatar .w-32', count: 3)
      end

      def test_preview_with_shape
        render_preview(:with_shape)
        assert_selector('.avatar-group')
        assert_selector('.avatar .mask.mask-squircle', count: 3)
      end

      def test_preview_with_spacing
        render_preview(:with_spacing)
        assert_selector('.avatar-group')
        assert_selector("[style*='--avatar-spacing: -12px']")
      end

      def test_preview_with_counter
        render_preview(:with_counter)
        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 3) # 2 avatars + counter
        assert_selector('.avatar.placeholder', text: '+2')
      end

      def test_preview_with_placeholders
        render_preview(:with_placeholders)
        assert_selector('.avatar-group')
        assert_selector('.avatar.placeholder', count: 3)
        assert_selector('.avatar.placeholder', text: 'JD')
        assert_selector('.avatar.placeholder', text: 'AB')
        assert_selector('.avatar.placeholder', text: 'CD')
      end
    end
  end
end
