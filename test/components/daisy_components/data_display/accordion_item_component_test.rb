# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class AccordionItemComponentTest < DaisyComponents::ComponentTestCase
      def setup
        super
        @parent = AccordionComponent.new
      end

      def test_renders_basic_item
        render_inline(AccordionItemComponent.new(parent: @parent, title: 'Basic Item')) { 'Content' }

        assert_selector('.collapse')
        assert_selector('.collapse-title', text: 'Basic Item')
        assert_selector('.collapse-content', text: 'Content')
        assert_selector('input[type="checkbox"]', visible: false)
      end

      def test_renders_joined_item
        @parent = AccordionComponent.new(join: true)
        render_inline(AccordionItemComponent.new(parent: @parent, title: 'Joined Item')) { 'Content' }

        assert_selector('.collapse.join-item')
        assert_selector('.border.border-base-300')
      end

      def test_renders_with_arrow
        @parent = AccordionComponent.new(arrow: true)
        render_inline(AccordionItemComponent.new(parent: @parent, title: 'Arrow Item')) { 'Content' }

        assert_selector('.collapse.collapse-arrow')
        refute_selector('.collapse-plus')
      end

      def test_renders_with_plus
        @parent = AccordionComponent.new(plus: true)
        render_inline(AccordionItemComponent.new(parent: @parent, title: 'Plus Item')) { 'Content' }

        assert_selector('.collapse.collapse-plus')
        refute_selector('.collapse-arrow')
      end

      def test_renders_with_radio_input
        @parent = AccordionComponent.new(radio: true)
        render_inline(AccordionItemComponent.new(
                        parent: @parent,
                        title: 'Radio Item',
                        name: 'group1'
                      )) { 'Content' }

        assert_selector('input[type="radio"][name="group1"]', visible: false)
        refute_selector('input[type="checkbox"]')
      end

      def test_renders_checked_state
        render_inline(AccordionItemComponent.new(
                        parent: @parent,
                        title: 'Checked Item',
                        checked: true
                      )) { 'Content' }

        assert_selector('input[checked]', visible: false)
      end

      def test_renders_with_complex_content
        render_inline(AccordionItemComponent.new(parent: @parent, title: 'Complex Item')) do
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
                        parent: @parent,
                        title: '<span class="text-primary">HTML Title</span>'.html_safe
                      )) { 'Content' }

        assert_selector('.collapse-title span.text-primary', text: 'HTML Title')
      end

      def test_renders_with_multiple_features
        @parent = AccordionComponent.new(join: true, arrow: true)
        render_inline(AccordionItemComponent.new(
                        parent: @parent,
                        title: 'Multi-feature Item',
                        checked: true
                      )) { 'Content' }

        assert_selector('.collapse.collapse-arrow.join-item')
        assert_selector('.border.border-base-300')
        assert_selector('input[checked]', visible: false)
      end
    end
  end
end
