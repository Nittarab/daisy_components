# frozen_string_literal: true

module DaisyUI
  # Tooltip component implementing DaisyUI's tooltip styles
  #
  # @example Basic usage
  #   <%= render(DaisyUI::Tooltip.new(tip: "Hello world")) do %>
  #     <button class="btn">Hover me</button>
  #   <% end %>
  #
  # @example With position
  #   <%= render(DaisyUI::Tooltip.new(position: :top, tip: "Top tooltip")) do %>
  #     <button class="btn">Top</button>
  #   <% end %>
  #
  # @example With color
  #   <%= render(DaisyUI::Tooltip.new(color: :primary, tip: "Primary tooltip")) do %>
  #     <button class="btn btn-primary">Primary</button>
  #   <% end %>
  #
  # @example Force open (for demos)
  #   <%= render(DaisyUI::Tooltip.new(tip: "Always visible", force_open: true)) do %>
  #     <button class="btn">Always shows tooltip</button>
  #   <% end %>
  #
  # @example Responsive (only show on large screens)
  #   <%= render(DaisyUI::Tooltip.new(tip: "Large screen only", responsive: "lg")) do %>
  #     <button class="btn">Large screen tooltip</button>
  #   <% end %>
  class Tooltip < BaseComponent
    # Available tooltip positions from DaisyUI
    POSITIONS = {
      top: 'tooltip-top',
      bottom: 'tooltip-bottom',
      left: 'tooltip-left',
      right: 'tooltip-right'
    }.freeze

    # Available tooltip colors from DaisyUI
    COLORS = {
      primary: 'tooltip-primary',
      secondary: 'tooltip-secondary',
      accent: 'tooltip-accent',
      neutral: 'tooltip-neutral',
      info: 'tooltip-info',
      success: 'tooltip-success',
      warning: 'tooltip-warning',
      error: 'tooltip-error'
    }.freeze

    # Available responsive breakpoints for conditional display
    RESPONSIVE = {
      sm: 'sm:tooltip',
      md: 'md:tooltip', 
      lg: 'lg:tooltip',
      xl: 'xl:tooltip'
    }.freeze

    # @param tip [String] The text content to display in the tooltip
    # @param position [String] Position of the tooltip (top/bottom/left/right)
    # @param color [String] Color theme of the tooltip (primary/secondary/accent/neutral/info/success/warning/error)
    # @param force_open [Boolean] When true, forces the tooltip to be visible (useful for demos)
    # @param responsive [String] Only show tooltip on specified screen size and up (sm/md/lg/xl)
    # @param system_arguments [Hash] Additional HTML attributes to be applied to the tooltip wrapper
    def initialize(
      tip:,
      position: nil,
      color: nil,
      force_open: false,
      responsive: nil,
      **system_arguments
    )
      @tip = tip
      @position = build_argument(position, POSITIONS, 'position')
      @color = build_argument(color, COLORS, 'color')
      @responsive = build_argument(responsive, RESPONSIVE, 'responsive')
      @force_open = force_open

      super(**system_arguments)
    end

    def call
      tag.div(class: computed_classes, **system_arguments.except(:class), 'data-tip': @tip) do
        content
      end
    end

    private

    def computed_classes
      if @responsive
        # For responsive tooltips, replace base 'tooltip' with responsive version
        modifiers = [@responsive]
        modifiers << 'tooltip-open' if @force_open
        modifiers << @position
        modifiers << @color
      else
        modifiers = ['tooltip']
        modifiers << 'tooltip-open' if @force_open
        modifiers << @position
        modifiers << @color
      end

      class_names(modifiers, system_arguments[:class])
    end
  end
end