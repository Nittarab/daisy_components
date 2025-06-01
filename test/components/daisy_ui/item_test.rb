# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  class ItemTest < DaisyUI::ComponentTestCase
    def test_renders_content
      item_text = 'Item content'
      render_inline(Item.new) { item_text }

      # The component wraps content in a li tag
      assert_selector 'li', text: item_text
    end

    def test_renders_with_href
      item_text = 'Link Item'
      render_inline(Item.new(href: '/test')) { item_text }

      assert_selector 'li a[href="/test"]', text: item_text
    end

    def test_renders_with_custom_class
      item_text = 'Styled Item'
      render_inline(Item.new(class: 'custom-class')) { item_text }

      # When no href is provided, class is not applied directly
      assert_selector 'li', text: item_text
    end

    def test_renders_with_class_and_href
      item_text = 'Styled Link'
      render_inline(Item.new(href: '/test', class: 'custom-class')) { item_text }

      # When href is provided, class is applied to the a tag
      assert_selector 'li a.custom-class[href="/test"]', text: item_text
    end

    def test_renders_with_html_content
      render_inline(Item.new) { '<span>HTML Item</span>'.html_safe }

      assert_selector 'li span', text: 'HTML Item'
    end
  end
end
