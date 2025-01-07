# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_accordion
        render_inline(AccordionComponent.new) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
          component.with_item(title: 'Item 2') { 'Content 2' }
        end

        assert_selector('.collapse', count: 2)
        assert_selector('.collapse-title', text: 'Item 1')
        assert_selector('.collapse-title', text: 'Item 2')
        assert_selector('.collapse-content', text: 'Content 1')
        assert_selector('.collapse-content', text: 'Content 2')
        assert_selector('input[type="checkbox"]', count: 2)
      end

      def test_renders_joined_accordion
        render_inline(AccordionComponent.new(join: true)) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
          component.with_item(title: 'Item 2') { 'Content 2' }
        end

        assert_selector('.join')
        assert_selector('.join-item', count: 2)
        assert_selector('.join.join-vertical')
        assert_selector('.collapse.join-item', count: 2)
      end

      def test_renders_with_arrow
        render_inline(AccordionComponent.new(arrow: true)) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
        end

        assert_selector('.collapse.collapse-arrow')
        refute_selector('.collapse-plus')
      end

      def test_renders_with_plus
        render_inline(AccordionComponent.new(plus: true)) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
        end

        assert_selector('.collapse.collapse-plus')
        refute_selector('.collapse-arrow')
      end

      def test_renders_with_radio
        render_inline(AccordionComponent.new(radio: true)) do |component|
          component.with_item(title: 'Item 1', name: 'group1') { 'Content 1' }
          component.with_item(title: 'Item 2', name: 'group1') { 'Content 2' }
        end

        assert_selector('input[type="radio"][name="group1"]', count: 2)
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_with_checked_item
        render_inline(AccordionComponent.new) do |component|
          component.with_item(title: 'Item 1', checked: true) { 'Content 1' }
        end

        assert_selector('input[checked]')
      end

      def test_renders_with_custom_classes
        render_inline(AccordionComponent.new(class: 'custom-class')) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
        end

        assert_selector('.custom-class')
      end

      def test_renders_with_complex_content
        render_complex_content_test
        assert_complex_content_selectors
      end

      def test_renders_with_nested_components
        render_nested_components_test
        assert_nested_components_selectors
      end

      private

      def render_complex_content_test
        render_inline(AccordionComponent.new) do |component|
          component.with_item(title: 'With List') do
            tag.ul(class: 'list-disc') do
              safe_join([
                          tag.li('First item'),
                          tag.li('Second item')
                        ])
            end
          end
        end
      end

      def assert_complex_content_selectors
        assert_selector('.collapse-content ul.list-disc')
        assert_selector('.collapse-content li', count: 2)
      end

      def render_nested_components_test
        render_inline(AccordionComponent.new) do |component|
          component.with_item(title: 'With Card') do
            tag.div(class: 'card') do
              tag.div(class: 'card-body') do
                tag.h2('Card Title', class: 'card-title')
              end
            end
          end
        end
      end

      def assert_nested_components_selectors
        assert_selector('.collapse-content .card')
        assert_selector('.collapse-content .card-body')
        assert_selector('.collapse-content .card-title', text: 'Card Title')
      end
    end
  end
end
