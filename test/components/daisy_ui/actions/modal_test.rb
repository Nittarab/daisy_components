# frozen_string_literal: true

require 'test_helper'
require 'nokogiri'

module DaisyUI
  module Actions
    class ModalTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(
        preview_class: ModalPreview,
        component_name: 'modal',
        exclude: ['playground']
      )

      # Begin playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'button.btn', text: 'open modal'
        assert_selector 'dialog.modal#playground_modal', count: 1
        assert_selector 'dialog .modal-box', count: 1
        assert_text 'Hello!'
        assert_text 'This is a modal example'
      end

      def test_playground_preview_with_dialog_type
        render_preview('playground', params: { modal_type: 'dialog' })
        assert_selector 'dialog.modal', count: 1
      end

      def test_playground_preview_with_checkbox_type
        render_preview('playground', params: { modal_type: 'checkbox' })
        assert_selector 'input.modal-toggle[type="checkbox"]', count: 1
        assert_selector 'div.modal[role="dialog"]', count: 1
      end

      def test_playground_preview_with_anchor_type
        render_preview('playground', params: { modal_type: 'anchor' })
        assert_selector 'div.modal[role="dialog"]', count: 1
      end

      def test_playground_preview_with_backdrop_close
        render_preview('playground', params: { backdrop_close: true })
        assert_selector 'form.modal-backdrop', count: 1
      end

      def test_playground_preview_with_corner_close
        render_preview('playground', params: { corner_close: true })
        assert_selector 'button.btn-circle.absolute', count: 1, text: '✕'
      end

      def test_playground_preview_with_responsive
        render_preview('playground', params: { responsive: true })
        assert_selector '.modal.modal-bottom.sm\\:modal-middle', count: 1
      end

      def test_playground_preview_with_position_top
        render_preview('playground', params: { position: 'top' })
        assert_selector '.modal.modal-top', count: 1
      end

      def test_playground_preview_with_position_middle
        render_preview('playground', params: { position: 'middle' })
        assert_selector '.modal.modal-middle', count: 1
      end

      def test_playground_preview_with_position_bottom
        render_preview('playground', params: { position: 'bottom' })
        assert_selector '.modal.modal-bottom', count: 1
      end

      def test_playground_preview_with_custom_modal_box_class
        render_preview('playground', params: { modal_box_class: 'w-11/12 max-w-5xl' })
        assert_selector '.modal-box.w-11\\/12.max-w-5xl', count: 1
      end
    end
  end
end