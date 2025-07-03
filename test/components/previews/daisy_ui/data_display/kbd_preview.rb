# frozen_string_literal: true

# @label Kbd
module DaisyUI
  module DataDisplay
    class KbdPreview < ViewComponent::Preview
      # @title Playground
      # @param text text "Ctrl"
      # @param size select { choices: [null, xs, sm, md, lg, xl] }
      def playground(text: 'Ctrl', size: nil)
        render(DaisyUI::Kbd.new(text: text, size: size&.to_sym))
      end

      # @title Default Kbd
      def kbd
        render(DaisyUI::Kbd.new(text: 'K'))
      end

      # @title Kbd Sizes
      # @param text text "Medium"
      def kbd_sizes(text: 'Medium')
        render_with_template(locals: { text: text })
      end

      # @title In Text
      def in_text
        render_with_template
      end

      # @title Key Combination
      def key_combination
        render_with_template
      end

      # @title Function Keys
      def function_keys
        render_with_template
      end

      # @title A Full Keyboard
      def a_full_keyboard
        render_with_template
      end

      # @title Arrow Keys
      def arrow_keys
        render_with_template
      end
    end
  end
end