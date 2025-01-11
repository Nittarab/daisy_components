# frozen_string_literal: true

# @label Button
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class ButtonComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Basic button example with all available options
      #
      # @param text text "The text content to display inside the button"
      # @param variant select { choices: [neutral, primary, secondary, accent, info,
      #                                   success, warning, error, ghost, link] }
      #                                   "Visual style of the button"
      # @param size select { choices: [xs, sm, md, lg] } "Size of the button"
      # @param disabled toggle "When true, prevents user interaction and grays out the button"
      # @param loading toggle "When true, shows a loading spinner and disables the button"
      # @param active toggle "When true, gives the button a pressed appearance"
      # @param href text "Turns the button into a link pointing to this URL"
      # @param type select { choices: [button, submit, reset] } "HTML button type attribute"
      # @param method select { choices: [get, post, put, patch, delete] } "HTTP method for Rails/Turbo links"
      # @param target select { choices: [_blank, _self, _parent, _top] } "Link target attribute"
      # @param classes text "Additional CSS classes to apply to the button"
      def playground(text: 'Click me', variant: 'primary', size: 'md', disabled: false,
                     loading: false, active: false, href: nil, type: 'button', method: nil,
                     target: nil, classes: '')
        render_button_with_options(text:, variant:, size:, disabled:, loading:,
                                   active:, href:, type:, method:, target:, classes:)
      end

      private

      def render_button_with_options(**)
        render(ButtonComponent.new(**))
      end

      # @!endgroup

      # @!group Content Types

      # Text Parameter
      # ---------------
      # Simple button with text parameter
      #
      # @label Text Parameter
      def text_param
        render DaisyComponents::Actions::ButtonComponent.new(text: 'Text Parameter')
      end

      # Block Content
      # ---------------
      # Button with complex block content
      def block_content
        render DaisyComponents::Actions::ButtonComponent.new do
          safe_join([
                      tag.i(class: 'fas fa-code'),
                      ' Block Content'
                    ])
        end
      end

      # @!endgroup

      # @!group Button Types

      # Link Button
      # ---------------
      # Button that acts as a link with proper security attributes
      def link_button
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Visit Google',
          href: 'https://google.com',
          target: '_blank'
        )
      end

      # Submit Button
      # ---------------
      # Form submit button with primary styling
      def submit_button
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Submit Form',
          type: 'submit',
          variant: 'primary'
        )
      end

      # Reset Button
      # ---------------
      # Form reset button with ghost styling
      def reset_button
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Reset Form',
          type: 'reset',
          variant: 'ghost'
        )
      end

      # Turbo Method
      # ---------------
      # Button with Turbo method for Rails actions
      def turbo_method
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Delete Item',
          href: '/items/1',
          method: 'delete',
          variant: 'error'
        )
      end

      # @!endgroup

      # @!group States

      # Loading State
      # ---------------
      # Button with loading animation and disabled state
      def loading
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Processing...',
          loading: true,
          disabled: true
        )
      end

      # Active State
      # ---------------
      # Button in pressed/active state
      def active
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Active Button',
          active: true
        )
      end

      # Disabled State
      # ---------------
      # Button in disabled state with proper ARIA attributes
      def disabled
        render DaisyComponents::Actions::ButtonComponent.new(
          text: "Can't click me",
          disabled: true
        )
      end

      # @!endgroup

      # @!group Variants

      # Button Variants
      # ---------------
      # All available button style variants
      #
      # @label All Variants
      def variants
        render_with_template(locals: {
                               variants: DaisyComponents::Actions::ButtonComponent::VARIANTS
                             })
      end

      # Primary Button
      # ---------------
      # Main call-to-action button style
      def primary
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Primary Action',
          variant: 'primary'
        )
      end

      # Secondary Button
      # ---------------
      # Alternative action button style
      def secondary
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Secondary Action',
          variant: 'secondary'
        )
      end

      # Ghost Button
      # ---------------
      # Subtle button style for less important actions
      def ghost
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Ghost Button',
          variant: 'ghost'
        )
      end

      # @!endgroup

      # @!group Sizes

      # Button Sizes
      # ---------------
      # All available button size options
      #
      # @label All Sizes
      def sizes
        render_with_template(locals: {
                               sizes: DaisyComponents::Actions::ButtonComponent::SIZES
                             })
      end

      # @!endgroup

      # @!group Common Use Cases

      # With Icon
      # ---------------
      # Button with icon and text
      def with_icon
        render DaisyComponents::Actions::ButtonComponent.new do
          safe_join([
                      tag.i(class: 'fas fa-heart'),
                      ' Like'
                    ])
        end
      end

      # Block Button
      # ---------------
      # Full-width button using DaisyUI's btn-block class
      def block
        render DaisyComponents::Actions::ButtonComponent.new(
          text: 'Full width button',
          classes: 'btn-block'
        )
      end

      # Icon Only
      # ---------------
      # Square button with only an icon
      def icon_only
        render DaisyComponents::Actions::ButtonComponent.new(classes: 'btn-square') do
          <<~SVG.html_safe
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          SVG
        end
      end

      # @!endgroup
    end
  end
end
