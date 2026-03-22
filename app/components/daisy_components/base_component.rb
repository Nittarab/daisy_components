# frozen_string_literal: true

module DaisyComponents
  class BaseComponent < ViewComponent::Base
    def initialize(**system_arguments)
      super
      @system_arguments = system_arguments
    end

    private

    def classes
      class_names(system_arguments[:class])
    end

    attr_reader :system_arguments
  end
end
