# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AvatarGroupComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_avatar_group
        render_preview(:basic)
        assert_selector('.avatar-group')
        assert_selector('.avatar', count: 4) # Including the counter avatar
        assert_selector('img[src="https://placehold.co/400x400/3B82F6/FFFFFF?text=1"]')
        assert_selector('img[src="https://placehold.co/400x400/22C55E/FFFFFF?text=2"]')
        assert_selector('img[src="https://placehold.co/400x400/EF4444/FFFFFF?text=3"]')
        assert_text('+2')
      end

      def test_renders_with_custom_classes
        render_inline(AvatarGroupComponent.new(class: 'custom-class')) do |component|
          component.with_avatar(size: 12) do |avatar|
            avatar.with_image do
              tag.img(src: 'https://placehold.co/400x400', alt: 'Avatar')
            end
          end
        end
        assert_selector('.avatar-group.custom-class')
      end
    end
  end
end
