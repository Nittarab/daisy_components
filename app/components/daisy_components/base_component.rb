# frozen_string_literal: true

module DaisyComponents
  class BaseComponent < ViewComponent::Base
    def initialize(classes: nil, **system_arguments)
      super
      @classes = classes
      @system_arguments = system_arguments
    end

    private

    def classes
      class_names(@classes)
    end

    attr_reader :system_arguments
  end
end
