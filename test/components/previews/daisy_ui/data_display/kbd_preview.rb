# frozen_string_literal: true

module DaisyUI
  module DataDisplay
    # @label Kbd
    class KbdPreview < ViewComponent::Preview
      # @!group Playground
      # @label Playground
      # @param text text "Ctrl"
      # @param size select { choices: [null, xs, sm, md, lg, xl] }
      def playground(text: 'Ctrl', size: nil)
        render(DaisyUI::Kbd.new(text: text, size: size&.to_sym))
      end
      # @!endgroup

      # Default Kbd
      # ---------------
      # Basic keyboard key component
      def kbd
        render(DaisyUI::Kbd.new(text: 'K'))
      end

      # Kbd Sizes
      # ---------------
      # Keyboard keys with different sizes
      # @param text text "Medium"
      def kbd_sizes(text: 'Medium')
        render_with_template(locals: { text: text })
      end

      # In Text
      # ---------------
      # Keyboard keys used within text content
      def in_text
        render_with_template
      end

      # Key Combination
      # ---------------
      # Multiple keys combined together
      def key_combination
        render_with_template
      end

      # Function Keys
      # ---------------
      # Function key examples
      def function_keys
        render_with_template
      end

      # A Full Keyboard
      # ---------------
      # Complete keyboard layout example
      def a_full_keyboard
        render_with_template
      end

      # Arrow Keys
      # ---------------
      # Arrow key navigation examples
      def arrow_keys
        render_with_template
      end
    end
  end
end
