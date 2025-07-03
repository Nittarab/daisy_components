# frozen_string_literal: true

module DaisyUI
  class Stat
    # Individual stat item component
    #
    # @example Basic usage
    #   <%= render(DaisyUI::Stat.new) do |component| %>
    #     <% component.with_stat(title: "Total Views", value: "89,400", description: "21% more than last month") %>
    #   <% end %>
    #
    # @example With figure and actions
    #   <%= render(DaisyUI::Stat.new) do |component| %>
    #     <% component.with_stat do |stat| %>
    #       <% stat.with_figure { icon_html } %>
    #       <% stat.with_title { "Account balance" } %>
    #       <% stat.with_value(color: :primary) { "$89,400" } %>
    #       <% stat.with_actions { button_html } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Centered alignment
    #   <%= render(DaisyUI::Stat.new) do |component| %>
    #     <% component.with_stat(title: "Downloads", value: "31K", centered: true) %>
    #   <% end %>
    class StatItem < BaseComponent
      renders_one :figure
      renders_one :title
      renders_one :value, lambda { |color: nil, **system_arguments|
        Stat::StatValue.new(color: color, **system_arguments)
      }
      renders_one :description
      renders_one :actions

      # @param title [String] Stat title text
      # @param value [String] Stat value text
      # @param description [String] Stat description text
      # @param centered [Boolean] Center align the stat content
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(title: nil,
                     value: nil,
                     description: nil,
                     centered: false,
                     **system_arguments)
        @title = title
        @value = value
        @description = description
        @centered = centered
        super(**system_arguments)
      end

      def before_render
        with_title { @title } if @title && !title?
        with_value { @value } if @value && !value?
        with_description { @description } if @description && !description?
      end

      def call
        tag.div(**html_attributes) do
          safe_join([
            figure ? tag.div(figure, class: 'stat-figure') : nil,
            title ? tag.div(title, class: 'stat-title') : nil,
            value,
            description ? tag.div(description, class: 'stat-desc') : nil,
            actions ? tag.div(actions, class: 'stat-actions') : nil
          ].compact)
        end
      end

      private

      def computed_classes
        modifiers = %w[stat]
        modifiers << 'place-items-center' if @centered
        class_names(modifiers, system_arguments[:class])
      end

      def html_attributes
        system_arguments.merge(class: computed_classes)
      end
    end
  end
end