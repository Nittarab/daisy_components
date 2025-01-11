# frozen_string_literal: true

# @label Accordion
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class AccordionComponentPreview < Lookbook::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive accordion component with customizable behavior and styling
      #
      # @param join toggle "Join items together without gaps"
      # @param arrow toggle "Show arrow indicator"
      # @param plus toggle "Show plus/minus indicator"
      # @param radio toggle "Use radio buttons for exclusive selection"
      # @param classes text "Additional CSS classes"
      def playground(
        join: false,
        arrow: false,
        plus: false,
        radio: false,
        classes: ''
      )
        render(AccordionComponent.new(
                 join:,
                 arrow:,
                 plus:,
                 radio:,
                 class: classes
               )) do |component|
          component.with_item(title: 'Item 1', name: 'group1') { 'Content for item 1' }
          component.with_item(title: 'Item 2', name: 'group1') { 'Content for item 2' }
          component.with_item(title: 'Item 3', name: 'group1', checked: true) { 'Content for item 3' }
        end
      end

      # @!endgroup

      # @!group Examples

      # Basic Accordion
      # ---------------
      # Simple accordion with default styling
      #
      # @label Basic
      def basic
        render(AccordionComponent.new) do |component|
          component.with_item(title: 'Click me') { 'Hidden content' }
        end
      end

      # Multiple Items
      # ---------------
      # Accordion with multiple expandable items
      #
      # @label Multiple
      def multiple
        render(AccordionComponent.new) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
          component.with_item(title: 'Item 2') { 'Content 2' }
          component.with_item(title: 'Item 3', checked: true) { 'Content 3' }
        end
      end

      # Joined Items
      # ---------------
      # Items joined together without gaps
      #
      # @label Joined
      def joined
        render(AccordionComponent.new(join: true)) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
          component.with_item(title: 'Item 2') { 'Content 2' }
          component.with_item(title: 'Item 3') { 'Content 3' }
        end
      end

      # Arrow Indicator
      # ---------------
      # Items with arrow indicator
      #
      # @label Arrow
      def with_arrow
        render(AccordionComponent.new(arrow: true)) do |component|
          component.with_item(title: 'Expand me') { 'Arrow indicator content' }
          component.with_item(title: 'Expand me too') { 'More arrow indicator content' }
        end
      end

      # Plus/Minus Indicator
      # ---------------
      # Items with plus/minus indicator
      #
      # @label Plus
      def with_plus
        render(AccordionComponent.new(plus: true)) do |component|
          component.with_item(title: 'Click to expand') { 'Plus/minus indicator content' }
          component.with_item(title: 'Click me as well') { 'More plus/minus indicator content' }
        end
      end

      # Radio Selection
      # ---------------
      # Only one item can be expanded at a time
      #
      # @label Radio
      def radio_group
        render(AccordionComponent.new(radio: true)) do |component|
          component.with_item(title: 'Option 1', name: 'radio-group') { 'Content for option 1' }
          component.with_item(title: 'Option 2', name: 'radio-group') { 'Content for option 2' }
          component.with_item(title: 'Option 3', name: 'radio-group', checked: true) { 'Content for option 3' }
        end
      end

      # @!endgroup

      # @!group Complex Content

      # With List Content
      # ---------------
      # Accordion item containing a list
      #
      # @label List
      def with_list
        render_with_template
      end

      # With Card Content
      # ---------------
      # Accordion item containing a card
      #
      # @label Card
      def with_card
        render_with_template
      end

      # @!endgroup
    end
  end
end
