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
        trigger_html = if type == 'checkbox'
                         tag.label('open modal', for: modal_id, class: 'btn')
                       else
                         tag.button('open modal', class: 'btn', onclick: "#{modal_id}.showModal()")
                       end

        content = trigger_html.to_s + render(DaisyUI::Modal.new(
                   type: type.to_sym,
                   modal_id: modal_id,
                   position: position&.to_sym,
                   close_on_backdrop: close_on_backdrop,
                   close_button: close_button,
                   width_class: width_class.presence
                 )) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('Press ESC key or use controls to close', class: 'py-4')
              ])
            end

            unless close_button
              m.with_actions do
                if type == 'checkbox'
                  tag.label('Close!', for: modal_id, class: 'btn')
                else
                  tag.form(method: 'dialog') do
                    tag.button('Close', class: 'btn')
                  end
                end
              end
            end
          end.to_s
        
        content.html_safe
      end

      # @!endgroup

      # Basic dialog modal from fixture
      def dialog_modal
        safe_join([
          tag.button('open modal', class: 'btn', onclick: 'my_modal_1.showModal()'),
          render(DaisyUI::Modal.new(modal_id: 'my_modal_1')) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('Press ESC key or click the button below to close', class: 'py-4')
              ])
            end
            m.with_actions do
              tag.form(method: 'dialog') do
                tag.button('Close', class: 'btn')
              end
            end
          end
        ])
      end

      # Dialog modal that closes when clicked outside
      def dialog_modal_closes_when_clicked_outside
        content = tag.button('open modal', class: 'btn', onclick: 'my_modal_2.showModal()').to_s +
          render(DaisyUI::Modal.new(modal_id: 'my_modal_2', close_on_backdrop: true)) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('Press ESC key or click outside to close', class: 'py-4')
              ])
            end
          end.to_s
        
        content.html_safe
      end

      # Dialog modal with close button at corner
      def dialog_modal_with_a_close_button_at_corner
        content = tag.button('open modal', class: 'btn', onclick: 'my_modal_3.showModal()').to_s + 
          render(DaisyUI::Modal.new(modal_id: 'my_modal_3', close_button: true)) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('Press ESC key or click on ✕ button to close', class: 'py-4')
              ])
            end
          end.to_s
        
        content.html_safe
      end

      # Dialog modal with custom width
      def dialog_modal_with_custom_width
        content = tag.button('open modal', class: 'btn', onclick: 'my_modal_4.showModal()').to_s +
          render(DaisyUI::Modal.new(modal_id: 'my_modal_4', width_class: 'w-11/12 max-w-5xl')) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('Click the button below to close', class: 'py-4')
              ])
            end
            m.with_actions do
              tag.form(method: 'dialog') do
                tag.button('Close', class: 'btn')
              end
            end
          end.to_s
        
        content.html_safe
      end

      # Responsive modal
      def responsive
        content = tag.button('open modal', class: 'btn', onclick: 'my_modal_5.showModal()').to_s +
          render(DaisyUI::Modal.new(modal_id: 'my_modal_5', position: :responsive)) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('Press ESC key or click the button below to close', class: 'py-4')
              ])
            end
            m.with_actions do
              tag.form(method: 'dialog') do
                tag.button('Close', class: 'btn')
              end
            end
          end.to_s
        
        content.html_safe
      end

      # Modal using checkbox
      def modal_using_checkbox
        content = tag.label('open modal', for: 'my_modal_6', class: 'btn').to_s +
          render(DaisyUI::Modal.new(type: :checkbox, modal_id: 'my_modal_6')) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('This modal works with a hidden checkbox!', class: 'py-4')
              ])
            end
            m.with_actions do
              tag.label('Close!', for: 'my_modal_6', class: 'btn')
            end
          end.to_s
        
        content.html_safe
      end

      # Modal that closes when clicked outside (checkbox version)
      def modal_that_closes_when_clicked_outside
        content = tag.label('open modal', for: 'my_modal_7', class: 'btn').to_s +
          render(DaisyUI::Modal.new(type: :checkbox, modal_id: 'my_modal_7', close_on_backdrop: true)) do |m|
            m.with_body do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('This modal works with a hidden checkbox!', class: 'py-4')
              ])
            end
          end.to_s
        
        content.html_safe
      end

      # Modal using anchor link
      def modal_using_anchor_link
        safe_join([
          tag.a('open modal', href: '#my_modal_8', class: 'btn'),
          tag.div(id: 'my_modal_8', class: 'modal', role: 'dialog') do
            tag.div(class: 'modal-box') do
              safe_join([
                tag.h3('Hello!', class: 'text-lg font-bold'),
                tag.p('This modal works with anchor links', class: 'py-4'),
                tag.div(class: 'modal-action') do
                  tag.a('Close!', href: '#', class: 'btn')
                end
              ])
            end
          end
        ])
      end
    end
  end
end