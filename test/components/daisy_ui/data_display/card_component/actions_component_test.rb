# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module DataDisplay
    class CardComponent
      class ActionsComponentTest < DaisyUI::ComponentTestCase
        def test_renders_content
          content_text = 'Test content'
          render_inline(DaisyUI::Card::Actions.new) { content_text }

          assert_selector '.card-actions', text: content_text
        end

        def test_raises_error_for_invalid_justify_value
          error = assert_raises(ArgumentError) do
            DaisyUI::Card::Actions.new(justify: :invalid)
          end

          assert_equal 'Invalid justify: invalid. Must be one of: start, end, center, between, around, evenly',
                       error.message
        end

        def test_renders_with_justify_start
          render_inline(DaisyUI::Card::Actions.new(justify: :start)) { 'Actions' }

          assert_selector '.card-actions.justify-start'
        end

        def test_renders_with_justify_end
          render_inline(DaisyUI::Card::Actions.new(justify: :end)) { 'Actions' }

          assert_selector '.card-actions.justify-end'
        end

        def test_renders_with_justify_center
          render_inline(DaisyUI::Card::Actions.new(justify: :center)) { 'Actions' }

          assert_selector '.card-actions.justify-center'
        end

        def test_renders_with_justify_between
          render_inline(DaisyUI::Card::Actions.new(justify: :between)) { 'Actions' }

          assert_selector '.card-actions.justify-between'
        end

        def test_renders_with_custom_class
          render_inline(DaisyUI::Card::Actions.new(class: 'custom-class')) { 'Actions' }

          assert_selector '.card-actions.custom-class'
        end

        def test_renders_with_multiple_actions
          component = DaisyUI::Card::Actions.new
          component.with_button(text: 'Button 1')
          component.with_button(text: 'Button 2')

          render_inline(component)

          assert_selector '.card-actions .btn', count: 2
          assert_selector '.btn', text: 'Button 1'
          assert_selector '.btn', text: 'Button 2'
        end

        def test_renders_with_badge_actions
          component = DaisyUI::Card::Actions.new
          component.with_badge(text: 'Badge 1')
          component.with_badge(text: 'Badge 2')

          render_inline(component)

          assert_selector '.card-actions .badge', count: 2
          assert_selector '.badge', text: 'Badge 1'
          assert_selector '.badge', text: 'Badge 2'
        end
      end
    end
  end
end
