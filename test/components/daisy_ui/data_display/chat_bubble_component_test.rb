# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class ChatBubbleComponentTest < DaisyUI::ComponentTestCase
      def test_renders_basic_text_content
        render_inline(DaisyUI::ChatBubbleComponent.new('Hello World'))

        assert_selector 'div.chat.chat-start'
        assert_selector 'div.chat-bubble', text: 'Hello World'
      end

      def test_renders_markdown_content
        markdown_text = '**Bold text** and *italic text*'
        render_inline(DaisyUI::ChatBubbleComponent.new(markdown_text))

        assert_selector 'div.chat-bubble strong', text: 'Bold text'
        assert_selector 'div.chat-bubble em', text: 'italic text'
      end

      def test_renders_links_in_markdown
        markdown_text = 'Check out [this link](https://example.com)'
        render_inline(DaisyUI::ChatBubbleComponent.new(markdown_text))

        assert_selector 'div.chat-bubble a[href="https://example.com"][target="_blank"][rel="noopener"]',
                        text: 'this link'
      end

      def test_sanitizes_potentially_dangerous_html
        dangerous_text = "<script>alert('XSS')</script> <p>Safe content</p>"
        render_inline(DaisyUI::ChatBubbleComponent.new(dangerous_text))

        assert_no_selector 'script'
        assert_selector 'div.chat-bubble p', text: 'Safe content'
      end

      def test_renders_code_blocks
        code_text = "```ruby\ndef hello\n  puts 'world'\nend\n```"
        render_inline(DaisyUI::ChatBubbleComponent.new(code_text))

        assert_selector 'div.chat-bubble pre code'
      end

      def test_renders_with_custom_position
        render_inline(DaisyUI::ChatBubbleComponent.new('Hello', position: :end))

        assert_selector 'div.chat.chat-end'
        assert_selector 'div.chat-bubble', text: 'Hello'
      end

      def test_renders_with_custom_color
        render_inline(DaisyUI::ChatBubbleComponent.new('Hello', color: :primary))

        assert_selector 'div.chat-bubble.chat-bubble-primary', text: 'Hello'
      end

      def test_renders_content_from_block
        component = DaisyUI::ChatBubbleComponent.new
        component.with_text('Block content')

        render_inline(component)
        assert_selector 'div.chat-bubble', text: 'Block content'
      end

      def test_renders_content_from_parameter
        content_text = 'Parameter content'
        render_inline(DaisyUI::ChatBubbleComponent.new(content_text))

        assert_selector 'div.chat-bubble', text: content_text
      end

      def test_renders_with_avatar
        component = DaisyUI::ChatBubbleComponent.new('Hello')
        component.with_avatar(img_src: 'avatar.jpg', img_alt: 'User avatar')

        render_inline(component)
        assert_selector 'div.chat-image'
        assert_selector 'img[src="avatar.jpg"][alt="User avatar"]'
      end

      def test_renders_with_header
        component = DaisyUI::ChatBubbleComponent.new('Hello')
        component.with_header(text: 'John Doe', time: '12:45')

        render_inline(component)
        assert_selector 'div.chat-header', text: /John Doe/
        assert_selector 'div.chat-header time', text: '12:45'
      end

      def test_renders_with_footer
        component = DaisyUI::ChatBubbleComponent.new('Hello')
        component.with_footer(text: 'Delivered', time: '12:46')

        render_inline(component)
        assert_selector 'div.chat-footer', text: /Delivered/
        assert_selector 'div.chat-footer time', text: '12:46'
      end

      def test_renders_full_chat_bubble_with_all_components
        component = DaisyUI::ChatBubbleComponent.new('Hello World', color: :primary, position: :end)
        component.with_avatar(img_src: 'avatar.jpg', img_alt: 'User avatar')
        component.with_header(text: 'John Doe', time: '12:45')
        component.with_footer(text: 'Delivered', time: '12:46')

        render_inline(component)
        assert_selector 'div.chat.chat-end'
        assert_selector 'div.chat-bubble.chat-bubble-primary', text: 'Hello World'
        assert_selector 'div.chat-image img[src="avatar.jpg"]'
        assert_selector 'div.chat-header', text: /John Doe/
        assert_selector 'div.chat-footer', text: /Delivered/
      end
    end
  end
end
