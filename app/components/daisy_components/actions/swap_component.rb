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
        tag.label(class: default_classes) do
          safe_join([
            tag.input(type: 'checkbox', hidden: true),
            (tag.div(on, class: 'swap-on') if on),
            (tag.div(off, class: 'swap-off') if off),
            (tag.div(indeterminate, class: 'swap-indeterminate') if indeterminate)
          ].compact)
        end
      end
    end
  end
end
