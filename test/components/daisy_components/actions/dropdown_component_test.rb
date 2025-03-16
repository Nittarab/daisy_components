# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class DropdownComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(
        preview_class: DropdownComponentPreview,
        component_name: 'dropdown',
        exclude: %w[playground]
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.dropdown', count: 1
        assert_selector '.dropdown-content', count: 1
        assert_selector '.menu', count: 1
        assert_text 'Click me'
      end

      def test_playground_preview_with_position
        render_preview('playground', params: { position: 'top' })
        assert_selector '.dropdown-top', count: 1
      end

      def test_playground_preview_with_hover
        render_preview('playground', params: { hover: true })
        assert_selector '.dropdown-hover', count: 1
      end

      def test_playground_preview_with_hover_content
        render_preview('playground', params: { hover: 'content' })
        assert_selector '.dropdown-hover-content', count: 1
      end

      def test_playground_preview_with_open
        render_preview('playground', params: { open: 'true' })
        assert_selector '.dropdown-open', count: 1
      end

      def test_playground_preview_with_align
        render_preview('playground', params: { align: 'center' })
        assert_selector '.dropdown-center', count: 1
      end

      def test_playground_preview_with_menu_class
        render_preview('playground', params: { menu_class: 'test-menu-class' })
        assert_selector '.test-menu-class', count: 1
      end

      def test_playground_preview_with_trigger_text
        render_preview('playground', params: { trigger_text: 'Custom Trigger' })
        assert_text 'Custom Trigger'
      end

      def test_playground_preview_with_trigger_icon
        render_preview('playground', params: { trigger_icon: true })
        assert_selector '.dropdown svg'
      end

      def test_playground_preview_with_header
        render_preview('playground', params: { show_header: 'true' })
        assert_text 'Menu'
      end

      def test_playground_preview_with_footer
        render_preview('playground', params: { show_footer: 'true' })
        assert_text 'Save changes'
        assert_selector '.btn.btn-primary', count: 1
      end
    end
  end
end
