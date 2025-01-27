# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AccordionItemComponent < ViewComponent::Base
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::OutputSafetyHelper

      attr_reader :parent

      def initialize(title:, name: nil, checked: false, arrow: false, plus: false, radio: false, join: false,
                     bg_color: nil, text_color: nil, border_color: nil, padding: nil, **system_arguments)
        super()
        @title = title
        @name = name || SecureRandom.uuid
        @checked = checked
        @arrow = arrow
        @plus = plus
        @radio = radio
        @join = join
        @bg_color = bg_color || 'bg-base-100'
        @text_color = text_color
        @border_color = border_color || 'border border-base-300'
        @padding = padding
        @system_arguments = system_arguments
      end

      def call
        tag.div(**html_attributes) do
          helpers.safe_join([render_input, render_title, render_content].compact)
        end
      end

      private

      def html_attributes
        @system_arguments.except(:class).merge(
          class: item_classes
        )
      end

      def item_classes
        class_names(
          'collapse',
          { 'collapse-arrow' => @arrow && !@plus },
          { 'collapse-plus' => @plus },
          { 'join-item' => @join },
          @bg_color,
          @border_color,
          @padding,
          @system_arguments[:class]
        )
      end

      def render_input
        input_type = if @radio
                       'radio'
                     elsif @plus
                       'checkbox'
                     else
                       'checkbox'
                     end
        tag.input(type: input_type, name: @name, checked: @checked, class: "collapse-#{input_type}")
      end

      def render_title
        tag.div(class: class_names('collapse-title font-semibold', @text_color)) do
          @title
        end
      end

      def render_content
        tag.div(class: class_names('collapse-content text-sm', @text_color)) { content }
      end
    end
  end
end
