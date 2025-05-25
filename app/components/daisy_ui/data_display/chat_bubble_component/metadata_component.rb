# frozen_string_literal: true

module DaisyUI
  class ChatBubbleComponent
    # Component for chat bubble metadata (header/footer)
    #
    # @example Header usage
    #   <%= render(MetadataComponent.new(text: "John Doe", time: "12:45", type: :header)) %>
    #
    # @example Footer usage
    #   <%= render(MetadataComponent.new(text: "Delivered", time: "12:46", type: :footer)) %>
    class MetadataComponent < BaseComponent
      TYPES = %i[header footer].freeze

      TYPE_CLASSES = {
        header: 'chat-header',
        footer: 'chat-footer opacity-50'
      }.freeze

      # @param text [String] The main text content
      # @param time [String, nil] Optional timestamp
      # @param type [Symbol] Type of metadata (:header or :footer)
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(text:, type:, time: nil, **system_arguments)
        @text = text
        @time = time
        @type = validate_type!(type)
        super(**system_arguments)
      end

      def call
        tag.div(**html_attributes) do
          safe_join([
            @text,
            render_time
          ].compact)
        end
      end

      private

      def render_time
        return unless @time

        tag.time(@time, class: time_classes)
      end

      def computed_classes
        class_names(TYPE_CLASSES[@type], system_arguments[:class])
      end

      def html_attributes
        system_arguments.merge(
          class: computed_classes
        )
      end

      def time_classes
        modifiers = ['text-xs opacity-50']
        class_names(modifiers)
      end

      def validate_type!(type)
        type = type.to_sym
        return type if TYPES.include?(type)

        raise ArgumentError, "Invalid type: #{type}. Must be one of: #{TYPES.join(', ')}"
      end
    end
  end
end
