# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionItemComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_item
        render_inline(AccordionItemComponent.new(title: 'Basic Item')) { 'Content' }

        assert_selector('.collapse')
        assert_selector('.collapse-title', text: 'Basic Item')
        assert_selector('.collapse-content', text: 'Content')
        assert_selector('input[type="checkbox"]', visible: false)
      end

      def test_renders_joined_item
        render_inline(AccordionItemComponent.new(title: 'Joined Item', join: true)) { 'Content' }

        assert_selector('.collapse.join-item')
        assert_selector('.border.border-base-300')
      end

      def test_renders_with_arrow
        render_inline(AccordionItemComponent.new(title: 'Arrow Item', arrow: true)) { 'Content' }

        assert_selector('.collapse.collapse-arrow')
        refute_selector('.collapse-plus')
      end

      def test_renders_with_plus
        render_inline(AccordionItemComponent.new(title: 'Plus Item', plus: true)) { 'Content' }

        assert_selector('.collapse.collapse-plus')
        refute_selector('.collapse-arrow')
      end

      def test_renders_with_radio_input
        render_inline(AccordionItemComponent.new(
                        title: 'Radio Item',
                        name: 'group1',
                        radio: true
                      )) { 'Content' }

        assert_selector('input[type="radio"][name="group1"]', visible: false)
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_checked_state
        render_inline(AccordionItemComponent.new(
                        title: 'Checked Item',
                        checked: true
                      )) { 'Content' }

        assert_selector('input[checked]', visible: false)
      end

      def test_renders_with_complex_content
        render_inline(AccordionItemComponent.new(title: 'Complex Item')) do
          tag.div(class: 'custom-content') do
            tag.h3('Subtitle') +
              tag.p('Paragraph text')
          end
        end

        assert_selector('.collapse-content .custom-content')
        assert_selector('.custom-content h3', text: 'Subtitle')
        assert_selector('.custom-content p', text: 'Paragraph text')
      end

      def test_renders_with_html_title
        render_inline(AccordionItemComponent.new(
                        title: '<span class="text-primary">HTML Title</span>'.html_safe
                      )) { 'Content' }

        assert_selector('.collapse-title span.text-primary', text: 'HTML Title')
      end

      def test_renders_with_multiple_features
        render_inline(AccordionItemComponent.new(
                        title: 'Multi Feature',
                        join: true,
                        arrow: true
                      )) { 'Content' }

        assert_selector('.collapse.join-item.collapse-arrow')
        assert_selector('.border.border-base-300')
      end

      def test_html_attributes_handling
        render_inline(AccordionItemComponent.new(
                        title: 'Item with Attributes',
                        class: 'custom-class',
                        data: { controller: 'test' },
                        aria: { label: 'Accordion Item' }
                      )) { 'Content' }
        assert_selector('.collapse.custom-class[data-controller="test"][aria-label="Accordion Item"]')
      end
    end
  end
end
