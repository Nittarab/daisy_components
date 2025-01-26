# frozen_string_literal: true

# @label Button
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class ButtonComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

      # @!group Playground

      # Default
      # ---------------
      # Interactive button component with customizable styling
      #
      # @param text text "Text content inside the button"
      # @param variant select {
      #   choices: [neutral, primary, secondary, accent, info, success, warning, error, ghost, link]
      # }
      # @param size select { choices: [xs, sm, md, lg, xl] }
      # @param style select { choices: [outline, soft] }
      # @param shape select { choices: [wide, block, circle, square] }
      # @param disabled toggle "Disable the button"
      # @param loading toggle "Show loading state"
      # @param active toggle "Show active state"
      # @param has_start_icon toggle "Add start icon"
      # @param has_end_icon toggle "Add end icon"
      # @param classes text "Additional CSS classes"
      def playground(
        text: 'Button',
        variant: nil,
        size: nil,
        style: nil,
        shape: nil,
        disabled: false,
        loading: false,
        active: false,
        has_start_icon: false,
        has_end_icon: false,
        classes: ''
      )
        render(ButtonComponent.new(
                 text:,
                 variant:,
                 size:,
                 style:,
                 shape:,
                 disabled:,
                 loading:,
                 active:,
                 icon_start: has_start_icon ? warning_icon('h-5 w-5') : nil,
                 icon_end: has_end_icon ? chevron_down_icon('h-5 w-5') : nil,
                 class: classes
               ))
      end

      # @!endgroup

      # @!group Variants

      # Primary Button
      # ---------------
      # Main call-to-action button style
      def primary
        render(ButtonComponent.new(
                 text: 'Primary Action',
                 variant: 'primary'
               ))
      end

      # Secondary Button
      # ---------------
      # Alternative action button style
      def secondary
        render(ButtonComponent.new(
                 text: 'Secondary Action',
                 variant: 'secondary'
               ))
      end

      # Ghost Button
      # ---------------
      # Subtle button style for less important actions
      def ghost
        render(ButtonComponent.new(
                 text: 'Ghost Button',
                 variant: 'ghost'
               ))
      end

      # All Variants
      # ---------------
      # All available button variants
      def variants
        render_with_template(locals: {
                               buttons: ButtonComponent::VARIANTS.map do |variant|
                                 { text: variant.titleize, variant: variant }
                               end
                             })
      end

      # All Sizes
      # ---------------
      # All available button sizes
      def sizes
        render_with_template(locals: {
                               buttons: ButtonComponent::SIZES.map do |size|
                                 { text: size.upcase, size: size }
                               end
                             })
      end

      # @!endgroup

      # @!group States

      # Loading State
      # ---------------
      # Button with loading animation
      def loading
        render_with_template(locals: {
                               buttons: [
                                 { text: 'Processing...', loading: true },
                                 { text: 'Loading Primary', variant: 'primary', loading: true },
                                 { text: 'Loading Secondary', variant: 'secondary', loading: true }
                               ]
                             })
      end

      # Disabled State
      # ---------------
      # Button in disabled state
      def disabled
        render_with_template(locals: {
                               buttons: [
                                 { text: "Can't click me", disabled: true },
                                 { text: 'Disabled Primary', variant: 'primary', disabled: true },
                                 { text: 'Disabled Secondary', variant: 'secondary', disabled: true }
                               ]
                             })
      end

      # Active State
      # ---------------
      # Button in active state
      def active
        render_with_template(locals: {
                               buttons: [
                                 { text: 'Active Button', active: true },
                                 { text: 'Active Primary', variant: 'primary', active: true },
                                 { text: 'Active Secondary', variant: 'secondary', active: true }
                               ]
                             })
      end

      # @!endgroup

      # @!group Links

      # Link Button
      # ---------------
      # Button that acts as a link
      def link_button
        render(ButtonComponent.new(
                 text: 'Visit Google',
                 href: 'https://google.com',
                 variant: 'primary',
                 target: '_blank'
               ))
      end

      # External Link
      # ---------------
      # Link button that opens in new tab
      def external_link
        render(ButtonComponent.new(
                 text: 'External Link',
                 href: 'https://example.com',
                 target: '_blank',
                 variant: 'primary',
                 icon_end: close_icon('h-5 w-5')
               ))
      end

      # Turbo Method
      # ---------------
      # Link button with Turbo method
      def turbo_method
        render(ButtonComponent.new(
                 text: 'Delete Item',
                 href: '/items/1',
                 method: 'delete',
                 variant: 'error'
               ))
      end

      # @!endgroup

      # @!group Forms

      # Submit Button
      # ---------------
      # Form submit button
      def submit_button
        render(ButtonComponent.new(
                 text: 'Submit Form',
                 type: 'submit',
                 variant: 'primary',
                 icon_end: chevron_down_icon('h-5 w-5')
               ))
      end

      # Reset Button
      # ---------------
      # Form reset button
      def reset_button
        render(ButtonComponent.new(
                 text: 'Reset Form',
                 type: 'reset',
                 variant: 'ghost',
                 icon_start: close_icon('h-5 w-5')
               ))
      end

      # @!endgroup

      # @!group Content

      # Basic Text
      # ---------------
      # Button with simple text content
      def basic_text
        render(ButtonComponent.new(text: 'Click Me'))
      end

      # Block Content
      # ---------------
      # Button with HTML content
      def block_content
        render(ButtonComponent.new) { 'Complex <strong>content</strong>'.html_safe }
      end

      # Block Button
      # ---------------
      # Full-width button
      def block
        render(ButtonComponent.new(
                 text: 'Block Button',
                 shape: 'block',
                 variant: 'primary'
               ))
      end

      # Component Content
      # ---------------
      # Button with nested component
      def component_content
        render(ButtonComponent.new) do
          render(DaisyComponents::DataDisplay::BadgeComponent.new('New', variant: 'secondary'))
        end
      end

      # @!endgroup

      # @!group Icons

      # With Icon
      # ---------------
      # Button with icon and text
      def with_icon
        render(ButtonComponent.new(
                 text: 'Like',
                 icon_start: warning_icon('h-5 w-5')
               ))
      end

      # Icon Start
      # ---------------
      # Button with icon before text
      #
      # @label Start Icon
      def icon_start
        render(ButtonComponent.new(
                 text: 'Submit',
                 icon_start: warning_icon('h-5 w-5'),
                 variant: 'primary'
               ))
      end

      # Icon End
      # ---------------
      # Button with icon after text
      #
      # @label End Icon
      def icon_end
        render(ButtonComponent.new(
                 text: 'Next',
                 icon_end: chevron_down_icon('h-5 w-5'),
                 variant: 'primary'
               ))
      end

      # Both Icons
      # ---------------
      # Button with icons on both sides
      #
      # @label Both Icons
      def both_icons
        render(ButtonComponent.new(
                 text: 'Sync',
                 icon_start: warning_icon('h-5 w-5'),
                 icon_end: chevron_down_icon('h-5 w-5'),
                 variant: 'primary'
               ))
      end

      # Icon Only
      # ---------------
      # Square button with only an icon
      #
      # @label Icon Only
      def icon_only
        render(ButtonComponent.new(
                 icon_start: warning_icon('h-6 w-6'),
                 class: 'btn-square'
               ))
      end

      # @!endgroup

      # @!group Styles

      # Outline Button
      # ---------------
      # Button with outline style
      def outline
        render(ButtonComponent.new(
                 text: 'Outline Button',
                 style: 'outline',
                 variant: 'primary'
               ))
      end

      # Soft Button
      # ---------------
      # Button with soft style
      def soft
        render(ButtonComponent.new(
                 text: 'Soft Button',
                 style: 'soft',
                 variant: 'primary'
               ))
      end

      # All Styles
      # ---------------
      # All available button styles
      def styles
        render_with_template(locals: {
                               buttons: ButtonComponent::STYLES.map do |style|
                                 { text: style.titleize, style: style, variant: 'primary' }
                               end
                             })
      end

      # @!group Shapes

      # Wide Button
      # ---------------
      # Button with wide shape
      def wide
        render(ButtonComponent.new(
                 text: 'Wide Button',
                 shape: 'wide',
                 variant: 'primary'
               ))
      end

      # Circle Button
      # ---------------
      # Circle shaped button with icon
      def circle
        render(ButtonComponent.new(
                 icon_start: check_icon('h-6 w-6'),
                 shape: 'circle',
                 variant: 'primary'
               ))
      end

      # Square Button
      # ---------------
      # Square shaped button with icon
      def square
        render(ButtonComponent.new(
                 icon_start: check_icon('h-6 w-6'),
                 shape: 'square',
                 variant: 'primary'
               ))
      end

      # All Shapes
      # ---------------
      # All available button shapes
      def shapes
        render_with_template(locals: {
                               buttons: ButtonComponent::SHAPES.map do |shape|
                                 { text: shape.titleize, shape: shape, variant: 'primary' }
                               end
                             })
      end
    end
  end
end
