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
        messages = [
          { text: 'What kind of nonsense is this', user_id: 2, color: :primary },
          { text: 'Put me on the Council and not make me a Master!??', user_id: 2, color: :secondary },
          { text: "That's never been done in the history of the Jedi.", user_id: 2, color: :accent },
          { text: "It's insulting!", user_id: 2, color: :neutral },
          { text: 'Calm down, Anakin.', user_id: 1, color: :info },
          { text: 'You have been given a great honor.', user_id: 1, color: :success },
          { text: 'To be on the Council at your age.', user_id: 1, color: :warning },
          { text: "It's never happened before.", user_id: 1, color: :error }
        ]

        render DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Chat with Header and Footer
      # @description Chat bubbles with header and footer information
      def chat_with_header_and_footer
        messages = [
          { text: 'You were the Chosen One!', user_id: 2, header: { text: 'Obi-Wan Kenobi', time: '2 hours ago' }, footer: { text: 'Seen' } },
          { text: 'I loved you.', user_id: 2, header: { text: 'Obi-Wan Kenobi', time: '2 hour ago' }, footer: { text: 'Delivered' } }
        ]

        render DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Chat with Image
      # @description Chat bubbles with avatar images
      def chat_with_image
        avatar = {
          img_src: 'https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp',
          img_alt: 'Tailwind CSS chat bubble component'
        }
        messages = [
          { text: 'It was said that you would, destroy the Sith, not join them.', user_id: 2, avatar: avatar },
          { text: 'It was you who would bring balance to the Force', user_id: 2, avatar: avatar },
          { text: 'Not leave it in Darkness', user_id: 2, avatar: avatar }
        ]

        render DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Chat with Image, Header and Footer
      # @description Chat bubbles with avatar, header and footer
      def chat_with_image_header_and_footer
        avatar = {
          img_src: 'https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp',
          img_alt: 'Tailwind CSS chat bubble component'
        }
        messages = [
          { text: 'You were the Chosen One!', position: :start, avatar: avatar, header: { text: 'Obi-Wan Kenobi', time: '12:45' }, footer: { text: 'Delivered' } },
          { text: 'I hate you!', position: :end, avatar: avatar, header: { text: 'Anakin', time: '12:46' }, footer: { text: 'Seen at 12:46' } }
        ]

        render DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Basic Chat Start and End
      # @description Chat bubbles with different positions
      def chat_start_and_chat_end
        messages = [
          { text: "It's over Anakin,\nI have the high ground.", user_id: 2 },
          { text: 'You underestimate my power!', user_id: 1 }
        ]

        render DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Basic Chat
      # @description Simple chat with start and end positions
      def basic_chat
        messages = [
          { text: 'Hi! How can I help you today?', user_id: 2 },
          { text: "I'm looking for pricing information.", user_id: 1 },
          { text: "I'll be happy to help you with pricing details.", user_id: 2 }
        ]

        render DaisyComponents::DataDisplay::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Rich Chat
      # @description Chat with all features combined
      def rich_chat
        render_with_template
      end
    end
  end
end
