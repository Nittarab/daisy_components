# frozen_string_literal: true

# @label Button
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class ButtonComponentPreview < ViewComponent::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive button component with all available options
      #
      # @param text text "Text content inside the button"
      # @param variant select { choices: [neutral, primary, secondary, accent,
      #                                   info, success, warning, error, ghost, link] }
      #   "Visual style"
      # @param size select { choices: [xs, sm, md, lg] } "Button size"
      # @param disabled toggle "Disable button interaction"
      # @param loading toggle "Show loading spinner"
      # @param active toggle "Show pressed state"
      # @param href text "URL for link buttons"
      # @param type select { choices: [button, submit, reset] } "HTML button type"
      # @param method select { choices: [get, post, put, patch, delete] } "HTTP method for links"
      # @param target select { choices: [_blank, _self, _parent, _top] } "Link target"
      # @param classes text "Additional CSS classes"
      def playground(text: 'Click me', variant: 'primary', size: 'md', disabled: false,
                     loading: false, active: false, href: nil, type: 'button', method: nil,
                     target: nil, classes: '')
        render(ButtonComponent.new(
                 text:,
                 variant:,
                 size:,
                 disabled:,
                 loading:,
                 active:,
                 href:,
                 type:,
                 method:,
                 target:,
                 class: classes
               ))
      end

      # @!endgroup

      # @!group Variants

      # Button Variants
      # ---------------
      # All available button style variants
      #
      # @label Variants
      def variants
        render_with_template(locals: {
                               variants: DaisyComponents::Actions::ButtonComponent::VARIANTS
                             })
      end

      # Primary Button
      # ---------------
      # Main call-to-action button style
      #
      # @label Primary
      def primary
        render(ButtonComponent.new(
                 text: 'Primary Action',
                 variant: 'primary'
               ))
      end

      # Secondary Button
      # ---------------
      # Alternative action button style
      #
      # @label Secondary
      def secondary
        render(ButtonComponent.new(
                 text: 'Secondary Action',
                 variant: 'secondary'
               ))
      end

      # Ghost Button
      # ---------------
      # Subtle button style for less important actions
      #
      # @label Ghost
      def ghost
        render(ButtonComponent.new(
                 text: 'Ghost Button',
                 variant: 'ghost'
               ))
      end

      # @!endgroup

      # @!group Sizes

      # Button Sizes
      # ---------------
      # All available button size options
      #
      # @label Sizes
      def sizes
        render_with_template(locals: {
                               sizes: DaisyComponents::Actions::ButtonComponent::SIZES
                             })
      end

      # @!endgroup

      # @!group States

      # Loading State
      # ---------------
      # Button with loading animation
      #
      # @label Loading
      def loading
        render(ButtonComponent.new(
                 text: 'Processing...',
                 loading: true,
                 disabled: true
               ))
      end

      # Active State
      # ---------------
      # Button in pressed state
      #
      # @label Active
      def active
        render(ButtonComponent.new(
                 text: 'Active Button',
                 active: true
               ))
      end

      # Disabled State
      # ---------------
      # Button in disabled state
      #
      # @label Disabled
      def disabled
        render(ButtonComponent.new(
                 text: "Can't click me",
                 disabled: true
               ))
      end

      # @!endgroup

      # @!group Types

      # Link Button
      # ---------------
      # Button that acts as a link
      #
      # @label Link
      def link_button
        render(ButtonComponent.new(
                 text: 'Visit Google',
                 href: 'https://google.com',
                 target: '_blank'
               ))
      end

      # Submit Button
      # ---------------
      # Form submit button
      #
      # @label Submit
      def submit_button
        render(ButtonComponent.new(
                 text: 'Submit Form',
                 type: 'submit',
                 variant: 'primary'
               ))
      end

      # Reset Button
      # ---------------
      # Form reset button
      #
      # @label Reset
      def reset_button
        render(ButtonComponent.new(
                 text: 'Reset Form',
                 type: 'reset',
                 variant: 'ghost'
               ))
      end

      # Turbo Method
      # ---------------
      # Button with Turbo Rails action
      #
      # @label Turbo
      def turbo_method
        render(ButtonComponent.new(
                 text: 'Delete Item',
                 href: '/items/1',
                 method: 'delete',
                 variant: 'error'
               ))
      end

      # @!endgroup

      # @!group Content

      # With Icon
      # ---------------
      # Button with icon and text
      #
      # @label Icon
      def with_icon
        render(ButtonComponent.new) do
          safe_join([
                      tag.i(class: 'fas fa-heart'),
                      ' Like'
                    ])
        end
      end

      # Block Button
      # ---------------
      # Full-width button
      #
      # @label Block
      def block
        render(ButtonComponent.new(
                 text: 'Full width button',
                 class: 'btn-block'
               ))
      end

      # Icon Only
      # ---------------
      # Square button with only an icon
      #
      # @label Icon Only
      def icon_only
        render(ButtonComponent.new(class: 'btn-square')) do
          tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: 'h-6 w-6', fill: 'none', viewBox: '0 0 24 24',
                  stroke: 'currentColor') do
            tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                     d: 'M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z')
          end
        end
      end

      # @!endgroup
    end
  end
end
