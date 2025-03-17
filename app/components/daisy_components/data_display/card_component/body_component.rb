# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class CardComponent
      # Body component for the card, containing title, description and actions
      #
      # @example Basic usage
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_body do |body| %>
      #       <% body.with_title { "Title" } %>
      #       <% body.with_description { "Description" } %>
      #     <% end %>
      #   <% end %>
      #
      # @example With simple button
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_body(
      #       title: "Title",
      #       description: "Description",
      #       button: { text: "Action", color: :primary, justify: :end }
      #     ) %>
      #   <% end %>
      #
      # @example With multiple buttons
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_body do |body| %>
      #       <% body.with_title { "Title" } %>
      #       <% body.with_actions(justify: :between) do |actions| %>
      #         <% actions.with_button(text: "Cancel", variant: :ghost) %>
      #         <% actions.with_bage(text: "Submit", color: :primary) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      class BodyComponent < BaseComponent
        # Title is a component slot that renders TitleComponent
        renders_one :title, DaisyComponents::DataDisplay::CardComponent::TitleComponent

        # Actions is a component slot that renders ActionsComponent
        renders_one :actions, DaisyComponents::DataDisplay::CardComponent::ActionsComponent

        # Description is a content slot that can contain any content
        renders_one :description

        # @param variant [Symbol] Card variant affecting body layout
        # @param description [String] Card description text
        # @param title [String] Card title text
        # @param button [Hash] Simple button configuration
        # @option button [String] :text Button text
        # @option button [Symbol] :color Button color
        # @option button [Symbol] :variant Button variant
        # @option button [Symbol] :size Button size
        # @option button [Symbol] :justify Button justification
        # @param system_arguments [Hash] Additional HTML attributes
        def initialize(variant: nil,
                       description: nil,
                       title: nil,
                       button: nil,
                       **system_arguments)
          @variant = variant
          @description = description
          @title = title
          @button = button
          super(**system_arguments)
        end

        def call
          tag.div(**html_attributes) do
            safe_join([
              title,
              render_description,
              actions
            ].compact)
          end
        end

        def before_render
          with_title(@title) if @title && !title?
          with_description { tag.p(@description) } if @description && !description?
          setup_button if @button && !actions?
        end

        private

        def render_description
          return description if description?

          tag.p(@description) if @description
        end

        def setup_button
          button_config = @button.symbolize_keys
          justify = button_config.delete(:justify)

          with_actions(justify: justify) do |actions|
            actions.with_button(**button_config)
          end
        end

        def computed_classes
          modifiers = %w[card-body]
          modifiers << 'flex flex-col justify-between' if @variant == :side

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
