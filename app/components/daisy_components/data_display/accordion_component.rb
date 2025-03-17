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
    #     <% component.with_item(title: "Item 2") do %>
    #       Content for item 2
    #     <% end %>
    #   <% end %>
    #
    # @example With arrow indicator
    #   <%= render(AccordionComponent.new(indicator: :arrow)) do |component| %>
    #     <% component.with_item(title: "Item 1") do %>
    #       Content for item 1
    #     <% end %>
    #   <% end %>
    #
    # @example With plus/minus indicator
    #   <%= render(AccordionComponent.new(indicator: :plus)) do |component| %>
    #     <% component.with_item(title: "Item 1") do %>
    #       Content for item 1
    #     <% end %>
    #   <% end %>
    #
    # @example Radio group behavior
    #   <%= render(AccordionComponent.new(input_type: :radio)) do |component| %>
    #     <% component.with_item(title: "Item 1", checked: true) do %>
    #       Content for item 1
    #     <% end %>
    #     <% component.with_item(title: "Item 2") do %>
    #       Content for item 2
    #     <% end %>
    #   <% end %>
    #
    # @example Joined items without gaps
    #   <%= render(AccordionComponent.new(join: true)) do |component| %>
    #     <% component.with_item(title: "Item 1") do %>
    #       Content for item 1
    #     <% end %>
    #     <% component.with_item(title: "Item 2") do %>
    #       Content for item 2
    #     <% end %>
    #   <% end %>
    #
    # @example Custom colors
    #   <%= render(AccordionComponent.new(
    #     bg_color: "bg-primary",
    #     text_color: "text-primary-content",
    #     border_color: "border-primary-focus"
    #   )) do |component| %>
    #     <% component.with_item(title: "Item 1") do %>
    #       Content for item 1
    #     <% end %>
    #   <% end %>
    class AccordionComponent < BaseComponent
      INDICATORS = %i[arrow plus].freeze
      INPUT_TYPES = %i[radio checkbox].freeze

      renders_many :items, lambda { |title:, name: nil, checked: false|
        AccordionItemComponent.new(
          title:,
          name: name || @input_name,
          checked:,
          indicator: @indicator,
          input_type: @input_type,
          join: @join,
          bg_color: @join ? nil : @bg_color,
          text_color: @text_color,
          border_color: @border_color,
          padding: @padding,
          **@system_arguments
        )
      }

      attr_reader :join, :indicator, :input_type, :bg_color, :text_color, :border_color, :padding

      # @param join [Boolean] Join items together without gaps
      # @param indicator [Symbol] Type of indicator to show (:arrow, :plus)
      # @param input_type [Symbol] Type of input to use (:radio, :checkbox)
      # @param bg_color [String] Background color class
      # @param text_color [String] Text color class
      # @param border_color [String] Border color class
      # @param padding [String] Padding class
      # @param name [String, nil] Name for radio/checkbox inputs (auto-generated if nil)
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(join: false, indicator: nil, input_type: :checkbox,
                     bg_color: nil, text_color: nil, border_color: nil,
                     padding: nil, name: nil, **system_arguments)
        @join = join
        @indicator = indicator
        @input_type = input_type
        @bg_color = bg_color || 'bg-base-100'
        @text_color = text_color
        @border_color = border_color || 'border border-base-300'
        @padding = padding
        @input_name = name || "accordion-#{SecureRandom.uuid}"
        super(**system_arguments)
      end

      def call
        return safe_join(items || []) unless @join

        tag.div(**html_attributes) do
          safe_join(items || [])
        end
      end

      private

      def html_attributes
        system_arguments.merge(
          class: computed_classes
        )
      end

      def computed_classes
        modifiers = ['join join-vertical']
        modifiers << @bg_color if @bg_color

        class_names(modifiers, system_arguments[:class])
      end
    end
  end
end
