# frozen_string_literal: true

module DaisyUI
  # Alert component implementing DaisyUI's alert styles
  #
  # @example Basic usage
  #   <%= render(DaisyUI::Alert.new(text: "Alert message")) %>
  #
  # @example Info alert
  #   <%= render(DaisyUI::Alert.new(text: "New software update available.", color: :info)) %>
  #
  # @example Success alert with icon
  #   <%= render(DaisyUI::Alert.new(text: "Your purchase has been confirmed!", color: :success, icon: helpers.check_icon)) %>
  #
  # @example With custom icon
  #   <%= render(DaisyUI::Alert.new(
  #     text: "Custom message",
  #     icon: helpers.home_icon
  #   )) %>
  #
  # @example With block content
  #   <%= render(DaisyUI::Alert.new(color: :info)) do %>
  #     <h3 class="font-bold">New message!</h3>
  #     <div class="text-xs">You have 1 unread message</div>
  #   <% end %>
  #
  # @example Outline style
  #   <%= render(DaisyUI::Alert.new(text: "Outline alert", color: :info, variant: :outline)) %>
  class Alert < DaisyUI::BaseComponent
    renders_one :icon
    renders_one :actions

    # Available alert colors from DaisyUI
    COLORS = {
      info: 'alert-info',
      success: 'alert-success',
      warning: 'alert-warning',
      error: 'alert-error'
    }.freeze

    # Available alert variants from DaisyUI
    VARIANTS = {
      outline: 'alert-outline',
      soft: 'alert-soft',
      dash: 'alert-dash'
    }.freeze



    # @param text [String] The text content to display inside the alert
    # @param color [Symbol] Alert type color (info/success/warning/error)
    # @param variant [Symbol] Alert variant (outline/soft/dash)
    # @param icon [String] SVG icon to display before the text
    # @param dismissible [Boolean] Whether to show a close button
    # @param title [String] Optional title for structured alerts
    # @param description [String] Optional description for structured alerts
    # @param vertical [Boolean] Whether to use vertical layout on mobile
    # @param system_arguments [Hash] Additional HTML attributes to be applied to the alert
    def initialize(
      text: nil,
      color: nil,
      variant: nil,
      icon: nil,
      dismissible: false,
      title: nil,
      description: nil,
      vertical: false,
      **system_arguments
    )
      @text = text
      @color = build_argument(color, COLORS, 'color') if color
      @variant = build_argument(variant, VARIANTS, 'variant') if variant
      @dismissible = dismissible
      @title = title
      @description = description
      @vertical = vertical

      # Set up icon if explicitly provided
      if icon
        with_icon { icon }
      end

      super(**system_arguments)
    end

    def call
      tag.div(**html_attributes) do
        safe_join([icon, content_area, actions].compact)
      end
    end

    delegate :to_s, to: :call

    private

    def computed_classes
      modifiers = ['alert']
      modifiers << @color if @color
      modifiers << @variant if @variant
      modifiers << 'alert-vertical sm:alert-horizontal' if @vertical

      class_names(modifiers, system_arguments[:class])
    end

    def html_attributes
      attrs = system_arguments.except(:class)
      attrs[:class] = computed_classes
      attrs[:role] = 'alert'
      attrs
    end

    def content_area
      return content if content

      if @title || @description
        structured_content
      elsif @text
        tag.span(@text)
      end
    end

    def structured_content
      tag.div do
        safe_join([
          (@title ? tag.h3(@title, class: 'font-bold') : nil),
          (@description ? tag.div(@description, class: 'text-xs') : nil)
        ].compact)
      end
    end


  end
end
