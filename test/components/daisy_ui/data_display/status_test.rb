# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class StatusTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(preview_class: StatusPreview, component_name: 'status')

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.status', count: 1
      end

      def test_color_variants
        render_inline(DaisyUI::Status.new(color: :success))
        assert_selector '.status.status-success'

        render_inline(DaisyUI::Status.new(color: :error))
        assert_selector '.status.status-error'

        render_inline(DaisyUI::Status.new(color: :primary))
        assert_selector '.status.status-primary'
      end

      def test_size_variants
        render_inline(DaisyUI::Status.new(size: :xs))
        assert_selector '.status.status-xs'

        render_inline(DaisyUI::Status.new(size: :lg))
        assert_selector '.status.status-lg'
      end

      def test_custom_tag_type
        render_inline(DaisyUI::Status.new(tag_type: :span, color: :info))
        assert_selector 'span.status.status-info'
      end

      def test_invalid_color_raises_error
        assert_raises(ArgumentError) do
          DaisyUI::Status.new(color: :invalid)
        end
      end

      def test_invalid_size_raises_error
        assert_raises(ArgumentError) do
          DaisyUI::Status.new(size: :invalid)
        end
      end
    end
  end
end
