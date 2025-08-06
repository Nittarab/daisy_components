# frozen_string_literal: true

module DaisyUI
  # Tooltip component implementing DaisyUI's tooltip styles
  #
  # @example Basic usage with text (new simplified API)
  #   <%= render(DaisyUI::Tooltip.new(tip: "Hello world", text: "Hover me")) %>
  #
  # @example With position and color
  #   <%= render(DaisyUI::Tooltip.new(position: :top, color: :primary, tip: "Primary tooltip", text: "Top", button_color: :primary)) %>
  #
  # @example Force open for demos  
  #   <%= render(DaisyUI::Tooltip.new(tip: "Always visible", text: "Demo", force_open: true)) %>
  #
  # @example Responsive (only show on large screens)
  #   <%= render(DaisyUI::Tooltip.new(tip: "Large screen only", text: "Large screen tooltip", responsive: "lg")) %>
  #
  # @example With custom content (traditional API)
  #   <%= render(DaisyUI::Tooltip.new(tip: "Hello world")) do %>
  #     <button class="btn">Hover me</button>
  #   <% end %>
  #
  # @example Button customization
  #   <%= render(DaisyUI::Tooltip.new(
  #     tip: "Custom button", 
  #     text: "Click me",
  #     button_color: :primary,
  #     button_size: :lg,
  #     button_variant: :outline
  #   )) %>
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
    # @param text [String] If provided, automatically creates a button with this text (optional)
    # @param position [String] Position of the tooltip (top/bottom/left/right)
    # @param color [String] Color theme of the tooltip (primary/secondary/accent/neutral/info/success/warning/error)
    # @param force_open [Boolean] When true, forces the tooltip to be visible (useful for demos)
    # @param responsive [String] Only show tooltip on specified screen size and up (sm/md/lg/xl)
    # Button customization options (only used when text: is provided):
    # @param button_color [String] Color of the auto-generated button
    # @param button_size [String] Size of the auto-generated button  
    # @param button_variant [String] Variant of the auto-generated button
    # @param button_shape [String] Shape of the auto-generated button
    # @param system_arguments [Hash] Additional HTML attributes to be applied to the tooltip wrapper
    def initialize(
      tip:,
      text: nil,
      position: nil,
      color: nil,
      force_open: false,
      responsive: nil,
      button_color: nil,
      button_size: nil,
      button_variant: nil,
      button_shape: nil,
      **system_arguments
    )
      @tip = tip
      @text = text
      @position = build_argument(position, POSITIONS, 'position')
      @color = build_argument(color, COLORS, 'color')
      @responsive = build_argument(responsive, RESPONSIVE, 'responsive')
      @force_open = force_open
      
      # Button customization options
      @button_color = button_color
      @button_size = button_size
      @button_variant = button_variant
      @button_shape = button_shape

      super(**system_arguments)
    end

    def call
      tag.div(class: computed_classes, **system_arguments.except(:class), 'data-tip': @tip) do
        tooltip_content
      end
    end

    private
    
    def tooltip_content
      if @text
        # Auto-generate button when text is provided
        DaisyUI::Button.new(
          text: @text,
          color: @button_color,
          size: @button_size,
          variant: @button_variant,
          shape: @button_shape
        ).render_in(view_context)
      else
        # Use provided block content
        content
      end
    end

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