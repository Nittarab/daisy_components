# frozen_string_literal: true

module DaisyUI
  module DataDisplay
    # @label Chat
    class ChatComponentPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

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
        if use_auto_positioning
          messages = create_auto_positioned_messages(color, with_avatar, with_header, with_footer)
          render(DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1))
        else
          messages = create_manually_positioned_messages(position, color, with_avatar, with_header, with_footer)
          render(DaisyUI::ChatComponent.new(messages: messages))
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

        render DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Chat with Header and Footer
      # @description Chat bubbles with header and footer information
      def chat_with_header_and_footer
        messages = [
          { text: 'You were the Chosen One!', user_id: 2, header: { text: 'Obi-Wan Kenobi', time: '2 hours ago' }, footer: { text: 'Seen' } },
          { text: 'I loved you.', user_id: 2, header: { text: 'Obi-Wan Kenobi', time: '2 hour ago' }, footer: { text: 'Delivered' } }
        ]

        render DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Chat with Image
      # @description Chat bubbles with avatar images
      def chat_with_image
        avatar = {
          img_src: 'https://picsum.photos/seed/avatar/100/100',
          img_alt: 'Tailwind CSS chat bubble component'
        }
        messages = [
          { text: 'It was said that you would, destroy the Sith, not join them.', user_id: 2, avatar: avatar },
          { text: 'It was you who would bring balance to the Force', user_id: 2, avatar: avatar },
          { text: 'Not leave it in Darkness', user_id: 2, avatar: avatar }
        ]

        render DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Chat with Image, Header and Footer
      # @description Chat bubbles with avatar, header and footer
      def chat_with_image_header_and_footer
        avatar = {
          img_src: 'https://picsum.photos/seed/avatar/100/100',
          img_alt: 'Tailwind CSS chat bubble component'
        }
        messages = [
          { text: 'You were the Chosen One!', position: :start, avatar: avatar, header: { text: 'Obi-Wan Kenobi', time: '12:45' }, footer: { text: 'Delivered' } },
          { text: 'I hate you!', position: :end, avatar: avatar, header: { text: 'Anakin', time: '12:46' }, footer: { text: 'Seen at 12:46' } }
        ]

        render DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Basic Chat Start and End
      # @description Chat bubbles with different positions
      def chat_start_and_chat_end
        messages = [
          { text: "It's over Anakin,\nI have the high ground.", user_id: 2 },
          { text: 'You underestimate my power!', user_id: 1 }
        ]

        render DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Basic Chat
      # @description Simple chat with start and end positions
      def basic_chat
        messages = [
          { text: 'Hi! How can I help you today?', user_id: 2 },
          { text: "I'm looking for pricing information.", user_id: 1 },
          { text: "I'll be happy to help you with pricing details.", user_id: 2 }
        ]

        render DaisyUI::ChatComponent.new(messages: messages, current_user_id: 1)
      end

      # @label Rich Chat
      # @description Chat with all features combined
      def rich_chat
        render_with_template
      end

      private

      def create_auto_positioned_messages(color, with_avatar, with_header, with_footer)
        avatar_opts = build_avatar_options(with_avatar)
        header_opts = build_header_options(with_header)
        footer_opts = build_footer_options(with_footer)

        [
          { text: 'Hello! This is your message.', user_id: 1, color: color, avatar: avatar_opts, header: header_opts, footer: footer_opts },
          { text: 'Hi there! This is a message from someone else.', user_id: 2, color: color, avatar: avatar_opts, header: header_opts, footer: footer_opts }
        ]
      end

      def create_manually_positioned_messages(position, color, with_avatar, with_header, with_footer)
        avatar_opts = build_avatar_options(with_avatar)
        header_opts = build_header_options(with_header)
        footer_opts = build_footer_options(with_footer)

        [
          {
            text: 'Hello! This is a sample message.',
            position: position == :auto ? :start : position,
            color: color,
            avatar: avatar_opts,
            header: header_opts,
            footer: footer_opts
          }
        ]
      end

      def build_avatar_options(with_avatar)
        with_avatar ? { img_src: 'https://picsum.photos/seed/avatar/100/100', img_alt: 'User avatar' } : nil
      end

      def build_header_options(with_header)
        with_header ? { text: 'User', time: '12:45' } : nil
      end

      def build_footer_options(with_footer)
        with_footer ? { text: 'Delivered', time: '12:46' } : nil
      end
    end
  end
end
