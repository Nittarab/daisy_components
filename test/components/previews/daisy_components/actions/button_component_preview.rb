# frozen_string_literal: true

# @label Button
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class ButtonComponentPreview < Lookbook::Preview
      # @!group Playground

      # @title Default
      # @description Basic button example with all available options
      #
      # @param content text
      # @param variant [String] select [neutral, primary, secondary, accent, info, success, warning, error, ghost, link]
      # @param size [String] select [xs, sm, md, lg]
      # @param disabled toggle
      # @param classes text
      def playground(
        content: 'Click me',
        variant: 'primary',
        size: 'md',
        disabled: false,
        classes: ''
      )
        render(DaisyComponents::Actions::ButtonComponent.new(
                 variant: variant,
                 size: size,
                 disabled: disabled,
                 classes: classes
               )) { content }
      end

      # @!endgroup

      # @!group Variants

      # Button Variants
      # ---------------
      # All available button variants
      #
      # @label All Variants
      def variants
        render_with_template(locals: {
                               variants: DaisyComponents::Actions::ButtonComponent::VARIANTS
                             })
      end

      # Primary Button
      # ---------------
      # Use for main actions
      def primary
        render DaisyComponents::Actions::ButtonComponent.new(variant: :primary) do
          'Primary Action'
        end
      end

      # Secondary Button
      # ---------------
      # Use for secondary actions
      def secondary
        render DaisyComponents::Actions::ButtonComponent.new(variant: :secondary) do
          'Secondary Action'
        end
      end

      # Ghost Button
      # ---------------
      # Use for subtle actions
      def ghost
        render DaisyComponents::Actions::ButtonComponent.new(variant: :ghost) do
          'Ghost Button'
        end
      end

      # @!endgroup

      # @!group Sizes

      # Button Sizes
      # ---------------
      # All available button sizes
      #
      # @label All Sizes
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
      def loading
        render DaisyComponents::Actions::ButtonComponent.new(classes: 'loading') do
          'Loading...'
        end
      end

      # Disabled State
      # ---------------
      # Button in disabled state
      def disabled
        render DaisyComponents::Actions::ButtonComponent.new(disabled: true) do
          "Can't click me"
        end
      end

      # @!endgroup

      # @!group Common Use Cases

      # With Icon
      # ---------------
      # Button with an icon
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
      # Full-width button
      def block
        render DaisyComponents::Actions::ButtonComponent.new(classes: 'btn-block') do
          'Full width button'
        end
      end

      # Icon Only
      # ---------------
      # Button with only an icon
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
