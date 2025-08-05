# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Navigation
    class TabsTest < DaisyUI::ComponentTestCase
      include PreviewTestConcern

      test_all_preview_examples(
        preview_class: TabsPreview,
        component_name: 'tabs',
        exclude: %w[playground]
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector '.tabs-container', count: 1
        assert_selector '.tabs', count: 1
        assert_selector '.tab', count: 4
        assert_selector '.tab-active', count: 1
        assert_selector '.tab-disabled', count: 1
        assert_selector '.tab-content-container', count: 1
        assert_selector '.tab-panel', count: 4
        assert_text 'Home'
        assert_text 'About'
        assert_text 'Services'
        assert_text 'Contact'
      end

      def test_playground_preview_without_content
        render_preview('playground', show_content: false)
        assert_selector '.tabs', count: 1
        assert_selector '.tab', count: 4
        assert_no_selector '.tabs-container'
        assert_no_selector '.tab-content-container'
        assert_no_selector '.tab-panel'
      end

      def test_playground_preview_bordered_style
        render_preview('playground', style: :bordered)
        assert_selector '.tabs.tabs-bordered', count: 1
      end

      def test_playground_preview_large_size
        render_preview('playground', size: :lg)
        assert_selector '.tabs.tabs-lg', count: 1
      end

      # Additional specific tests
      def test_basic_tabs_structure
        render_preview('basic_tabs')
        assert_selector '.tabs-container', count: 1
        assert_selector '.tabs', count: 1
        assert_selector '.tab', count: 3
        assert_selector '.tab-active', count: 1
        assert_selector '.tab-panel', count: 3
        assert_text 'Tab 1'
        assert_text 'Content for Tab 1'
      end

      def test_tabs_without_content_structure
        render_preview('tabs_without_content')
        assert_selector '.tabs', count: 1
        assert_selector 'a.tab[href]', count: 4
        assert_no_selector '.tabs-container'
        assert_no_selector '.tab-content-container'
        assert_no_selector '.tab-panel'
      end

      def test_disabled_tabs
        render_preview('tabs_with_disabled_items')
        assert_selector '.tab-disabled', count: 2
        assert_selector 'button[disabled]', count: 2
      end

      def test_navigation_tabs
        render_preview('navigation_tabs')
        assert_selector 'a.tab[href]', count: 4
        assert_no_selector '.tabs-container'
        assert_no_selector '.tab-content-container'
      end

      def test_javascript_ready_tabs
        render_preview('javascript_ready_tabs')
        assert_selector '[data-controller="tabs"]', count: 1
        assert_selector '.tabs.tabs-bordered', count: 1
        assert_selector '.tab', count: 4
        assert_selector '.tab-panel', count: 4
        assert_text 'Profile Settings'
        assert_text 'Account Settings'
      end
    end
  end
end
