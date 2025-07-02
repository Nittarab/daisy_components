# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Navigation
    class BreadcrumbsTest < DaisyUI::ComponentTestCase
      include PreviewTestConcern

      test_all_preview_examples(
        preview_class: BreadcrumbsPreview,
        component_name: 'breadcrumbs',
        exclude: %w[playground]
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'div.breadcrumbs', count: 1
      end

      def test_basic_breadcrumbs
        render_inline(DaisyUI::Breadcrumbs.new(
                        items: [
                          { text: 'Home', href: '/' },
                          { text: 'Current' }
                        ]
                      ))

        assert_selector 'div.breadcrumbs'
        assert_selector 'ul'
        assert_selector 'li', count: 2
        assert_selector 'a[href="/"]', text: 'Home'
        assert_selector 'li', text: 'Current'
      end

      def test_with_custom_size
        render_inline(DaisyUI::Breadcrumbs.new(
                        size: :lg,
                        items: [{ text: 'Test' }]
                      ))

        assert_selector 'div.breadcrumbs.text-lg'
      end

      def test_with_custom_classes
        render_inline(DaisyUI::Breadcrumbs.new(
                        class: 'max-w-xs custom-class',
                        items: [{ text: 'Test' }]
                      ))

        assert_selector 'div.breadcrumbs.max-w-xs.custom-class'
      end

      def test_slot_based_items
        render_inline(DaisyUI::Breadcrumbs.new) do |breadcrumbs|
          breadcrumbs.with_item(href: '/') { 'Home' }
          breadcrumbs.with_item { 'Current' }
        end

        assert_selector 'div.breadcrumbs'
        assert_selector 'a[href="/"]', text: 'Home'
        assert_selector 'li', text: 'Current'
      end

      def test_hybrid_approach
        render_inline(DaisyUI::Breadcrumbs.new(
                        items: [{ text: 'Home', href: '/' }]
                      )) do |breadcrumbs|
          breadcrumbs.with_item { 'Current' }
        end

        assert_selector 'div.breadcrumbs'
        assert_selector 'li', count: 2
        assert_selector 'a[href="/"]', text: 'Home'
        assert_selector 'li', text: 'Current'
      end
    end
  end
end
