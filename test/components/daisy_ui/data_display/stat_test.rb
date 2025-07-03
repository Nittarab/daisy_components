# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class StatTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: StatPreview, component_name: 'stat')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.stats', count: 1
        assert_selector 'div.stat', count: 1
        assert_text 'Total Page Views'
        assert_text '89,400'
        assert_text '21% more than last month'
      end

      def test_playground_preview_with_direction_vertical
        render_preview('playground', params: { direction: 'vertical' })
        assert_selector 'div.stats.stats-vertical', count: 1
      end

      def test_playground_preview_with_direction_responsive
        render_preview('playground', params: { direction: 'responsive' })
        assert_selector 'div.stats.stats-vertical.lg\\:stats-horizontal', count: 1
      end

      def test_playground_preview_with_shadow_disabled
        render_preview('playground', params: { shadow: false })
        assert_selector 'div.stats:not(.shadow)', count: 1
      end

      def test_playground_preview_with_centered_items
        render_preview('playground', params: { centered: true })
        assert_selector 'div.stat.place-items-center', count: 1
      end

      def test_playground_preview_with_icon
        render_preview('playground', params: { has_icon: true })
        assert_selector 'div.stat-figure', count: 1
        assert_selector 'div.stat-value.text-primary', count: 1
      end

      def test_playground_preview_with_custom_title
        render_preview('playground', params: { title: 'Custom Title' })
        assert_text 'Custom Title'
      end

      def test_playground_preview_with_custom_value
        render_preview('playground', params: { value: '999,999' })
        assert_text '999,999'
      end

      def test_playground_preview_with_custom_description
        render_preview('playground', params: { description: 'Custom description text' })
        assert_text 'Custom description text'
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { classes: 'test-class' })
        assert_selector 'div.stats.test-class', count: 1
      end

      def test_playground_preview_with_multiple_options
        render_preview('playground', params: {
                         title: 'Test Stat',
                         value: '12,345',
                         description: 'Test description',
                         direction: 'vertical',
                         shadow: true,
                         centered: true,
                         has_icon: true
                       })

        assert_selector 'div.stats.stats-vertical.shadow', count: 1
        assert_selector 'div.stat.place-items-center', count: 1
        assert_selector 'div.stat-figure', count: 1
        assert_selector 'div.stat-value.text-primary', count: 1
        assert_text 'Test Stat'
        assert_text '12,345'
        assert_text 'Test description'
      end

      def test_playground_preview_minimal_configuration
        render_preview('playground', params: {
                         title: 'Min',
                         value: '1',
                         description: '',
                         direction: 'horizontal',
                         shadow: false,
                         centered: false,
                         has_icon: false
                       })

        assert_selector 'div.stats:not(.shadow)', count: 1
        assert_selector 'div.stat:not(.place-items-center)', count: 1
        assert_selector 'div.stat-figure', count: 0
        assert_text 'Min'
        assert_text '1'
      end

      # Component unit tests
      def test_basic_stat_rendering
        component = DaisyUI::Stat.new(
          title: 'Test Title',
          value: '100',
          description: 'Test description',
          shadow: true
        )

        render_inline(component)

        assert_selector 'div.stats.shadow'
        assert_selector 'div.stat'
        assert_selector 'div.stat-title', text: 'Test Title'
        assert_selector 'div.stat-value', text: '100'
        assert_selector 'div.stat-desc', text: 'Test description'
      end

      def test_vertical_direction
        component = DaisyUI::Stat.new(
          direction: :vertical,
          title: 'Test',
          value: '123'
        )

        render_inline(component)

        assert_selector 'div.stats.stats-vertical'
      end

      def test_responsive_direction
        component = DaisyUI::Stat.new(
          direction: :responsive,
          title: 'Test',
          value: '123'
        )

        render_inline(component)

        assert_selector 'div.stats.stats-vertical.lg\\:stats-horizontal'
      end

      def test_multiple_stats
        component = DaisyUI::Stat.new(shadow: true)

        render_inline(component) do |comp|
          comp.with_stat(title: 'Stat 1', value: '100')
          comp.with_stat(title: 'Stat 2', value: '200')
        end

        assert_selector 'div.stats.shadow'
        assert_selector 'div.stat', count: 2
        assert_text 'Stat 1'
        assert_text 'Stat 2'
      end

      def test_centered_stat
        component = DaisyUI::Stat.new

        render_inline(component) do |comp|
          comp.with_stat(title: 'Test', value: '100', centered: true)
        end

        assert_selector 'div.stat.place-items-center'
      end

      def test_stat_with_colored_value
        component = DaisyUI::Stat.new

        render_inline(component) do |comp|
          comp.with_stat do |stat|
            stat.with_title { 'Test' }
            stat.with_value(color: :primary) { '100' }
          end
        end

        assert_selector 'div.stat-value.text-primary', text: '100'
      end

      def test_stat_with_figure_and_actions
        component = DaisyUI::Stat.new

        render_inline(component) do |comp|
          comp.with_stat do |stat|
            stat.with_figure { 'Icon' }
            stat.with_title { 'Test' }
            stat.with_value { '100' }
            stat.with_actions { 'Button' }
          end
        end

        assert_selector 'div.stat-figure', text: 'Icon'
        assert_selector 'div.stat-title', text: 'Test'
        assert_selector 'div.stat-value', text: '100'
        assert_selector 'div.stat-actions', text: 'Button'
      end

      def test_invalid_direction_raises_error
        assert_raises(ArgumentError) do
          DaisyUI::Stat.new(direction: :invalid)
        end
      end
    end
  end
end