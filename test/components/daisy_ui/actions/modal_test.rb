# frozen_string_literal: true

require 'test_helper'

module DaisyUI
  module Actions
    class ModalTest < DaisyUI::ComponentTestCase
      include DaisyUI::PreviewTestConcern

      test_all_preview_examples(
        preview_class: ModalPreview,
        component_name: 'modal',
        exclude: ['playground']
      )

      # Playground preview tests
      def test_playground_preview_default
        render_preview('playground')
        assert_selector 'dialog.modal', count: 1
        assert_selector 'div.modal-box', count: 1
        assert_text 'Hello!'
      end

      def test_playground_preview_checkbox_type
        render_preview('playground', params: { type: 'checkbox' })
        assert_selector 'input.modal-toggle[type="checkbox"]', count: 1
        assert_selector 'div.modal[role="dialog"]', count: 1
        assert_selector 'div.modal-box', count: 1
      end

      def test_playground_preview_with_close_on_backdrop
        render_preview('playground', params: { close_on_backdrop: true })
        assert_selector 'form.modal-backdrop', count: 1
      end

      def test_playground_preview_with_close_button
        render_preview('playground', params: { close_button: true })
        assert_selector 'button.btn-circle.btn-ghost', count: 1
        assert_text '✕'
      end

      def test_playground_preview_responsive_position
        render_preview('playground', params: { position: 'responsive' })
        assert_selector '.modal.modal-bottom.sm\\:modal-middle', count: 1
      end

      def test_playground_preview_with_custom_width
        render_preview('playground', params: { width_class: 'w-11/12 max-w-5xl' })
        assert_selector '.modal-box.w-11\\/12.max-w-5xl', count: 1
      end

      # Component functionality tests
      def test_modal_with_basic_dialog_structure
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal')) do |m|
          m.with_body { 'Test content' }
        end

        assert_selector 'dialog.modal#test_modal', count: 1
        assert_selector 'div.modal-box', count: 1
        assert_text 'Test content'
      end

      def test_modal_with_checkbox_structure
        render_inline(DaisyUI::Modal.new(type: :checkbox, modal_id: 'test_modal'))

        assert_selector 'input.modal-toggle#test_modal[type="checkbox"]', count: 1
        assert_selector 'div.modal[role="dialog"]', count: 1
        assert_selector 'div.modal-box', count: 1
      end

      def test_modal_with_actions
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal')) do |m|
          m.with_body { 'Test content' }
          m.with_actions { 'Action buttons' }
        end

        assert_selector 'div.modal-action', count: 1
        assert_text 'Action buttons'
      end

      def test_modal_with_close_button
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal', close_button: true)) do |m|
          m.with_body { 'Test content' }
        end

        assert_selector 'form[method="dialog"] button.btn-circle', count: 1
        assert_text '✕'
      end

      def test_modal_with_backdrop_closing_dialog
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal', close_on_backdrop: true)) do |m|
          m.with_body { 'Test content' }
        end

        assert_selector 'form.modal-backdrop[method="dialog"]', count: 1
      end

      def test_modal_with_backdrop_closing_checkbox
        render_inline(DaisyUI::Modal.new(type: :checkbox, modal_id: 'test_modal', close_on_backdrop: true)) do |m|
          m.with_body { 'Test content' }
        end

        assert_selector 'label.modal-backdrop[for="test_modal"]', count: 1
      end

      def test_modal_with_responsive_position
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal', position: :responsive)) do |m|
          m.with_body { 'Test content' }
        end

        assert_selector '.modal.modal-bottom.sm\\:modal-middle', count: 1
      end

      def test_modal_with_custom_width
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal', width_class: 'w-11/12 max-w-5xl')) do |m|
          m.with_body { 'Test content' }
        end

        assert_selector '.modal-box.w-11\\/12.max-w-5xl', count: 1
      end

      def test_modal_with_custom_content
        render_inline(DaisyUI::Modal.new(modal_id: 'test_modal')) do |m|
          m.with_custom_content { 'Custom content structure' }
        end

        assert_text 'Custom content structure'
        assert_no_selector 'div.modal-action'
      end

      def test_invalid_type_raises_error
        assert_raises(ArgumentError, /Invalid type/) do
          DaisyUI::Modal.new(modal_id: 'test', type: :invalid)
        end
      end

      def test_invalid_position_raises_error
        assert_raises(ArgumentError, /Invalid position/) do
          DaisyUI::Modal.new(modal_id: 'test', position: :invalid)
        end
      end
    end
  end
end
