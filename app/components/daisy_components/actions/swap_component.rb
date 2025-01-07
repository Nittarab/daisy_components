# frozen_string_literal: true

module DaisyComponents
  module Actions
    class SwapComponent < DaisyComponents::BaseComponent
      renders_one :on
      renders_one :off
      renders_one :indeterminate

      attr_reader :rotate, :flip, :active

      def initialize(rotate: false, flip: false, active: false, **system_arguments)
        @rotate = rotate
        @flip = flip
        @active = active

        super(**system_arguments)
      end

      def default_classes
        class_names(
          system_arguments[:class],
          'swap',
          'swap-rotate': rotate,
          'swap-flip': flip,
          'swap-active': active
        )
      end

      def call
        tag.label(class: default_classes) { render_swap_content }
      end

      private

      def render_swap_content
        safe_join([
          tag.input(type: 'checkbox', hidden: true),
          render_state(:on),
          render_state(:off),
          render_state(:indeterminate)
        ].compact)
      end

      def render_state(state)
        content = public_send(state)
        tag.div(content, class: "swap-#{state}") if content
      end
    end
  end
end
