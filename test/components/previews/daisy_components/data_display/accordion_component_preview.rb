# frozen_string_literal: true

# @label Accordion
# @display bg_color "#fff"
module DaisyComponents
  module DataDisplay
    class AccordionComponentPreview < ViewComponent::Preview
      # @!group Playground

      # @label Playground
      # @param join toggle "Join items together without gaps"
      # @param arrow toggle "Show arrow indicator"
      # @param plus toggle "Show plus/minus indicator"
      # @param radio toggle "Use radio buttons for exclusive selection"
      # @param bg_color select { choices: [bg-base-100, bg-primary, bg-secondary, bg-accent, bg-neutral] }
      #                      "Background color"
      # @param text_color select {
      #   choices: [
      #     text-base-content,
      #     text-primary-content,
      #     text-secondary-content,
      #     text-accent-content,
      #     text-neutral-content
      #   ]
      # } "Text color"
      # @param border_color select {
      #   choices: [
      #     border border-base-300,
      #     border-primary,
      #     border-secondary,
      #     border-accent,
      #     border-neutral
      #   ]
      # } "Border color"
      # @param padding select { choices: [p-0, p-2, p-4, p-6, p-8] }
      #                     "Padding"
      # @param classes text "Additional CSS classes"
      def playground(
        join: false,
        arrow: false,
        plus: false,
        radio: false,
        bg_color: nil,
        text_color: nil,
        border_color: nil,
        padding: nil,
        classes: ''
      )
        render(AccordionComponent.new(
                 join:,
                 arrow:,
                 plus:,
                 radio:,
                 bg_color:,
                 text_color:,
                 border_color:,
                 padding:,
                 class: classes
               )) do |component|
          component.with_item(title: 'Item 1', name: 'group1') { 'Content for item 1' }
          component.with_item(title: 'Item 2', name: 'group1') { 'Content for item 2' }
          component.with_item(title: 'Item 3', name: 'group1', checked: true) { 'Content for item 3' }
        end
      end

      # @!endgroup

      # @!group Basic

      # @label Default
      # @description Basic accordion example with FAQ style
      def default
        render(AccordionComponent.new(arrow: true)) do |component|
          component.with_item(title: 'How do I create an account?') do
            'Click the "Sign Up" button in the top right corner and follow the registration process.'
          end
          component.with_item(title: 'I forgot my password. What should I do?') do
            'Click on "Forgot Password" on the login page and follow the instructions sent to your email.'
          end
          component.with_item(title: 'How do I update my profile information?') do
            'Go to "My Account" settings and select "Edit Profile" to make changes.'
          end
        end
      end

      # @label With Arrow
      # @description Accordion with arrow icon
      def with_arrow
        render(AccordionComponent.new(arrow: true)) do |component|
          component.with_item(title: 'Expand me') { 'Arrow indicator content' }
          component.with_item(title: 'Expand me too') { 'More arrow indicator content' }
        end
      end

      # @label With Plus
      # @description Accordion with plus/minus icon
      def with_plus
        render(AccordionComponent.new(plus: true)) do |component|
          component.with_item(title: 'Click to expand') { 'Plus/minus indicator content' }
          component.with_item(title: 'Click me as well') { 'More plus/minus indicator content' }
        end
      end

      # @label Joined
      # @description Using Accordion and Join together
      def joined
        render(AccordionComponent.new(join: true, arrow: true)) do |component|
          component.with_item(title: 'Item 1') { 'Content 1' }
          component.with_item(title: 'Item 2') { 'Content 2' }
          component.with_item(title: 'Item 3') { 'Content 3' }
        end
      end

      # @label Radio Selection
      # @description Only one item can be expanded at a time
      def radio_group
        render(AccordionComponent.new(radio: true, arrow: true)) do |component|
          component.with_item(title: 'Option 1', name: 'radio-group') { 'Content for option 1' }
          component.with_item(title: 'Option 2', name: 'radio-group') { 'Content for option 2' }
          component.with_item(title: 'Option 3', name: 'radio-group', checked: true) { 'Content for option 3' }
        end
      end

      # @label Custom Colors
      # @description Accordion with custom colors
      def custom_colors
        render(AccordionComponent.new(
                 arrow: true,
                 bg_color: 'bg-primary',
                 text_color: 'text-primary-content',
                 border_color: 'border-primary',
                 padding: 'p-4'
               )) do |component|
          component.with_item(title: 'Primary Theme') { 'Content with primary theme' }
          component.with_item(title: 'Click me too') { 'More themed content' }
        end
      end

      # @!endgroup

      # @!group Complex Content

      # @label With List
      # @description Accordion item containing a list
      def with_list
        render_with_template
      end

      # @label With Card
      # @description Accordion item containing a card
      def with_card
        render_with_template
      end

      # @!endgroup
    end
  end
end
