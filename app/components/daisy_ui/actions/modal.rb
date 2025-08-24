# frozen_string_literal: true

module DaisyUI
  # Modal component implementing DaisyUI's modal functionality
  #
  # @example Basic dialog modal
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_1",
  #     modal_type: :dialog,
  #     title: "Hello!",
  #     content: "Press ESC key or click the button below to close"
  #   )) %>
  #
  # @example Checkbox modal
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_6",
  #     modal_type: :checkbox,
  #     title: "Hello!",
  #     content: "This modal works with a hidden checkbox!"
  #   )) %>
  #
  # @example Anchor link modal
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_8",
  #     modal_type: :anchor,
  #     title: "Hello!",
  #     content: "This modal works with anchor links"
  #   )) %>
  #
  # @example Modal with backdrop close
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_2",
  #     modal_type: :dialog,
  #     title: "Hello!",
  #     content: "Press ESC key or click outside to close",
  #     backdrop_close: true
  #   )) %>
  #
  # @example Modal with corner close button
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_3",
  #     modal_type: :dialog,
  #     title: "Hello!",
  #     content: "Press ESC key or click on ✕ button to close",
  #     corner_close: true
  #   )) %>
  #
  # @example Modal with custom width
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_4",
  #     modal_type: :dialog,
  #     title: "Hello!",
  #     content: "Click the button below to close",
  #     modal_box_class: "w-11/12 max-w-5xl"
  #   )) %>
  #
  # @example Responsive modal
  #   <%= render(Modal.new(
  #     modal_id: "my_modal_5",
  #     modal_type: :dialog,
  #     title: "Hello!",
  #     content: "Press ESC key or click the button below to close",
  #     responsive: true
  #   )) %>
  class Modal < BaseComponent
    # Valid modal types
    TYPES = {
      dialog: 'dialog',
      checkbox: 'input',
      anchor: 'div'
    }.freeze

    # Modal positioning options
    POSITIONS = {
      top: 'modal-top',
      middle: 'modal-middle',
      bottom: 'modal-bottom'
    }.freeze

    # @param modal_id [String] The unique ID for the modal element
    # @param modal_type [Symbol] Type of modal implementation (:dialog, :checkbox, :anchor)
    # @param title [String] Title to display in the modal header
    # @param content [String] Content to display in the modal body
    # @param backdrop_close [Boolean] Whether clicking backdrop closes the modal
    # @param corner_close [Boolean] Whether to show a close button in the top-right corner
    # @param responsive [Boolean] Whether to make modal responsive (bottom on mobile, middle on desktop)
    # @param position [Symbol] Position of the modal (:top, :middle, :bottom)
    # @param modal_box_class [String] Additional classes for the modal-box element
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(
      modal_id:,
      modal_type: :dialog,
      title: nil,
      content: nil,
      backdrop_close: false,
      corner_close: false,
      responsive: false,
      position: nil,
      modal_box_class: nil,
      **system_arguments
    )
      raise ArgumentError, 'modal_id is required' if modal_id.nil? || modal_id.empty?

      @modal_id = modal_id
      @modal_type = build_argument(modal_type, TYPES, 'modal_type')
      @title = title
      @content = content
      @backdrop_close = backdrop_close
      @corner_close = corner_close
      @responsive = responsive
      @position = build_argument(position, POSITIONS, 'position') if position
      @modal_box_class = modal_box_class

      super(**system_arguments)
    end

    def call
      case @modal_type
      when 'dialog'
        render_dialog_modal
      when 'input'
        render_checkbox_modal
      when 'div'
        render_anchor_modal
      end
    end

    private

    def render_dialog_modal
      tag.dialog(id: @modal_id, class: modal_classes, **dialog_attributes) do
        safe_join([
          modal_box_content,
          backdrop_form
        ].compact)
      end
    end

    def render_checkbox_modal
      safe_join([
        tag.input(type: 'checkbox', id: @modal_id, class: 'modal-toggle'),
        tag.div(class: modal_classes, role: 'dialog') do
          modal_box_content
        end
      ])
    end

    def render_anchor_modal
      tag.div(class: modal_classes, role: 'dialog', id: @modal_id, **system_arguments.except(:class)) do
        modal_box_content
      end
    end

    def modal_classes
      classes = ['modal']
      classes << @position if @position
      classes << 'modal-bottom sm:modal-middle' if @responsive
      class_names(classes, system_arguments[:class])
    end

    def modal_box_classes
      classes = ['modal-box']
      classes << @modal_box_class if @modal_box_class
      class_names(classes)
    end

    def dialog_attributes
      attrs = {}
      attrs.merge(system_arguments.except(:class))
    end

    def modal_box_content
      tag.div(class: modal_box_classes) do
        safe_join([
          corner_close_button,
          modal_header,
          modal_body_content,
          modal_actions
        ].compact)
      end
    end

    def corner_close_button
      return unless @corner_close

      tag.form(method: 'dialog') do
        tag.button('✕', class: 'btn btn-sm btn-circle btn-ghost absolute right-2 top-2')
      end
    end

    def modal_header
      return unless @title

      tag.h3(@title, class: 'text-lg font-bold')
    end

    def modal_body_content
      return unless @content

      tag.p(@content, class: 'py-4')
    end

    def modal_actions
      return unless default_close_action?

      tag.div(class: 'modal-action') do
        default_close_button
      end
    end

    def default_close_action?
      (@modal_type == 'dialog' && !@backdrop_close && !@corner_close) ||
        (@modal_type == 'input') ||
        (@modal_type == 'div')
    end

    def default_close_button
      case @modal_type
      when 'dialog'
        tag.form(method: 'dialog') do
          tag.button('Close', class: 'btn')
        end
      when 'input'
        tag.label('Close!', for: @modal_id, class: 'btn')
      when 'div'
        tag.a('Yay!', href: '#', class: 'btn')
      end
    end

    def backdrop_form
      return unless @backdrop_close && @modal_type == 'dialog'

      tag.form(method: 'dialog', class: 'modal-backdrop') do
        tag.button('close')
      end
    end
  end
end