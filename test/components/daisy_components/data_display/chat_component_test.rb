# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class ChatComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::PreviewTestConcern

      test_all_preview_examples(
        preview_class: ChatComponentPreview,
        component_name: 'chat',
        exclude: %w[playground rich_chat]
      )

      test 'renders nothing when no messages are provided' do
        render_inline(ChatComponent.new)
        assert_no_selector 'div'
      end

      test 'renders messages with explicit positions' do
        messages = [
          { text: 'Hello', position: :start },
          { text: 'Hi there', position: :end }
        ]

        render_inline(ChatComponent.new(messages: messages))

        assert_selector 'div.chat.chat-start', count: 1
        assert_selector 'div.chat.chat-end', count: 1
      end

      test 'automatically positions messages based on user_id' do
        messages = [
          { text: 'From another user', user_id: 2 },
          { text: 'From the current user', user_id: 1 }
        ]

        render_inline(ChatComponent.new(messages: messages, current_user_id: 1))

        assert_selector 'div.chat.chat-start', count: 1, text: 'From another user'
        assert_selector 'div.chat.chat-end', count: 1, text: 'From the current user'
      end

      test 'defaults to start position when no position or user_id is provided' do
        messages = [
          { text: 'Message with no positioning info' }
        ]

        render_inline(ChatComponent.new(messages: messages))

        assert_selector 'div.chat.chat-start', count: 1
        assert_selector 'div.chat.chat-end', count: 0
      end

      test 'explicit position overrides automatic positioning' do
        messages = [
          { text: 'Should be at end despite user_id', user_id: 2, position: :end },
          { text: 'Should be at start despite user_id', user_id: 1, position: :start }
        ]

        render_inline(ChatComponent.new(messages: messages, current_user_id: 1))

        assert_selector 'div.chat.chat-end', count: 1, text: 'Should be at end despite user_id'
        assert_selector 'div.chat.chat-start', count: 1, text: 'Should be at start despite user_id'
      end

      test 'applies colors to individual messages' do
        messages = [
          { text: 'Primary message', user_id: 1, color: :primary },
          { text: 'Secondary message', user_id: 1, color: :secondary }
        ]

        render_inline(ChatComponent.new(messages: messages, current_user_id: 1))

        assert_selector 'div.chat-bubble.chat-bubble-primary', count: 1
        assert_selector 'div.chat-bubble.chat-bubble-secondary', count: 1
      end
    end
  end
end
