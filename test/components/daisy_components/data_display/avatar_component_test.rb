# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_avatar
        render_preview(:basic)
        assert_selector('.avatar')
        assert_selector('.avatar > div.w-16')
        assert_selector('img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=A"]')
        assert_selector('img[alt="Avatar"]')
      end

      def test_renders_placeholder_preview
        render_preview(:placeholder)
        assert_selector('.avatar.placeholder')
        assert_selector('.avatar > div.w-16')
        assert_text('JD')
      end

      def test_renders_group_preview
        render_preview(:group)
        assert_selector('.avatar-group')
        assert_selector('img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=1"]')
        assert_selector('img[src="https://placehold.co/400x400/22C55E/FFFFFF?text=2"]')
        assert_selector('img[src="https://placehold.co/400x400/EF4444/FFFFFF?text=3"]')
        assert_selector('.avatar.placeholder', text: '+2')
      end

      def test_renders_with_size
        render_preview(:sizes)
        assert_selector('.avatar > div.w-8')  # xs
        assert_selector('.avatar > div.w-12') # sm
        assert_selector('.avatar > div.w-16') # md
        assert_selector('.avatar > div.w-20') # lg
      end

      def test_renders_with_shapes
        render_preview(:shapes)
        shapes = {
          circle: '.avatar > div.rounded-full',
          squircle: '.avatar > div.mask.mask-squircle',
          hexagon: '.avatar > div.mask.mask-hexagon',
          triangle: '.avatar > div.mask.mask-triangle',
          half_1: '.avatar > div.mask.mask-half-1',
          half_2: '.avatar > div.mask.mask-half-2'
        }

        shapes.each do |shape, selector|
          assert_selector(selector)
          assert_selector('img[alt="Avatar shape ' + shape.to_s + '"]')
        end
      end

      def test_renders_with_presence_states
        render_preview(:presence)
        assert_selector('.avatar.online')
        assert_selector('.avatar.offline')
        assert_selector('.avatar.away')
        assert_selector('.avatar.busy')
      end

      def test_renders_with_ring
        render_preview(:ring)
        assert_selector('.avatar.ring.ring-offset-base-100.ring-offset-2')
      end

      def test_renders_with_placeholder
        render_inline(AvatarComponent.new(size: :md, placeholder: 'JD'))
        assert_selector('.avatar.placeholder')
        assert_selector('.avatar > div.w-16')
        assert_text('JD')
      end

      def test_renders_avatar_group
        component = AvatarComponent.new(size: :md)

        result = render_inline(component) do |c|
          c.with_group do |group|
            group.size = :md
            group.shape = :circle
            group.img_src = 'https://placehold.co/400x400/3B82F6/FFFFFF?text=1'
            group.img_alt = 'Avatar 1'
          end

          c.with_group do |group|
            group.size = :md
            group.shape = :circle
            group.img_src = 'https://placehold.co/400x400/22C55E/FFFFFF?text=2'
            group.img_alt = 'Avatar 2'
          end

          c.with_group do |group|
            group.size = :md
            group.shape = :circle
            group.img_src = 'https://placehold.co/400x400/F59E0B/FFFFFF?text=3'
            group.img_alt = 'Avatar 3'
          end

          c.with_group do |group|
            group.size = :md
            group.shape = :circle
            group.img_src = 'https://placehold.co/400x400/EF4444/FFFFFF?text=4'
            group.img_alt = 'Avatar 4'
          end
        end

        assert_selector '.avatar-group'
        assert_selector 'img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=1"]'
        assert_selector 'img[src="https://placehold.co/400x400/22C55E/FFFFFF?text=2"]'
        assert_selector 'img[src="https://placehold.co/400x400/F59E0B/FFFFFF?text=3"]'
        assert_selector 'img[src="https://placehold.co/400x400/EF4444/FFFFFF?text=4"]'
      end

      def test_renders_with_custom_classes
        render_inline(AvatarComponent.new(
                        class: 'custom-class',
                        img_src: 'https://placehold.co/400x400',
                        img_alt: 'Avatar'
                      ))
        assert_selector('.avatar.custom-class')
        assert_selector('.avatar > div.w-16')
        assert_selector('img[src="https://placehold.co/400x400"]')
        assert_selector('img[alt="Avatar"]')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         size: :lg,
                         shape: :circle,
                         presence: :online,
                         ring: true,
                         img_src: 'https://placehold.co/400x400',
                         img_alt: 'Custom Avatar',
                         classes: 'custom-class'
                       })

        assert_selector('.avatar.online.ring.custom-class')
        assert_selector('.avatar > div.w-20.rounded-full')
        assert_selector('img[src="https://placehold.co/400x400"]')
        assert_selector('img[alt="Custom Avatar"]')
      end

      def test_renders_with_image_slot_override
        render_inline(AvatarComponent.new(
                        img_src: 'https://placehold.co/400x400',
                        img_alt: 'Default'
                      )) do |component|
          component.with_image do
            tag.img(src: 'https://placehold.co/custom', alt: 'Custom')
          end
        end

        assert_selector('img[src="https://placehold.co/custom"]')
        assert_selector('img[alt="Custom"]')
        refute_selector('img[src="https://placehold.co/400x400"]')
        refute_selector('img[alt="Default"]')
      end
    end
  end
end
