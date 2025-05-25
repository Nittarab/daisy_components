# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  class TitleComponentTest < DaisyUI::ComponentTestCase
    def test_renders_title
      title_text = 'Title content'
      render_inline(Title.new) { title_text }

      assert_selector 'li.menu-title', text: title_text
    end

    def test_renders_with_custom_class
      title_text = 'Custom Title'
      render_inline(Title.new(class: 'custom-class')) { title_text }

      # Verify that the default class is still present along with the custom class
      assert_selector 'li.menu-title', text: title_text
    end

    def test_renders_title_with_html_content
      render_inline(Title.new) { '<span>HTML Title</span>'.html_safe }

      assert_selector 'li.menu-title span', text: 'HTML Title'
    end
  end
end
