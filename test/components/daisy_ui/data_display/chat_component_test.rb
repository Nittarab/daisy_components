# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class ChatComponentTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(
        preview_class: ChatComponentPreview,
        component_name: 'chat',
        exclude: %w[playground rich_chat]
      )

      def test_renders_nothing_when_no_messages_are_provided
        render_inline(Chat.new)
        assert_no_selector 'div'
      end

      def test_renders_messages_with_explicit_positions
        messages = [
          { text: 'Hello', position: :start },
          { text: 'Hi there', position: :end }
        ]

        render_inline(Chat.new(messages: messages))

        assert_selector 'div.chat.chat-start', count: 1
        assert_selector 'div.chat.chat-end', count: 1
      end

      def test_automatically_positions_messages_based_on_user_id
        messages = [
          { text: 'From another user', user_id: 2 },
          { text: 'From the current user', user_id: 1 }
        ]

        render_inline(Chat.new(messages: messages, current_user_id: 1))

        assert_selector 'div.chat.chat-start', count: 1, text: 'From another user'
        assert_selector 'div.chat.chat-end', count: 1, text: 'From the current user'
      end

      def test_defaults_to_start_position_when_no_position_or_user_id_is_provided
        messages = [
          { text: 'Message with no positioning info' }
        ]

        render_inline(Chat.new(messages: messages))

        assert_selector 'div.chat.chat-start', count: 1
        assert_selector 'div.chat.chat-end', count: 0
      end

      def test_explicit_position_overrides_automatic_positioning
        messages = [
          { text: 'Should be at end despite user_id', user_id: 2, position: :end },
          { text: 'Should be at start despite user_id', user_id: 1, position: :start }
        ]

        render_inline(Chat.new(messages: messages, current_user_id: 1))

        assert_selector 'div.chat.chat-end', count: 1, text: 'Should be at end despite user_id'
        assert_selector 'div.chat.chat-start', count: 1, text: 'Should be at start despite user_id'
      end

      def test_applies_colors_to_individual_messages
        messages = [
          { text: 'Primary message', user_id: 1, color: :primary },
          { text: 'Secondary message', user_id: 1, color: :secondary }
        ]

        render_inline(Chat.new(messages: messages, current_user_id: 1))

        assert_selector 'div.chat-bubble.chat-bubble-primary', count: 1
        assert_selector 'div.chat-bubble.chat-bubble-secondary', count: 1
      end

      def test_passes_system_arguments_to_component
        messages = [
          { text: 'Test message' }
        ]

        component = Chat.new(messages: messages, id: 'test-id')
        assert_equal({ id: 'test-id' }, component.send(:html_attributes))
      end

      # Begin playground preview tests
      def test_playground_preview_with_auto_positioning
        render_preview('playground', params: { use_auto_positioning: true })
        assert_selector 'div.chat', count: 2
        assert_selector 'div.chat.chat-end', count: 1
        assert_selector 'div.chat.chat-start', count: 1
      end

      def test_playground_preview_with_specific_position
        render_preview('playground', params: { position: :end })
        assert_selector 'div.chat.chat-end', count: 1
      end

      def test_playground_preview_with_color
        render_preview('playground', params: {
                         color: :primary,
                         use_auto_positioning: true
                       })
        assert_selector 'div.chat-bubble', count: 2
      end

      def test_playground_preview_with_avatar
        render_preview('playground', params: { with_avatar: true })
        assert_selector 'div.chat-image', count: 1
      end

      def test_playground_preview_with_header
        render_preview('playground', params: { with_header: true })
        assert_selector 'div.chat-header', count: 1
      end

      def test_playground_preview_with_footer
        render_preview('playground', params: { with_footer: true })
        assert_selector 'div.chat-footer', count: 1
      end
    end
  end
end
