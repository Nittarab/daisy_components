# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class SwapComponentTest < DaisyComponents::ComponentTestCase
      include ActionView::Helpers::TagHelper
      include DaisyComponents::IconsHelper

      def setup
        @default_states = { on: 'ON', off: 'OFF' }
        @icon_states = {
          on: sun_icon('h-6 w-6'),
          off: moon_icon('h-6 w-6')
        }
      end

      # Basic Rendering Tests
      def test_renders_basic_swap_component
        render_inline(SwapComponent.new(states: @default_states))
        assert_basic_structure
        assert_text_content('ON', 'OFF')
      end

      def test_renders_with_custom_classes
        render_inline(SwapComponent.new(
                        states: @default_states,
                        class: 'btn btn-ghost btn-circle'
                      ))

        assert_basic_structure
        assert_custom_classes(%w[btn btn-ghost btn-circle])
      end

      def test_combines_multiple_modifiers
        render_inline(SwapComponent.new(
                        states: @default_states,
                        effect: :rotate,
                        value: true,
                        class: 'custom-class'
                      ))

        assert_basic_structure
        assert_custom_classes(['custom-class'])
        assert_modifier_classes(['swap-rotate'])
        assert_checked(true)
      end

      def test_value_control
        # Test initial state (unchecked)
        render_inline(SwapComponent.new(states: @default_states))
        assert_basic_structure
        assert_selector('input[type="checkbox"]:not([checked])', visible: :all)

        # Test checked state
        render_inline(SwapComponent.new(states: @default_states, value: true))
        assert_basic_structure
        assert_selector('input[type="checkbox"][checked]', visible: :all)
      end

      def test_text_variant
        render_inline(SwapComponent.new(
                        states: @default_states,
                        variant: :primary
                      ))
        assert_basic_structure
        assert_text_content('ON', 'OFF')
        assert_selector('label.swap')
        assert_selector('label.text-primary')
        refute_selector('label.btn')
      end

      def test_emoji_variant
        states = { on: '🌞', off: '🌚' }
        render_inline(SwapComponent.new(
                        states: states,
                        size: :lg,
                        effect: :flip
                      ))
        assert_basic_structure
        assert_text_content('🌞', '🌚')
        assert_selector('label.swap.swap-flip')
        assert_selector('label.text-lg')
        refute_selector('label.btn')
      end

      def test_icon_variant
        render_inline(SwapComponent.new(
                        states: @icon_states,
                        button: true,
                        effect: :rotate
                      ))
        assert_basic_structure
        assert_selector('label.swap.swap-rotate.btn.btn-ghost.btn-circle')
        assert_icon_classes('div.swap-on svg', 'h-6 w-6')
        assert_icon_classes('div.swap-off svg', 'h-6 w-6')
      end

      # Preview Tests
      def test_playground_preview
        # Test a complex combination of parameters
        render_preview(:playground, params: {
                         variant: :primary,
                         size: :lg,
                         effect: :rotate,
                         value: true,
                         button: true
                       })

        assert_basic_structure
        assert_selector('label.swap.swap-rotate.btn.btn-ghost.btn-circle')
        assert_selector('input[type="checkbox"][checked]', visible: :all)
        assert_text_content('ON', 'OFF')
        assert_selector('label.text-primary')
        assert_selector('label.text-lg')
      end

      # Test that preview renders with minimal parameters
      def test_playground_preview_minimal
        render_preview(:playground)
        assert_basic_structure
        assert_text_content('ON', 'OFF')
      end

      def test_text_preview
        render_preview(:text)
        assert_basic_structure
        assert_text_content('ON', 'OFF')
        assert_selector('label.text-primary')
      end

      def test_theme_preview
        render_preview(:theme)
        assert_basic_structure
        assert_selector('label.swap.swap-rotate.btn.btn-ghost.btn-circle')
        assert_icon_classes('div.swap-on svg', 'h-6 w-6')
        assert_icon_classes('div.swap-off svg', 'h-6 w-6')
      end

      def test_weather_preview
        render_preview(:weather)
        assert_basic_structure
        assert_text_content('🌞', '🌚')
        assert_selector('label.swap.swap-flip')
        assert_selector('label.text-lg')
      end

      def test_hamburger_preview
        render_preview(:hamburger)
        assert_basic_structure
        assert_selector('label.swap.swap-rotate.btn.btn-ghost.btn-circle')
        assert_icon_classes('div.swap-on svg', 'h-6 w-6')
        assert_icon_classes('div.swap-off svg', 'h-6 w-6')
      end

      def test_volume_preview
        render_preview(:volume)
        assert_basic_structure
        assert_selector('label.swap.btn.btn-ghost.btn-circle')
        assert_icon_classes('div.swap-on svg', 'h-6 w-6')
        assert_icon_classes('div.swap-off svg', 'h-6 w-6')
      end

      def test_preview_value_control
        # Test ON state
        render_preview(:text, params: { value: '1' })
        assert_basic_structure
        assert_selector('input[type="checkbox"][checked="checked"]', visible: :all)
        assert_text_content('ON', 'OFF')

        # Test OFF state
        render_preview(:text, params: { value: '0' })
        assert_basic_structure
        assert_selector('input[type="checkbox"]', visible: :all)
        assert_text_content('ON', 'OFF')
      end

      def test_value_on_preview
        render_preview(:value_on)
        assert_basic_structure
        assert_selector('input[type="checkbox"][checked]', visible: :all)
        assert_text_content('ON', 'OFF')
        assert_selector('label.text-primary')
      end

      def test_accessibility_attributes
        render_inline(SwapComponent.new(
                        states: @default_states,
                        aria: { label: 'Toggle theme' }
                      ))
        assert_selector('label[aria-label="Toggle theme"]')
        assert_selector('input[type="checkbox"][role="switch"]', visible: :all)
      end

      def test_edge_cases
        # Test with empty states
        assert_raises(ArgumentError) do
          render_inline(SwapComponent.new(states: {}))
        end

        # Test with nil states
        assert_raises(ArgumentError) do
          render_inline(SwapComponent.new(states: nil))
        end

        # Test with missing required keys
        assert_raises(ArgumentError) do
          render_inline(SwapComponent.new(states: { on: 'ON' }))
        end
      end

      private

      def assert_basic_structure
        assert_selector('label.swap')
        assert_selector('input[type="checkbox"][role="switch"]', visible: :all)
        assert_selector('div.swap-on')
        assert_selector('div.swap-off')
      end

      def assert_custom_classes(classes)
        classes.each do |class_name|
          assert_selector("label.#{class_name}")
        end
      end

      def assert_modifier_classes(classes)
        classes.each do |class_name|
          assert_selector("label.#{class_name}")
        end
      end

      def assert_checked(expected)
        if expected
          assert_selector('input[type="checkbox"][checked]', visible: :all)
        else
          assert_selector('input[type="checkbox"]:not([checked])', visible: :all)
        end
      end

      def assert_text_content(on_text, off_text)
        assert_selector('div.swap-on', text: on_text)
        assert_selector('div.swap-off', text: off_text)
      end

      def assert_icon_classes(selector, classes)
        assert_selector(selector)
        assert_selector("#{selector}.#{classes.tr(' ', '.')}")
      end
    end
  end
end
