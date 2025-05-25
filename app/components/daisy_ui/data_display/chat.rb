# frozen_string_literal: true

module DaisyUI
  # Chat component for displaying a list of chat messages
  #
  # @example Basic usage
  #   <%= render(ChatComponent.new(messages: [
  #     { text: "Hello!", user_id: 1 },
  #     { text: "Hi there!", user_id: 2 }
  #   ], current_user_id: 1)) %>
  #
  # @example With specific positions (overriding automatic positioning)
  #   <%= render(ChatComponent.new(messages: [
  #     { text: "Hello!", position: :start },
  #     { text: "Hi there!", position: :end }
  #   ])) %>
  #
  # @example With avatar, header and footer
  #   <%= render(ChatComponent.new(
  #     messages: [
  #       {
  #         text: "Hello!",
  #         user_id: 1,
  #         avatar: { img_src: "user.jpg", img_alt: "User" },
  #         header: { text: "John", time: "12:45" },
  #         footer: { text: "Delivered", time: "12:46" }
  #       }
  #     ],
  #     current_user_id: 2
  #   )) %>
  class Chat < BaseComponent
    # Define a slot for multiple messages
    renders_many :bubbles, DaisyUI::ChatBubble

    include ActionView::Helpers::TagHelper

    # @param messages [Array<Hash>] Array of message objects to display
    # @param current_user_id [Any] ID of the current user to determine message positions
    # @option messages [String] :text The message text
    # @option messages [Any] :user_id ID of the user who sent the message
    # @option messages [Symbol] :position Optional override for the position (:start or :end)
    # @option messages [Symbol] :color The color of the message bubble
    # @option messages [Hash] :avatar Avatar options
    # @option messages [Hash] :header Header options
    # @option messages [Hash] :footer Footer options
    def initialize(messages: [], current_user_id: nil, **system_arguments)
      @messages = messages
      @current_user_id = current_user_id
      super(**system_arguments)

      # Pre-populate bubbles from messages array if provided
      @messages.each { |message| add_bubble(message) }
    end

    def call
      return unless bubbles.any?

      content_tag(:div, class: 'w-full') do
        safe_join(bubbles)
      end
    end

    private

    def add_bubble(message)
      position = determine_position(message)

      with_bubble(
        message[:text],
        position: position,
        color: message[:color],
        avatar: message[:avatar],
        header: message[:header],
        footer: message[:footer]
      )
    end

    def determine_position(message)
      return message[:position] if message[:position].present?

      if @current_user_id.present? && message[:user_id].present?
        message[:user_id] == @current_user_id ? :end : :start
      else
        :start # Default position if no positioning info is available
      end
    end

    def html_attributes
      system_arguments
    end
  end
end
