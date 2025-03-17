# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(
        preview_class: AccordionComponentPreview,
        component_name: 'accordion',
        exclude: %w[playground]
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.collapse', count: 3
        assert_selector 'input[type="checkbox"]', count: 3
      end

      def test_playground_preview_with_radio_input
        render_preview('playground', params: { input_type: 'radio' })
        assert_selector '.collapse', count: 3
        assert_selector 'input[type="radio"]', count: 3
      end

      def test_playground_preview_with_join
        render_preview('playground', params: { join: true })
        assert_selector '.join.join-vertical', count: 1
        assert_selector '.join-item', count: 3
      end

      def test_playground_preview_with_arrow_indicator
        render_preview('playground', params: { indicator: 'arrow' })
        assert_selector '.collapse-arrow', count: 3
      end

      def test_playground_preview_with_plus_indicator
        render_preview('playground', params: { indicator: 'plus' })
        assert_selector '.collapse-plus', count: 3
      end

      def test_playground_preview_with_custom_padding
        render_preview('playground', params: { padding: 'p-4' })
        # Don't assert exact count since it's rendering in multiple places
        assert_selector '.p-4'
      end

      def test_playground_preview_with_custom_classes
        render_preview('playground', params: { classes: 'test-class' })
        # Since there are multiple elements with test-class, just assert that it's present
        assert_selector '.test-class'
      end
    end
  end
end
