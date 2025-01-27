# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # Renders an accordion component that allows users to show and hide content sections.
    #
    # @example Basic usage
    #   <%= render(AccordionComponent.new) do |component| %>
    #     <% component.with_item(title: "Item 1") do %>
    #       Content for item 1
    #     <% end %>
    #   <% end %>
    #
    # @example With arrow indicator
    #   <%= render(AccordionComponent.new(arrow: true)) do |component| %>
    #     <% component.with_item(title: "Item 1") do %>
    #       Content for item 1
    #     <% end %>
    #   <% end %>
    class AccordionComponent < ViewComponent::Base
      renders_many :items, lambda { |title:, name: nil, checked: false|
        AccordionItemComponent.new(
          parent: self,
          title:,
          name:,
          checked:,
          arrow: @arrow,
          plus: @plus,
          radio: @radio,
          join: @join,
          bg_color: @bg_color,
          text_color: @text_color,
          border_color: @border_color,
          padding: @padding,
          **@system_arguments
        )
      }

      attr_reader :join, :arrow, :plus, :radio, :bg_color, :text_color, :border_color, :padding

      # @param join [Boolean] Join items together without gaps
      # @param arrow [Boolean] Show arrow indicator
      # @param plus [Boolean] Show plus/minus indicator
      # @param radio [Boolean] Use radio buttons for exclusive selection
      # @param bg_color [String] Background color class
      # @param text_color [String] Text color class
      # @param border_color [String] Border color class
      # @param padding [String] Padding class
      def initialize(join: false, arrow: false, plus: false, radio: false, bg_color: nil, text_color: nil,
                     border_color: nil, padding: nil, **system_arguments)
        super()
        @join = join
        @arrow = arrow
        @plus = plus
        @radio = radio
        @bg_color = bg_color
        @text_color = text_color
        @border_color = border_color
        @padding = padding
        @system_arguments = system_arguments
      end

      def call
        tag.div(**html_attributes) do
          helpers.safe_join(items || [])
        end
      end

      private

      def html_attributes
        @system_arguments.merge(
          class: class_names(
            { 'join join-vertical' => @join },
            { 'flex flex-col gap-2' => !@join },
            @system_arguments[:class]
          )
        )
      end

      # @private
      class AccordionItemComponent < ViewComponent::Base
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::OutputSafetyHelper
        attr_reader :parent

        def initialize(parent:, title:, name: nil, checked: false, arrow: false, plus: false, radio: false, join: false,
                       bg_color: nil, text_color: nil, border_color: nil, padding: nil, **system_arguments)
          super()
          @parent = parent
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
          @system_arguments.merge(
            class: class_names(
              'collapse',
              { 'collapse-arrow' => @arrow && !@plus },
              { 'collapse-plus' => @plus },
              { 'join-item' => @join },
              @bg_color,
              @border_color,
              @padding,
              @system_arguments[:class]
            )
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
            @padding
          )
        end

        def render_input
          return unless @radio || @plus

          input_type = @radio ? 'radio' : 'checkbox'
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
end
