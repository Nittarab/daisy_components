# frozen_string_literal: true

module DaisyUI
  # Swap component implementing DaisyUI's swap styles
  #
  # @example Basic usage
  #   <%= render(SwapComponent.new(
  #     states: { on: 'ON', off: 'OFF' }
  #   )) %>
  #
  # @example Theme toggle with icons
  #   <%= render(SwapComponent.new(
  #     states: {
  #       on: helpers.sun_icon(class: 'h-6 w-6'),
  #       off: helpers.moon_icon(class: 'h-6 w-6')
  #     },
  #     button: true,
  #     effect: :rotate
  #   )) %>
  class Swap < DaisyUI::BaseComponent
    # Available variants from DaisyUI
    VARIANTS = {
      primary: 'text-primary',
      secondary: 'text-secondary',
      accent: 'text-accent',
      info: 'text-info',
      success: 'text-success',
      warning: 'text-warning',
      error: 'text-error',
      ghost: 'text-base-content',
      neutral: 'text-neutral'
    }.freeze

    # Available sizes
    SIZES = {
      xs: 'text-xs',
      sm: 'text-sm',
      md: 'text-base',
      lg: 'text-lg'
    }.freeze

    # Available effects
    EFFECTS = {
      rotate: 'swap-rotate',
      flip: 'swap-flip',
      flip_active: 'swap-flip-active'
    }.freeze

    # @param states [Hash] Required hash with :on and :off states content
    # @param value [Boolean] Initial state of the swap
    # @param variant [Symbol] Color variant (primary/secondary/accent/etc)
    # @param size [Symbol] Size variant (xs/sm/md/lg)
    # @param effect [Symbol] Animation effect (rotate/flip/flip-active)
    # @param active [Boolean] When true, gives the swap an active appearance
    # @param button [Boolean] When true, renders as a button
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(states:, value: false, variant: nil, size: nil, effect: nil, active: false, button: false,
                   **system_arguments)
      @states = validate_states!(states)
      @value = ActiveModel::Type::Boolean.new.cast(value)
      @variant = build_argument(variant, VARIANTS, 'variant')
      @size = build_argument(size, SIZES, 'size')
      @effect = build_argument(effect, EFFECTS, 'effect')
      @active = active
      @button = button
      super(**system_arguments)
    end

    def call
      tag.label(**label_html_attributes) do
        safe_join([
          tag.input(**input_html_attributes),
          render_state(:on),
          render_state(:off)
        ].compact)
      end
    end

    private

    def validate_states!(states)
      raise ArgumentError, 'states cannot be nil' if states.nil?
      raise ArgumentError, 'states cannot be empty' if states.empty?
      raise ArgumentError, 'states must have both :on and :off keys' unless states.key?(:on) && states.key?(:off)

      states
    end

    def input_html_attributes
      {
        type: 'checkbox',
        # class: 'hidden',
        # role: 'switch',
        checked: @value ? 'checked' : nil
      }.compact
    end

    def label_html_attributes
      {
        class: computed_classes,
        **system_arguments.slice(:aria)
      }.compact
    end

    def computed_classes
      modifiers = ['swap']
      modifiers << @effect if @effect
      modifiers << 'swap-active' if @active
      modifiers << 'btn btn-ghost btn-circle' if @button
      modifiers << @size if @size
      modifiers << @variant if @variant

      class_names(modifiers, system_arguments[:class])
    end

    def render_state(state)
      return unless @states[state]

      tag.div(@states[state], class: class_names(
        "swap-#{state}",
        { 'swap-on': state == :on },
        { 'swap-off': state == :off }
      ))
    end
  end
end
