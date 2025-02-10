# frozen_string_literal: true

module DaisyComponents
  class BaseComponent < ViewComponent::Base
    def initialize(classes: nil, **system_arguments)
      super
      @classes = classes
      @system_arguments = system_arguments
    end

    private

    def build_argument(key, valid_values, attr_name)
      return unless key

      class_name = valid_values[key.to_sym]

      return class_name if class_name

      raise ArgumentError, "Invalid #{attr_name}: #{key}. Must be one of: #{valid_values.keys.join(', ')}"
    end

    def classes
      class_names(@classes)
    end

    attr_reader :system_arguments
  end
end
