# frozen_string_literal: true

# @label Modal
# @display bg_color "#fff"
module DaisyUI
  module Actions
    class ModalPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Default
      # ---------------
      # Interactive modal component with customizable options
      #
      # @param modal_id text "Modal ID"
      # @param modal_type select { choices: [dialog, checkbox, anchor] }
      # @param title text "Modal title"
      # @param content text "Modal content"
      # @param backdrop_close toggle "Close on backdrop click"
      # @param corner_close toggle "Show corner close button"
      # @param responsive toggle "Responsive (bottom on mobile)"
      # @param position select { choices: [top, middle, bottom] }
      # @param modal_box_class text "Additional modal-box classes"
      def playground(
        modal_id: 'playground_modal',
        modal_type: :dialog,
        title: 'Hello!',
        content: 'This is a modal example',
        backdrop_close: false,
        corner_close: false,
        responsive: false,
        position: nil,
        modal_box_class: ''
      )
        render_with_template(locals: {
          modal: DaisyUI::Modal.new(
            modal_id: modal_id,
            modal_type: modal_type,
            title: title,
            content: content,
            backdrop_close: backdrop_close,
            corner_close: corner_close,
            responsive: responsive,
            position: position.present? ? position : nil,
            modal_box_class: modal_box_class.present? ? modal_box_class : nil
          )
        })
      end

      # @!endgroup

      # Dialog Modal
      # ---------------
      # Basic dialog modal using HTML5 dialog element
      def dialog_modal
        render_with_template
      end

      # Dialog Modal Closes When Clicked Outside
      # ---------------
      # Dialog modal that closes when backdrop is clicked
      def dialog_modal_closes_when_clicked_outside
        render_with_template
      end

      # Dialog Modal with Close Button at Corner
      # ---------------
      # Dialog modal with close button in top-right corner
      def dialog_modal_with_a_close_button_at_corner
        render_with_template
      end

      # Dialog Modal with Custom Width
      # ---------------
      # Dialog modal with custom width styling
      def dialog_modal_with_custom_width
        render_with_template
      end

      # Modal Using Anchor Link
      # ---------------
      # Modal that works with anchor links for navigation
      def modal_using_anchor_link
        render_with_template
      end

      # Modal Using Checkbox
      # ---------------
      # Modal that works with hidden checkbox for pure CSS interaction
      def modal_using_checkbox
        render_with_template
      end

      # Modal That Closes When Clicked Outside
      # ---------------
      # Standard modal with backdrop close functionality
      def modal_that_closes_when_clicked_outside
        render_with_template
      end

      # Responsive Modal
      # ---------------
      # Responsive modal that adapts to screen size
      def responsive
        render_with_template
      end
    end
  end
end