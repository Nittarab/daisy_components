# frozen_string_literal: true

module DaisyUI
  class Stat
    # Stat value component with color support
    #
    # @example Basic usage
    #   <%= render(DaisyUI::Stat.new) do |component| %>
    #     <% component.with_stat do |stat| %>
    #       <% stat.with_value { "89,400" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With color
    #   <%= render(DaisyUI::Stat.new) do |component| %>
    #     <% component.with_stat do |stat| %>
    #       <% stat.with_value(color: :primary) { "25.6K" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example With secondary color
    #   <%= render(DaisyUI::Stat.new) do |component| %>
    #     <% component.with_stat do |stat| %>
    #       <% stat.with_value(color: :secondary) { "2.6M" } %>
    #     <% end %>
    #   <% end %>
    class StatValue < BaseComponent
      # Available colors for stat values
      COLORS = {
        primary: 'text-primary',
        secondary: 'text-secondary',
        accent: 'text-accent',
        neutral: 'text-neutral',
        info: 'text-info',
        success: 'text-success',
        warning: 'text-warning',
        error: 'text-error'
      }.freeze

      # @param color [Symbol] Color variant for the value (:primary, :secondary, :accent, :neutral, :info, :success, :warning, :error)
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(color: nil, **system_arguments)
        @color = build_argument(color, COLORS, 'color')
        super(**system_arguments)
      end

      def call
        tag.div(content, **html_attributes)
      end

      private

      def computed_classes
        modifiers = %w[stat-value]
        modifiers << @color if @color.present?
        class_names(modifiers, system_arguments[:class])
      end

      def html_attributes
        system_arguments.merge(class: computed_classes)
      end
    end
  end
end