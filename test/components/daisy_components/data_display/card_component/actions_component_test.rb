# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class CardComponent
      class ActionsComponentTest < ViewComponent::TestCase
        def test_renders_with_valid_justify
          render_inline(ActionsComponent.new(justify: 'start'))
          assert_selector('.card-actions.justify-start')
        end

        def test_renders_with_invalid_justify
          render_inline(ActionsComponent.new(justify: 'invalid'))
          assert_selector('.card-actions')
          refute_selector('.justify-invalid')
        end

        def test_renders_with_nil_justify
          render_inline(ActionsComponent.new(justify: nil))
          assert_selector('.card-actions')
          refute_selector('[class*="justify-"]')
        end

        def test_renders_with_additional_classes
          render_inline(ActionsComponent.new(class: 'custom-class'))
          assert_selector('.card-actions.custom-class')
        end

        def test_html_attributes_handling
          render_inline(ActionsComponent.new(
                          class: 'custom-class',
                          data: { controller: 'test' },
                          aria: { label: 'Card Actions' }
                        ))
          assert_selector('.card-actions.custom-class[data-controller="test"][aria-label="Card Actions"]')
        end
      end
    end
  end
end
