# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class CardComponent
      class BodyComponentTest < DaisyComponents::ComponentTestCase
        def test_renders_description_when_provided
          component = BodyComponent.new(description: 'Test description')

          render_inline(component)
          assert_selector 'p', text: 'Test description'
        end
      end
    end
  end
end
