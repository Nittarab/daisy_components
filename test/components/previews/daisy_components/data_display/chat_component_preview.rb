# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # @label Chat
    class ChatComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

      # @!group Playground
      # @label Playground
      # @param position select [auto, start, end]
      # @param color select [primary, secondary, accent, neutral, info, success, warning, error]
      # @param with_avatar toggle
      # @param with_header toggle
      # @param with_footer toggle
      # @param use_auto_positioning toggle
      def playground(
        position: :auto,
        color: nil,
        with_avatar: false,
        with_header: false,
        with_footer: false,
        use_auto_positioning: false
      )
        avatar_options = with_avatar ? { img_src: 'https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp', img_alt: 'User avatar' } : nil
        header_options = with_header ? { text: 'User', time: '12:45' } : nil
        footer_options = with_footer ? { text: 'Delivered', time: '12:46' } : nil

        messages = []

        if use_auto_positioning
          # Example with automatic positioning
          messages = [
            {
              text: 'Hello! This is your message.',
              user_id: 1,
              color: color,
              avatar: avatar_options,
              header: header_options,
              footer: footer_options
            },
            {
              text: 'Hi there! This is a message from someone else.',
              user_id: 2,
              color: color,
              avatar: avatar_options,
              header: header_options,
              footer: footer_options
            }
          ]
          render(DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1))
        else
          # Example with manual positioning
          messages = [
            {
              text: 'Hello! This is a sample message.',
              position: position == :auto ? :start : position,
              color: color,
              avatar: avatar_options,
              header: header_options,
              footer: footer_options
            }
          ]
          render(DaisyComponents::DataDisplay::ChatComponent.new(messages: messages))
        end
      end
      # @!endgroup

      # @label Chat Bubble with Colors
      # @description Chat bubbles with different color variants
      def chat_bubble_with_colors
        render_with_template
      end

      # @label Chat with Header and Footer
      # @description Chat bubbles with header and footer information
      def chat_with_header_and_footer
        render_with_template
      end

      # @label Chat with Image
      # @description Chat bubbles with avatar images
      def chat_with_image
        render_with_template
      end

      # @label Chat with Image, Header and Footer
      # @description Chat bubbles with avatar, header and footer
      def chat_with_image_header_and_footer
        render_with_template
      end

      # @label Basic Chat Start and End
      # @description Chat bubbles with different positions
      def chat_start_and_chat_end
        render_with_template
      end

      # @label Basic Chat
      # @description Simple chat with start and end positions
      def basic_chat
        render_with_template
      end

      # @label Rich Chat
      # @description Chat with all features combined
      def rich_chat
        render_with_template
      end
    end
  end
end
