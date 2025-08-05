# frozen_string_literal: true

module DaisyUI
  # Loading component implementing DaisyUI's loading styles
  #
  # @example Basic usage
  #   <%= render(DaisyUI::Loading.new) %>
  #
  # @example Spinner type
  #   <%= render(DaisyUI::Loading.new(type: :spinner)) %>
  #
  # @example Different sizes
  #   <%= render(DaisyUI::Loading.new(size: :lg)) %>
  #
  # @example With color
  #   <%= render(DaisyUI::Loading.new(color: :primary)) %>
  #
  # @example With text
  #   <%= render(DaisyUI::Loading.new(text: "Loading...")) %>
  #
  # @example Dots type with custom color
  #   <%= render(DaisyUI::Loading.new(
  #     type: :dots,
  #     color: :accent,
  #     size: :md
  #   )) %>
  class Loading < DaisyUI::BaseComponent
    # Available loading types from DaisyUI
    TYPES = {
      spinner: 'loading-spinner',
      dots: 'loading-dots',
      ring: 'loading-ring',
      ball: 'loading-ball',
      bars: 'loading-bars',
      infinity: 'loading-infinity'
    }.freeze

    # Available loading sizes from DaisyUI
    SIZES = {
      xs: 'loading-xs',
      sm: 'loading-sm',
      md: 'loading-md',
      lg: 'loading-lg'
    }.freeze

    # Available loading colors from DaisyUI
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

    # @param type [Symbol] Type of loading animation (spinner/dots/ring/ball/bars/infinity)
    # @param size [Symbol] Size of the loading animation (xs/sm/md/lg)
    # @param color [Symbol] Color of the loading animation (primary/secondary/accent/neutral/info/success/warning/error)
    # @param text [String] Optional text to display below the loading animation
    # @param system_arguments [Hash] Additional HTML attributes to be applied to the loading element
    def initialize(
      type: :spinner,
      size: nil,
      color: nil,
      text: nil,
      **system_arguments
    )
      @type = build_argument(type, TYPES, 'type')
      @size = build_argument(size, SIZES, 'size')
      @color = build_argument(color, COLORS, 'color')
      @text = text

      super(**system_arguments)
    end

    def call
      if @text.present?
        tag.div(class: 'flex flex-col items-center gap-2') do
          safe_join([
            tag.span(class: computed_classes),
            tag.span(@text, class: 'text-sm')
          ])
        end
      else
        tag.span(class: computed_classes)
      end
    end

    delegate :to_s, to: :call

    private

    def computed_classes
      modifiers = ['loading']
      modifiers << @type
      modifiers << @size
      modifiers << @color

      class_names(modifiers, system_arguments[:class])
    end
  end
end