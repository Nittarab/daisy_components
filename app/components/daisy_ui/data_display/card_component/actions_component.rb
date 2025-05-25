# frozen_string_literal: true

module DaisyUI
  module DataDisplay
    class CardComponent
      # Actions component for the card, handling action buttons layout
      #
      # @example Basic usage
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_body do |body| %>
      #       <% body.with_actions do %>
      #         <%= render(ButtonComponent.new(text: "Action")) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example With multiple buttons
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_body do |body| %>
      #       <% body.with_actions(justify: :between) do |actions| %>
      #         <% actions.with_button(text: "Cancel", variant: :ghost) %>
      #         <% actions.with_button(text: "Submit", color: :primary) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example With custom buttons
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_body do |body| %>
      #       <% body.with_actions(justify: :end) do %>
      #         <%= render(ButtonComponent.new(text: "Delete", color: :error)) %>
      #         <%= render(ButtonComponent.new(text: "Save", color: :primary)) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      class ActionsComponent < BaseComponent
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
          button: { renders: DaisyUI::Actions::ButtonComponent, as: :button },
          badge: { renders: DaisyUI::DataDisplay::BadgeComponent, as: :badge }
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
          modifiers = ['card-actions']
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
end
