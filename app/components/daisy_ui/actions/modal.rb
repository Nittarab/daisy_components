# frozen_string_literal: true

module DaisyUI
  # Modal component implementing DaisyUI's modal styles
  #
  # @example Basic dialog modal
  #   <%= render(Modal.new(modal_id: "my_modal_1")) do |m| %>
  #     <% m.with_body do %>
  #       <h3 class="text-lg font-bold">Hello!</h3>
  #       <p class="py-4">Press ESC key or click the button below to close</p>
  #     <% end %>
  #     <% m.with_actions do %>
  #       <form method="dialog">
  #         <button class="btn">Close</button>
  #       </form>
  #     <% end %>
  #   <% end %>
  #
  # @example Checkbox modal
  #   <%= render(Modal.new(type: :checkbox, modal_id: "my_modal_6")) do |m| %>
  #     <% m.with_body do %>
  #       <h3 class="text-lg font-bold">Hello!</h3>
  #       <p class="py-4">This modal works with a hidden checkbox!</p>
  #     <% end %>
  #     <% m.with_actions do %>
  #       <label for="my_modal_6" class="btn">Close!</label>
  #     <% end %>
  #   <% end %>
  #
  # @example Modal with backdrop closing
  #   <%= render(Modal.new(modal_id: "my_modal_2", close_on_backdrop: true)) do |m| %>
  #     <% m.with_body do %>
  #       <h3 class="text-lg font-bold">Hello!</h3>
  #       <p class="py-4">Press ESC key or click outside to close</p>
  #     <% end %>
  #   <% end %>
  #
  # @example Modal with corner close button
  #   <%= render(Modal.new(modal_id: "my_modal_3", close_button: true)) do |m| %>
  #     <% m.with_body do %>
  #       <h3 class="text-lg font-bold">Hello!</h3>
  #       <p class="py-4">Press ESC key or click on ✕ button to close</p>
  #     <% end %>
  #   <% end %>
  #
  # @example Responsive modal
  #   <%= render(Modal.new(modal_id: "my_modal_5", position: :responsive)) do |m| %>
  #     <% m.with_body do %>
  #       <h3 class="text-lg font-bold">Hello!</h3>
  #       <p class="py-4">Press ESC key or click the button below to close</p>
  #     <% end %>
  #     <% m.with_actions do %>
  #       <form method="dialog">
  #         <button class="btn">Close</button>
  #       </form>
  #     <% end %>
  #   <% end %>
  class Modal < BaseComponent
    renders_one :body
    renders_one :actions
    renders_one :custom_content

    # Available modal positions from DaisyUI
    POSITIONS = {
      responsive: 'modal-bottom sm:modal-middle'
    }.freeze

    # Modal types
    TYPES = {
      dialog: :dialog,
      checkbox: :checkbox
    }.freeze

    # @param type [Symbol] Type of modal (:dialog or :checkbox)
    # @param modal_id [String] Unique identifier for the modal
    # @param position [Symbol] Position of the modal (responsive for mobile-first)
    # @param close_on_backdrop [Boolean] Whether clicking backdrop closes modal
    # @param close_button [Boolean] Whether to show corner close button
    # @param width_class [String] Custom width classes for modal-box
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(
      type: :dialog,
      modal_id:,
      position: nil,
      close_on_backdrop: false,
      close_button: false,
      width_class: nil,
      **system_arguments
    )
      @type = build_argument(type, TYPES, 'type')
      @modal_id = modal_id
      @position = position ? build_argument(position, POSITIONS, 'position') : nil
      @close_on_backdrop = close_on_backdrop
      @close_button = close_button
      @width_class = width_class
      super(**system_arguments)
    end

    def call
      case @type
      when :checkbox
        render_checkbox_modal
      else
        render_dialog_modal
      end
    end

    private

    def render_dialog_modal
      tag.dialog(**dialog_arguments) do
        safe_join([
          modal_box_content,
          backdrop_content
        ].compact)
      end
    end

    def render_checkbox_modal
      safe_join([
        checkbox_input,
        checkbox_modal_wrapper
      ])
    end

    def dialog_arguments
      {
        id: @modal_id,
        class: computed_modal_classes,
        **system_arguments.except(:class)
      }.compact
    end

    def checkbox_input
      tag.input(
        type: 'checkbox',
        id: @modal_id,
        class: 'modal-toggle'
      )
    end

    def checkbox_modal_wrapper
      tag.div(
        role: 'dialog',
        class: computed_modal_classes,
        **system_arguments.except(:class)
      ) do
        safe_join([
          modal_box_content,
          checkbox_backdrop_content
        ].compact)
      end
    end

    def computed_modal_classes
      modifiers = ['modal']
      modifiers << @position if @position

      class_names(modifiers, system_arguments[:class])
    end

    def modal_box_content
      tag.div(class: computed_modal_box_classes) do
        safe_join([
          close_button_content,
          body_content,
          actions_content
        ].compact)
      end
    end

    def computed_modal_box_classes
      class_names('modal-box', @width_class)
    end

    def close_button_content
      return unless @close_button

      tag.form(method: 'dialog') do
        tag.button('✕', class: 'btn btn-sm btn-circle btn-ghost absolute right-2 top-2')
      end
    end

    def body_content
      return custom_content.to_s if custom_content?

      body.to_s if body?
    end

    def actions_content
      return unless actions?

      tag.div(class: 'modal-action') { actions.to_s }
    end

    def backdrop_content
      return unless @close_on_backdrop

      tag.form(method: 'dialog', class: 'modal-backdrop') do
        tag.button('close')
      end
    end

    def checkbox_backdrop_content
      return unless @close_on_backdrop

      tag.label('Close', for: @modal_id, class: 'modal-backdrop')
    end
  end
end