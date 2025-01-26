# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AccordionComponent < DaisyComponents::BaseComponent
      renders_many :items, lambda { |**options, &block|
        AccordionItemComponent.new(
          parent: self,
          title: options[:title],
          name: options[:name],
          checked: options[:checked],
          &block
        )
      }

      attr_reader :join, :arrow, :plus, :radio

      def initialize(join: false, arrow: false, plus: false, radio: false, **system_arguments)
        @join = join
        @arrow = arrow
        @plus = plus
        @radio = radio

        super(**system_arguments)
      end

      def default_classes
        class_names(
          'w-full', # Always full width
          system_arguments[:class],
          join ? 'join join-vertical' : 'space-y-2'
        )
      end

      def call
        tag.div(**html_attributes) { safe_join(items || []) }
      end

      private

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
