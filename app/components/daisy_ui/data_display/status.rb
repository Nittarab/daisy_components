# frozen_string_literal: true

module DaisyUI
  # Status component implementing DaisyUI's status indicator styles
  #
  # @example Basic usage
  #   <%= render(StatusComponent.new) %>
  #
  # @example Success status (online)
  #   <%= render(StatusComponent.new(color: :success)) %>
  #
  # @example Error status (offline)
  #   <%= render(StatusComponent.new(color: :error)) %>
  #
  # @example Primary variant
  #   <%= render(StatusComponent.new(color: :primary)) %>
  #
  # @example Large size
  #   <%= render(StatusComponent.new(size: :lg, color: :success)) %>
  #
  # @example Small size
  #   <%= render(StatusComponent.new(size: :sm, color: :warning)) %>
  #
  # @example Custom tag type
  #   <%= render(StatusComponent.new(color: :info, tag_type: :span)) %>
  class Status < DaisyUI::BaseComponent
    # Available status colors from DaisyUI
    COLORS = {
      primary: 'status-primary',
      secondary: 'status-secondary',
      accent: 'status-accent',
      neutral: 'status-neutral',
      info: 'status-info',
      success: 'status-success',
      warning: 'status-warning',
      error: 'status-error'
    }.freeze

    # Available status sizes from DaisyUI
    SIZES = {
      xl: 'status-xl',
      lg: 'status-lg',
      md: 'status-md',
      sm: 'status-sm',
      xs: 'status-xs'
    }.freeze

    # @param color [String] Visual style of the status indicator
    #    (neutral/primary/secondary/accent/info/success/warning/error)
    # @param size [String] Size of the status indicator (xl/lg/md/sm/xs)
    # @param tag_type [Symbol] HTML tag to use for the status indicator (default: :div)
    # @param system_arguments [Hash] Additional HTML attributes to be applied to the status indicator
    def initialize(
      color: nil,
      size: nil,
      tag_type: :div,
      **system_arguments
    )
      @color = build_argument(color, COLORS, 'color')
      @size = build_argument(size, SIZES, 'size')
      @tag_type = tag_type

      super(**system_arguments)
    end

    def call
      tag.public_send(@tag_type, **html_attributes) do
        content if content?
      end
    end

    delegate :to_s, to: :call

    private

    def computed_classes
      modifiers = ['status']
      modifiers << @color
      modifiers << @size

      class_names(modifiers, system_arguments[:class])
    end

    def html_attributes
      attrs = system_arguments.except(:class)
      attrs[:class] = computed_classes
      attrs
    end
  end
end