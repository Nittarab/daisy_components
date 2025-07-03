# frozen_string_literal: true

module DaisyUI
  # Stat component for displaying numbers and data in a contained block format
  #
  # @example Basic usage
  #   <%= render(DaisyUI::Stat.new(
  #     title: "Total Page Views",
  #     value: "89,400",
  #     description: "21% more than last month"
  #   )) %>
  #
  # @example Multiple stats horizontal
  #   <%= render(DaisyUI::Stat.new(shadow: true)) do |component| %>
  #     <% component.with_stat(title: "Total Likes", value: "25.6K", description: "21% more than last month") %>
  #     <% component.with_stat(title: "Page Views", value: "2.6M", description: "21% more than last month") %>
  #   <% end %>
  #
  # @example With figure/icon
  #   <%= render(DaisyUI::Stat.new) do |component| %>
  #     <% component.with_stat do |stat| %>
  #       <% stat.with_figure { helpers.heart_icon(class: "h-8 w-8 text-primary") } %>
  #       <% stat.with_title { "Total Likes" } %>
  #       <% stat.with_value(color: :primary) { "25.6K" } %>
  #       <% stat.with_description { "21% more than last month" } %>
  #     <% end %>
  #   <% end %>
  #
  # @example Vertical layout
  #   <%= render(DaisyUI::Stat.new(direction: :vertical, shadow: true)) do |component| %>
  #     <% component.with_stat(title: "Downloads", value: "31K", description: "Jan 1st - Feb 1st") %>
  #     <% component.with_stat(title: "New Users", value: "4,200", description: "↗︎ 400 (22%)") %>
  #   <% end %>
  #
  # @example Centered items
  #   <%= render(DaisyUI::Stat.new(shadow: true)) do |component| %>
  #     <% component.with_stat(title: "Downloads", value: "31K", description: "From January 1st to February 1st", centered: true) %>
  #     <% component.with_stat(title: "Users", value: "4,200", description: "↗︎ 40 (2%)", centered: true) %>
  #   <% end %>
  #
  # @example With actions
  #   <%= render(DaisyUI::Stat.new) do |component| %>
  #     <% component.with_stat do |stat| %>
  #       <% stat.with_title { "Account balance" } %>
  #       <% stat.with_value { "$89,400" } %>
  #       <% stat.with_actions do %>
  #         <%= render(DaisyUI::Button.new(text: "Add funds", size: :xs, color: :success)) %>
  #       <% end %>
  #     <% end %>
  #   <% end %>
  #
  # @example Responsive layout
  #   <%= render(DaisyUI::Stat.new(direction: :responsive, shadow: true)) do |component| %>
  #     <% component.with_stat(title: "Downloads", value: "31K", description: "Jan 1st - Feb 1st") %>
  #     <% component.with_stat(title: "New Users", value: "4,200", description: "↗︎ 400 (22%)") %>
  #   <% end %>
  class Stat < BaseComponent
    # Available stat directions
    DIRECTIONS = {
      horizontal: 'stats-horizontal',
      vertical: 'stats-vertical',
      responsive: 'stats-vertical lg:stats-horizontal'
    }.freeze

    renders_many :stats, lambda { |title: nil, value: nil, description: nil, centered: false,
                                    **system_arguments|
      StatItem.new(
        title: title,
        value: value,
        description: description,
        centered: centered,
        **system_arguments
      )
    }

    # @param direction [Symbol] Layout direction (:horizontal, :vertical, :responsive)
    # @param shadow [Boolean] Adds shadow to the stats container
    # @param title [String] Single stat title (for simple usage)
    # @param value [String] Single stat value (for simple usage)
    # @param description [String] Single stat description (for simple usage)
    # @param centered [Boolean] Center align stat items (for simple usage)
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(direction: :horizontal,
                   shadow: false,
                   title: nil,
                   value: nil,
                   description: nil,
                   centered: false,
                   **system_arguments)
      @direction = build_argument(direction, DIRECTIONS, 'direction')
      @shadow = shadow
      @title = title
      @value = value
      @description = description
      @centered = centered
      super(**system_arguments)
    end

    def before_render
      # If simple usage with title/value provided, create a single stat
      if @title || @value
        with_stat(title: @title, value: @value, description: @description, centered: @centered)
      end
    end

    def call
      tag.div(**html_attributes) do
        stats.any? ? safe_join(stats) : content
      end
    end

    private

    def computed_classes
      modifiers = %w[stats]
      modifiers << @direction if @direction.present?
      modifiers << 'shadow' if @shadow
      class_names(modifiers, system_arguments[:class])
    end

    def html_attributes
      system_arguments.merge(class: computed_classes)
    end
  end
end