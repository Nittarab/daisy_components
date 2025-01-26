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
      def test_renders_basic_swap
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }))

        assert_selector('.swap')
        assert_selector('input[type="checkbox"]')
        assert_selector('.swap-on', text: 'On')
        assert_selector('.swap-off', text: 'Off')
      end

      def test_renders_with_initial_value
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, value: true))

        assert_selector('.swap')
        assert_selector('input[type="checkbox"][checked]')
      end

      def test_renders_with_indeterminate
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, indeterminate: true))

        assert_selector('.swap')
        assert_selector('input[type="checkbox"][indeterminate]')
      end

      def test_renders_with_effect
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, effect: 'flip'))

        assert_selector('.swap.swap-flip')
      end

      def test_renders_with_variant
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, variant: 'ghost'))

        assert_selector('.swap.text-base-content')
      end

      def test_renders_with_size
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, size: 'md'))

        assert_selector('.swap.text-base')
      end

      def test_renders_as_button
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, button: true))

        assert_selector('.swap.btn')
      end

      def test_validates_states
        assert_raises(ArgumentError) do
          render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, effect: 'invalid'))
        end

        assert_raises(ArgumentError) do
          render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, variant: 'invalid'))
        end

        assert_raises(ArgumentError) do
          render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, size: 'invalid'))
        end
      end

      def test_renders_with_custom_classes
        render_inline(SwapComponent.new(states: { on: 'On', off: 'Off' }, class: 'custom-class'))

        assert_selector('.swap.custom-class')
      end

      def test_playground_preview
        render_preview(:playground)
        assert_selector('.swap')
      end

      def test_value_on_preview
        render_preview(:value_on)
        assert_selector('.swap')
        assert_selector('input[type="checkbox"][checked]')
      end

      def test_text_preview
        render_preview(:text)
        assert_selector('.swap')
        assert_selector('.swap-on', text: 'ON')
        assert_selector('.swap-off', text: 'OFF')
      end

      def test_theme_preview
        render_preview(:theme)
        assert_selector('.swap')
        assert_selector('.swap-on', text: '🌞')
        assert_selector('.swap-off', text: '🌚')
      end

      def test_weather_preview
        render_preview(:weather)
        assert_selector('.swap')
        assert_selector('.swap-on', text: '☀️')
        assert_selector('.swap-off', text: '☁️')
      end

      def test_hamburger_preview
        render_preview(:hamburger)
        assert_selector('.swap')
        assert_selector('.swap-on', text: '✕')
        assert_selector('.swap-off', text: '☰')
      end

      def test_volume_preview
        render_preview(:volume)
        assert_selector('.swap')
        assert_selector('.swap-on', text: '🔊')
        assert_selector('.swap-off', text: '🔇')
      end

      def test_active_preview
        render_preview(:active)
        assert_selector('.swap.swap-active')
      end

      def test_flip_active_preview
        render_preview(:flip_active)
        assert_selector('.swap.swap-flip-active')
        assert_selector('.swap-on', text: '✓')
        assert_selector('.swap-off', text: '×')
      end

      def test_indeterminate_preview
        render_preview(:indeterminate)
        assert_selector('.swap')
        assert_selector('input[type="checkbox"][indeterminate]')
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

      def test_accessibility_attributes
        render_inline(SwapComponent.new(
                        states: @default_states,
                        aria: { label: 'Toggle theme' }
                      ))
        assert_selector('label[aria-label="Toggle theme"]')
        assert_selector('input[type="checkbox"][role="switch"]', visible: :all)
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
