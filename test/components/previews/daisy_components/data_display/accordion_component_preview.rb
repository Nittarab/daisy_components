# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # @label Accordion
    class AccordionComponentPreview < ViewComponent::Preview
      # @!group Basic

      # @title Default
      # @description Basic accordion example with all available options
      #
      # @param join toggle "When true, joins all items together"
      # @param arrow toggle "When true, shows an arrow indicator"
      # @param plus toggle "When true, shows a plus/minus indicator"
      # @param radio toggle "When true, uses radio buttons instead of checkboxes"
      # @param classes text "Additional CSS classes to apply to the accordion"
      def playground(
        join: false,
        arrow: false,
        plus: false,
        radio: false,
        classes: ''
      )
        render_accordion_with_options(join:, arrow:, plus:, radio:, classes:)
      end

      # @!endgroup

      # @!group Examples

      # Basic Accordion
      # ---------------
      # Simple accordion with default settings
      #
      # @label Basic
      def basic
        render(AccordionComponent.new) do |component|
          component.with_item(title: 'Click me') { 'Hidden content' }
          component.with_item(title: 'Click me too') { 'More hidden content' }
        end
      end

      # Joined Accordion
      # ---------------
      # Accordion with joined items
      #
      # @label Joined
      def joined
        render(AccordionComponent.new(join: true)) do |component|
          component.with_item(title: 'First Item') { 'Content for first item' }
          component.with_item(title: 'Second Item') { 'Content for second item' }
          component.with_item(title: 'Third Item') { 'Content for third item' }
        end
      end

      # Arrow Indicator
      # ---------------
      # Accordion with arrow indicators
      #
      # @label Arrow
      def arrow
        render(AccordionComponent.new(arrow: true)) do |component|
          component.with_item(title: 'Expand me') { 'Arrow indicator content' }
          component.with_item(title: 'Expand me too') { 'More arrow indicator content' }
        end
      end

      # Plus/Minus Indicator
      # ---------------
      # Accordion with plus/minus indicators
      #
      # @label Plus/Minus
      def plus
        render(AccordionComponent.new(plus: true)) do |component|
          component.with_item(title: 'Click to expand') { 'Plus/minus indicator content' }
          component.with_item(title: 'Click me as well') { 'More plus/minus indicator content' }
        end
      end

      # Radio Group
      # ---------------
      # Accordion with radio buttons (only one item can be open at a time)
      #
      # @label Radio Group
      def radio
        render(AccordionComponent.new(radio: true)) do |component|
          component.with_item(title: 'Option 1', name: 'radio-group') { 'Content for option 1' }
          component.with_item(title: 'Option 2', name: 'radio-group') { 'Content for option 2' }
          component.with_item(title: 'Option 3', name: 'radio-group', checked: true) { 'Content for option 3' }
        end
      end

      # Complex Content
      # ---------------
      # Accordion with complex HTML content
      #
      # @label Complex Content
      def complex
        render(AccordionComponent.new(arrow: true)) do |component|
          render_list_item(component)
          render_card_item(component)
        end
      end

      # @!endgroup

      private

      def render_accordion_with_options(join:, arrow:, plus:, radio:, classes:)
        render(AccordionComponent.new(
                 join:, arrow:, plus:, radio:, class: classes
               )) do |component|
          component.with_item(title: 'Item 1', name: 'group1') { 'Content for item 1' }
          component.with_item(title: 'Item 2', name: 'group1') { 'Content for item 2' }
          component.with_item(title: 'Item 3', name: 'group1', checked: true) { 'Content for item 3' }
        end
      end

      def render_list_item(component)
        component.with_item(title: 'With List') do
          tag.ul(class: 'list-disc list-inside') do
            safe_join([
                        tag.li('First item'),
                        tag.li('Second item'),
                        tag.li('Third item')
                      ])
          end
        end
      end

      def render_card_item(component)
        component.with_item(title: 'With Card') do
          render_card_content
        end
      end

      def render_card_content
        tag.div(class: 'card bg-base-100 shadow-xl') do
          tag.div(class: 'card-body') do
            safe_join([
                        tag.h2('Card Title', class: 'card-title'),
                        tag.p('Card content goes here'),
                        render_card_actions
                      ])
          end
        end
      end

      def render_card_actions
        tag.div(class: 'card-actions justify-end') do
          tag.button('Action', class: 'btn btn-primary')
        end
      end
    end
  end
end
