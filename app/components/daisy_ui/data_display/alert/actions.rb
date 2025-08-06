# frozen_string_literal: true

module DaisyUI
  class Alert
    # Actions component for the alert, handling action buttons layout
    #
    # @example Basic usage
    #   <%= render(DaisyUI::Alert.new) do |component| %>
    #     <% component.with_actions do %>
    #       <%= render(DaisyUI::Button.new(text: "Action")) %>
    #     <% end %>
    #   <% end %>
    #
    # @example With multiple buttons
    #   <%= render(DaisyUI::Alert.new) do |component| %>
    #     <% component.with_actions(justify: :end) do |actions| %>
    #       <% actions.with_button(text: "Cancel", variant: :ghost) %>
    #       <% actions.with_button(text: "Accept", color: :primary) %>
    #     <% end %>
    #   <% end %>
    #
    # @example With custom buttons
    #   <%= render(DaisyUI::Alert.new) do |component| %>
    #     <% component.with_actions(justify: :center) do %>
    #       <%= render(DaisyUI::Button.new(text: "Dismiss", size: :sm)) %>
    #     <% end %>
    #   <% end %>
    class Actions < BaseComponent
      # Available justification options for actions layout
      JUSTIFY_OPTIONS = {
        start: 'justify-start',
        end: 'justify-end',
        center: 'justify-center',
        between: 'justify-between',
        around: 'justify-around',
        evenly: 'justify-evenly'
      }.freeze

      # Renders multiple actions (buttons or badges)
      renders_many :actions, types: {
        button: { renders: DaisyUI::Button, as: :button },
        badge: { renders: DaisyUI::Badge, as: :badge }
      }

      # @param justify [Symbol] Justification for action buttons layout
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(justify: nil, **system_arguments)
        @justify = build_justify(justify)
        super(**system_arguments)
      end

      def call
        tag.div(**html_attributes) do
          if actions.any?
            safe_join(actions)
          else
            content
          end
        end
      end

      private

      def build_justify(key)
        return nil unless key

        class_name = JUSTIFY_OPTIONS[key.to_sym]
        return class_name if class_name

        raise ArgumentError, "Invalid justify: #{key}. Must be one of: #{JUSTIFY_OPTIONS.keys.join(', ')}"
      end

      def computed_classes
        modifiers = []
        modifiers << @justify if @justify

        class_names(modifiers, system_arguments[:class])
      end

      def html_attributes
        system_arguments.merge(
          class: computed_classes
        )
      end
    end
  end
end