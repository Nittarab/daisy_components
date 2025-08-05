# frozen_string_literal: true

# @label Modal
module DaisyUI
  module Actions
    class ModalPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Default
      # ---------------
      # Interactive modal component with customizable options
      #
      # @param type select {choices: [dialog, checkbox]}
      # @param modal_id text "Unique identifier for the modal"
      # @param position select {choices: [responsive]}
      # @param close_on_backdrop toggle "Enable backdrop closing"
      # @param close_button toggle "Show corner close button"
      # @param width_class text "Custom width classes"
      def playground(
        type: 'dialog',
        modal_id: 'playground_modal',
        position: nil,
        close_on_backdrop: false,
        close_button: false,
        width_class: nil
      )
        render_with_template(locals: {
                               type: type,
                               modal_id: modal_id,
                               position: position,
                               close_on_backdrop: close_on_backdrop,
                               close_button: close_button,
                               width_class: width_class
                             })
      end

      # @!endgroup

      # Basic dialog modal from fixture
      def dialog_modal
        render_with_template
      end

      # Dialog modal that closes when clicked outside
      def dialog_modal_closes_when_clicked_outside
        render_with_template
      end

      # Dialog modal with close button at corner
      def dialog_modal_with_a_close_button_at_corner
        render_with_template
      end

      # Dialog modal with custom width
      def dialog_modal_with_custom_width
        render_with_template
      end

      # Responsive modal
      def responsive
        render_with_template
      end

      # Modal using checkbox
      def modal_using_checkbox
        render_with_template
      end

      # Modal that closes when clicked outside (checkbox version)
      def modal_that_closes_when_clicked_outside
        render_with_template
      end

      # Modal using anchor link
      def modal_using_anchor_link
        render_with_template
      end
    end
  end
end
