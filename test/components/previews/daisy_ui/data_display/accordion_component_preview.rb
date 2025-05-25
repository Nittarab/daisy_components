# frozen_string_literal: true

# @label Accordion
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class AccordionComponentPreview < ViewComponent::Preview
      # @!group Playground

      # @label Playground
      # @param join toggle "Join items together without gaps"
      # @param indicator select { choices: [none, arrow, plus] } "Toggle indicator type"
      # @param input_type select { choices: [checkbox, radio] } "Input type"
      # @param bg_color text "Background color"
      # @param text_color text "Text color"
      # @param border_color text "Border color"
      # @param padding select { choices: ["", p-0, p-1, p-2, p-3, p-4, p-6, p-8] } "Padding"
      # @param classes text "Additional CSS classes"
      def playground(
        join: false,
        indicator: nil,
        input_type: :checkbox,
        bg_color: 'nil',
        text_color: nil,
        border_color: nil,
        padding: nil,
        classes: ''
      )
        render(DaisyUI::Accordion.new(
                 join:,
                 indicator: indicator == 'none' ? nil : indicator&.to_sym,
                 input_type: input_type&.to_sym,
                 bg_color:,
                 text_color:,
                 border_color:,
                 padding:,
                 class: classes
               )) do |component|
          component.with_item(title: 'How do I create an account?', name: 'group1') do
            'Click the "Sign Up" button in the top right corner and follow the registration process.'
          end
          component.with_item(title: 'I forgot my password. What should I do?', name: 'group1') do
            'Click on "Forgot Password" on the login page and follow the instructions sent to your email.'
          end
          component.with_item(title: 'How do I update my profile information?', name: 'group1', checked: true) do
            'Go to "My Account" settings and select "Edit Profile" to make changes.'
          end
        end
      end

      # @!endgroup

      # @label Radio Group
      # @description Only one item can be expanded at a time
      def accordion_using_radio_inputs
        render(DaisyUI::Accordion.new(input_type: :radio)) do |accordion|
          accordion.with_item(title: 'How do I create an account?', checked: true, name: 'my-accordion-1') do
            'Click the "Sign Up" button in the top right corner and follow the registration process.'
          end
          accordion.with_item(title: 'I forgot my password. What should I do?', name: 'my-accordion-1') do
            'Click on "Forgot Password" on the login page and follow the instructions sent to your email.'
          end
          accordion.with_item(title: 'How do I update my profile information?', name: 'my-accordion-1') do
            'Go to "My Account" settings and select "Edit Profile" to make changes.'
          end
        end
      end

      # @label Plus/Minus Icon
      # @description Accordion with plus/minus indicator
      def accordion_with_plusminus_icon
        render(DaisyUI::Accordion.new(indicator: :plus, input_type: :radio)) do |accordion|
          accordion.with_item(title: 'How do I create an account?', checked: true, name: 'my-accordion-3') do
            'Click the "Sign Up" button in the top right corner and follow the registration process.'
          end
          accordion.with_item(title: 'I forgot my password. What should I do?', name: 'my-accordion-3') do
            'Click on "Forgot Password" on the login page and follow the instructions sent to your email.'
          end
          accordion.with_item(title: 'How do I update my profile information?', name: 'my-accordion-3') do
            'Go to "My Account" settings and select "Edit Profile" to make changes.'
          end
        end
      end

      # @label Joined Items
      # @description Using Accordion and Join together
      def using_accordion_and_join_together
        render(DaisyUI::Accordion.new(join: true, indicator: :arrow, input_type: :radio)) do |accordion|
          accordion.with_item(title: 'How do I create an account?', checked: true, name: 'my-accordion-4') do
            'Click the "Sign Up" button in the top right corner and follow the registration process.'
          end
          accordion.with_item(title: 'I forgot my password. What should I do?', name: 'my-accordion-4') do
            'Click on "Forgot Password" on the login page and follow the instructions sent to your email.'
          end
          accordion.with_item(title: 'How do I update my profile information?', name: 'my-accordion-4') do
            'Go to "My Account" settings and select "Edit Profile" to make changes.'
          end
        end
      end

      # @label Arrow Icon
      # @description Accordion with arrow indicator
      def accordion_with_arrow_icon
        render(DaisyUI::Accordion.new(indicator: :arrow, input_type: :radio)) do |accordion|
          accordion.with_item(title: 'How do I create an account?', checked: true, name: 'my-accordion-2') do
            'Click the "Sign Up" button in the top right corner and follow the registration process.'
          end
          accordion.with_item(title: 'I forgot my password. What should I do?', name: 'my-accordion-2') do
            'Click on "Forgot Password" on the login page and follow the instructions sent to your email.'
          end
          accordion.with_item(title: 'How do I update my profile information?', name: 'my-accordion-2') do
            'Go to "My Account" settings and select "Edit Profile" to make changes.'
          end
        end
      end
    end
  end
end
