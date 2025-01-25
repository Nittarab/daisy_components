# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    class AvatarGroupComponent < DaisyComponents::BaseComponent
      renders_many :avatars, lambda { |**system_arguments|
        AvatarComponent.new(**system_arguments)
      }

      private

      def default_classes
        class_names(
          'avatar-group -space-x-6 rtl:space-x-revers',
          system_arguments[:class]
        )
      end

      def html_attributes
        attrs = system_arguments.except(:class)
        attrs[:class] = default_classes
        attrs
      end
    end
  end
end
