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