# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # Chat bubble component implementing DaisyUI's chat bubble styles
    #
    # @example Basic usage
    #   <%= render(ChatBubbleComponent.new(text: "Hello!")) %>
    #
    # @example With avatar
    #   <%= render(ChatBubbleComponent.new(text: "Hello!")) do |c|
    #     <% c.with_avatar(img_src: "user.jpg", img_alt: "User") %>
    #   <% end %>
    #
    # @example With header and footer
    #   <%= render(ChatBubbleComponent.new(text: "Hello!")) do |c|
    #     <% c.with_header(text: "John Doe", time: "12:45") %>
    #     <% c.with_footer(text: "Delivered", time: "12:46") %>
    #   <% end %>
    #
    # @example End position
    #   <%= render(ChatBubbleComponent.new(text: "Hello!", position: :end)) %>
    #
    # @example With color
    #   <%= render(ChatBubbleComponent.new(text: "Hello!", color: :primary)) %>
    class ChatBubbleComponent < BaseComponent
      # Available chat bubble colors from DaisyUI
      COLORS = {
        primary: 'chat-bubble-primary',
        secondary: 'chat-bubble-secondary',
        accent: 'chat-bubble-accent',
        neutral: 'chat-bubble-neutral',
        info: 'chat-bubble-info',
        success: 'chat-bubble-success',
        warning: 'chat-bubble-warning',
        error: 'chat-bubble-error'
      }.freeze

      # Available positions
      POSITIONS = {
        start: 'chat-start',
        end: 'chat-end'
      }.freeze

      renders_one :avatar, lambda { |**system_arguments|
        size = system_arguments.delete(:size) || :w10
        AvatarComponent.new(**system_arguments, class: 'chat-image', size: size, shape: :circle)
      }

      renders_one :header, lambda { |**system_arguments|
        MetadataComponent.new(
          **@header_options, **system_arguments,
          type: :header,
          class: @header_class
        )
      }

      renders_one :footer, lambda { |**system_arguments|
        MetadataComponent.new(
          **@footer_options, **system_arguments,
          type: :footer,
          class: @footer_class
        )
      }

      # @param text [String] The text content to display inside the chat bubble
      # @param position [Symbol] Position of the chat bubble (:start, :end)
      # @param color [Symbol] Color variant of the chat bubble
      # @param avatar [Hash] Options for the avatar component
      # @param header [Hash] Options for the header metadata component
      # @param footer [Hash] Options for the footer metadata component
      def initialize(text = nil, position: :start, color: nil,
                     text_class: nil, header_class: nil,
                     footer_class: nil,
                     avatar: {},
                     header: {},
                     footer: {},
                     **system_arguments)
        @text = text
        @position = build_argument(position, POSITIONS, 'position')
        @color = build_argument(color, COLORS, 'color')
        @text_class = text_class
        @header_class = header_class
        @footer_class = footer_class
        @avatar_options = avatar
        @header_options = header
        @footer_options = footer
        @content_text = text
        super(**system_arguments)

        # Setup slots from provided options
        with_avatar(**@avatar_options) if @avatar_options&.any?
        with_header(**@header_options) if @header_options&.any?
        with_footer(**@footer_options) if @footer_options&.any?
      end

      # Set the text content
      def with_text(content = nil, &)
        @content_text = if block_given?
                          capture(&)
                        else
                          content
                        end
      end

      def call
        tag.div(**html_attributes) do
          components = []
          components << avatar if avatar?
          components << header if header?
          components << render_bubble if @content_text.present?
          components << footer if footer?
          safe_join(components)
        end
      end

      private

      def render_bubble
        tag.div(class: bubble_classes) do
          helpers.sanitize(markdown_renderer.render(@content_text),
                           tags: %w[p br a ul ol li strong em del ins code pre blockquote h1 h2 h3 h4 h5 h6 img
                                    span div],
                           attributes: %w[href target rel src alt class])
        end
      end

      def markdown_renderer
        @markdown_renderer ||= Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new(
            hard_wrap: true,
            link_attributes: { target: '_blank', rel: 'noopener' }
          ),
          {
            autolink: true,
            strikethrough: true,
            no_intra_emphasis: true,
            underline: true,
            highlight: true,
            fenced_code_blocks: true,
            disable_indented_code_blocks: true
          }
        )
      end

      def bubble_classes
        class_names(
          'chat-bubble',
          @color
        )
      end

      def computed_classes
        class_names(
          'chat',
          @position,
          system_arguments[:class]
        )
      end

      def html_attributes
        system_arguments.merge(
          class: computed_classes
        )
      end
    end
  end
end
