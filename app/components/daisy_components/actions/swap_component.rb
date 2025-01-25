# frozen_string_literal: true

module DaisyComponents
  module Actions
    class SwapComponent < DaisyComponents::BaseComponent
      VALID_VARIANTS = %i[neutral primary secondary accent info success warning error ghost].freeze
      VALID_SIZES = %i[xs sm md lg].freeze
      VALID_EFFECTS = %i[none rotate flip].freeze

      attr_reader :states, :value, :variant, :size, :effect, :button

      def initialize(states:, value: false, variant: nil, size: :md, effect: :none, button: false,
                     **system_arguments)
        validate_states!(states)
        @states = states
        @value = ActiveModel::Type::Boolean.new.cast(value)
        @variant = variant.to_sym if variant
        @size = size.to_sym if size
        @effect = effect.to_sym
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
      end

      def input_html_attributes
        attrs = {
          type: 'checkbox',
          class: 'hidden',
          role: 'switch'
        }
        attrs[:checked] = 'checked' if value
        attrs
      end

      def label_html_attributes
        {
          class: default_classes,
          **system_arguments.slice(:aria)
        }.compact
      end

      def default_classes
        class_names(
          'swap',
          system_arguments[:class],
          { 'swap-rotate': effect == :rotate },
          { 'swap-flip': effect == :flip },
          { 'btn btn-ghost btn-circle': button },
          size_classes,
          variant_classes
        )
      end

      def render_state(state)
        return unless states[state]

        tag.div(states[state], class: "swap-#{state}")
      end

      def size_classes
        case size
        when :xs then 'text-xs'
        when :sm then 'text-sm'
        when :md then 'text-base'
        when :lg then 'text-lg'
        end
      end

      def variant_classes
        return unless variant

        case variant
        when :primary then 'text-primary'
        when :secondary then 'text-secondary'
        when :accent then 'text-accent'
        when :info then 'text-info'
        when :success then 'text-success'
        when :warning then 'text-warning'
        when :error then 'text-error'
        when :ghost then 'text-base-content'
        end
      end
    end
  end
end
