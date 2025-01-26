# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # Accordion component implementing DaisyUI's accordion styles
    #
    # @example Basic usage
    #   <%= render(AccordionComponent.new) do |component|
    #     component.with_item(title: "Click me") { "Hidden content" }
    #   end %>
    #
    # @example With custom styling
    #   <%= render(AccordionComponent.new(
    #     join: true,
    #     arrow: true,
    #     bg_color: "bg-primary",
    #     text_color: "text-primary-content",
    #     border_color: "border-primary",
    #     padding: "p-2"
    #   )) do |component|
    #     component.with_item(title: "Item 1") { "Content 1" }
    #     component.with_item(title: "Item 2") { "Content 2" }
    #   end %>
    class AccordionComponent < DaisyComponents::BaseComponent
      renders_many :items, lambda { |**options, &block|
        AccordionItemComponent.new(
          parent: self,
          title: options[:title],
          name: options[:name],
          checked: options[:checked],
          &block
        )
      }

      attr_reader :join, :arrow, :plus, :radio, :bg_color, :text_color, :border_color, :padding

      def initialize(join: false, arrow: false, plus: false, radio: false,
                     bg_color: nil, text_color: nil, border_color: nil, padding: nil,
                     **system_arguments)
        @join = join
        @arrow = arrow
        @plus = plus
        @radio = radio
        @bg_color = bg_color
        @text_color = text_color
        @border_color = border_color
        @padding = padding

        super(**system_arguments)
      end

      def default_classes
        class_names(
          'w-full', # Always full width
          system_arguments[:class],
          join ? 'join join-vertical' : 'space-y-2',
          bg_color,
          text_color,
          border_color,
          padding
        )
      end

      def call
        tag.div(**html_attributes) { safe_join(items || []) }
      end

      private

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
