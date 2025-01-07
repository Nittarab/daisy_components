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
          system_arguments[:class],
          'join join-vertical w-full' => join
        )
      end

      def call
        if join
          tag.div(class: default_classes) { safe_join(items || []) }
        else
          tag.div(class: system_arguments[:class]) { safe_join(items || []) }
        end
      end
    end
  end
end
