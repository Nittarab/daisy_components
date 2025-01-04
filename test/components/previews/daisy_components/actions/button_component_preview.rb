# frozen_string_literal: true

# @label Button
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class ButtonComponentPreview < Lookbook::Preview
      # Primary button
      # ---------------
      # This is the default button style you should use for most actions.
      #
      # @label Primary Button
      def default
        render DaisyComponents::Actions::ButtonComponent.new do
          'Click me'
        end
      end

      # Button variants
      # ---------------
      # DaisyUI provides multiple button variants for different contexts
      #
      # @label Variants
      def variants
        render_with_template(locals: {
                               variants: DaisyComponents::Actions::ButtonComponent::VARIANTS
                             })
      end

      # Button sizes
      # ---------------
      # Buttons come in different sizes to fit your needs
      #
      # @label Sizes
      def sizes
        render_with_template(locals: {
                               sizes: DaisyComponents::Actions::ButtonComponent::SIZES
                             })
      end

      # Interactive button
      # ---------------
      # Try different button combinations
      #
      # @label Playground
      # @param variant select [neutral, primary, secondary, accent, info, success, warning, error, ghost, link]
      # @param size select [xs, sm, md, lg]
      # @param text text "Button text"
      # @param disabled toggle
      def playground(variant: :primary, size: :md, text: 'Click me', disabled: false)
        render DaisyComponents::Actions::ButtonComponent.new(variant: variant, size: size, disabled: disabled) do
          text
        end
      end

      # @!group Examples

      # Loading state
      # ---------------
      def loading
        render DaisyComponents::Actions::ButtonComponent.new(classes: 'loading') do
          'Loading...'
        end
      end

      # With icon
      # ---------------
      def with_icon
        render DaisyComponents::Actions::ButtonComponent.new do
          safe_join([
                      tag.i(class: 'fas fa-heart'),
                      ' Like'
                    ])
        end
      end

      # Block button
      # ---------------
      def block
        render DaisyComponents::Actions::ButtonComponent.new(classes: 'btn-block') do
          'Full width button'
        end
      end

      # @!endgroup
    end
  end
end
