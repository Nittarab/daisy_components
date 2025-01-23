# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class SwapComponentTest < DaisyComponents::ComponentTestCase
      include ActionView::Helpers::TagHelper

      def test_renders_text_swap
        render_preview(:text)
        assert_selector('label.swap')
        assert_selector('input[type="checkbox"]', visible: :all)
        assert_selector('div.swap-on', text: 'ON')
        assert_selector('div.swap-off', text: 'OFF')
      end

      def test_renders_emoji_swap
        render_preview(:emoji)
        assert_selector('label.swap')
        assert_selector('div.swap-on', text: '😄')
        assert_selector('div.swap-off', text: '😴')
      end

      def test_renders_hamburger_menu
        render_preview(:hamburger, params: { effect: 'rotate' })
        assert_selector('label.swap.swap-rotate.btn.btn-ghost.btn-circle')
        assert_selector('svg.h-6.w-6')
      end

      def test_renders_volume_control
        render_preview(:volume, params: { effect: 'flip' })
        assert_selector('label.swap.swap-flip.btn.btn-ghost.btn-circle')
        assert_selector('svg.h-6.w-6')
      end

      def test_renders_theme_toggle
        render_preview(:theme)
        assert_selector('label.swap.btn.btn-ghost.btn-circle')
        assert_selector('svg.h-6.w-6')
      end

      def test_playground_renders_with_all_options
        render_preview(:theme, params: {
                         effect: 'rotate',
                         size: 'lg',
                         active: true
                       })

        assert_selector('label.swap.swap-rotate.btn.btn-ghost.btn-circle')
        assert_selector('svg.h-8.w-8')
      end

      def test_renders_with_custom_classes
        render_inline(DaisyComponents::Actions::SwapComponent.new(class: 'btn btn-ghost btn-circle')) do |component|
          component.with_on { 'ON' }
          component.with_off { 'OFF' }
        end

        assert_selector('label.swap')
        assert_selector('label.btn')
        assert_selector('label.btn-ghost')
        assert_selector('label.btn-circle')
      end

      def test_combines_multiple_modifiers
        render_swap_with_modifiers
        assert_all_modifiers_present
      end

      private

      def render_swap_with_modifiers
        render_inline(SwapComponent.new(
                        rotate: true,
                        flip: true,
                        active: true,
                        class: 'custom-class'
                      )) do |component|
          component.with_on { 'ON' }
          component.with_off { 'OFF' }
        end
      end

      def assert_all_modifiers_present
        assert_selector('label.swap')
        assert_selector('label.swap-rotate')
        assert_selector('label.swap-flip')
        assert_selector('label.swap-active')
        assert_selector('label.custom-class')
      end
    end
  end
end
