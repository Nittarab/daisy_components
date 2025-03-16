# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  class BaseComponentTest < DaisyComponents::ComponentTestCase
    def test_build_argument_raises_error_for_invalid_values
      component = BaseComponent.new

      error = assert_raises(ArgumentError) do
        component.send(:build_argument, :invalid, { valid1: 'Valid 1', valid2: 'Valid 2' }, :test_attr)
      end

      assert_equal 'Invalid test_attr: invalid. Must be one of: valid1, valid2', error.message
    end

    def test_classes_helper_works_correctly
      component = BaseComponent.new
      component.instance_variable_set(:@classes, %w[class1 class2])

      assert_equal 'class1 class2', component.send(:classes)
    end
  end
end
