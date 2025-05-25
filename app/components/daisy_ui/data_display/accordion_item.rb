# frozen_string_literal: true

module DaisyUI
  # Renders a single accordion item within an AccordionComponent.
  #
  # @example Basic usage
  #   <%= render(AccordionItemComponent.new(title: "Item 1")) do %>
  #     Content for item 1
  #   <% end %>
  #
  # @example With arrow indicator
  #   <%= render(AccordionItemComponent.new(
  #     title: "Item 1",
  #     indicator: :arrow
  #   )) do %>
  #     Content for item 1
  #   <% end %>
  #
  # @example With plus/minus indicator
  #   <%= render(AccordionItemComponent.new(
  #     title: "Item 1",
  #     indicator: :plus
  #   )) do %>
  #     Content for item 1
  #   <% end %>
  #
  # @example As part of a radio group
  #   <%= render(AccordionItemComponent.new(
  #     title: "Item 1",
  #     input_type: :radio,
  #     name: "group1",
  #     checked: true
  #   )) do %>
  #     Content for item 1
  #   <% end %>
  #
  # @example With custom colors
  #   <%= render(AccordionItemComponent.new(
  #     title: "Item 1",
  #     bg_color: "bg-primary",
  #     text_color: "text-primary-content",
  #     border_color: "border-primary-focus"
  #   )) do %>
  #     Content for item 1
  #   <% end %>
  class AccordionItem < BaseComponent
    INDICATORS = %i[arrow plus].freeze
    INPUT_TYPES = %i[radio checkbox].freeze

    # @param title [String] The title text for the accordion item
    # @param name [String] Input name for radio/checkbox behavior
    # @param indicator [Symbol] Type of indicator to show (:arrow, :plus)
    # @param input_type [Symbol] Type of input to use (:radio, :checkbox)
    # @param checked [Boolean] Whether the item is initially expanded
    # @param join [Boolean] Style for joined items
    # @param bg_color [String] Background color class
    # @param text_color [String] Text color class
    # @param border_color [String] Border color class
    # @param padding [String] Padding class
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(title:, name:, text: nil, checked: false, indicator: nil,
                   input_type: :checkbox, join: false, bg_color: nil, text_color: nil,
                   border_color: nil, padding: nil, **system_arguments)
      @title = title
      @name = name
      @text = text
      @checked = checked
      @indicator = indicator
      @input_type = input_type
      @join = join
      @bg_color = bg_color
      @text_color = text_color
      @border_color = border_color
      @padding = padding
      super(**system_arguments)
    end

    def call
      tag.div(**html_attributes) do
        safe_join([render_input, render_title, render_content].compact)
      end
    end

    private

    def html_attributes
      system_arguments.merge(
        class: computed_classes
      )
    end

    def computed_classes
      modifiers = ['collapse']
      modifiers << "collapse-#{@indicator}" if @indicator
      modifiers << 'join-item' if @join
      modifiers << @bg_color if @bg_color
      modifiers << @border_color if @border_color
      modifiers << @padding if @padding

      class_names(modifiers, system_arguments[:class])
    end

    def render_input
      tag.input(
        type: @input_type,
        name: @name,
        checked: @checked
      )
    end

    def render_title
      tag.div(class: class_names('collapse-title font-semibold', @text_color)) do
        @title
      end
    end

    def render_content
      tag.div(class: class_names('collapse-content text-sm', @text_color)) { content || @text }
    end
  end
end
