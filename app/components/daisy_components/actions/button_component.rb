# frozen_string_literal: true

module DaisyComponents
  module Actions
    # Button component implementing DaisyUI's button styles
    #
    # @example Basic usage
    #   <%= render(ButtonComponent.new(text: "Click me")) %>
    #
    # @example With block content
    #   <%= render(ButtonComponent.new) do %>
    #     Complex <strong>content</strong>
    #   <% end %>
    #
    # @example As a link
    #   <%= render(ButtonComponent.new(
    #     text: "Visit site",
    #     href: "https://example.com",
    #     target: "_blank"
    #   )) %>
    #
    # @example Form submit button
    #   <%= render(ButtonComponent.new(
    #     text: "Submit",
    #     type: "submit",
    #     variant: "primary"
    #   )) %>
    #
    # @example Delete action with Turbo
    #   <%= render(ButtonComponent.new(
    #     text: "Delete",
    #     href: item_path(@item),
    #     method: :delete,
    #     variant: "error"
    #   )) %>
    class ButtonComponent < BaseComponent
      # Available button variants from DaisyUI
      VARIANTS = %w[neutral primary secondary accent info success warning error ghost link].freeze

      # Available button sizes from DaisyUI
      SIZES = %w[lg md sm xs].freeze

      # Valid HTML button types
      BUTTON_TYPES = %w[button submit reset].freeze

      # @param text [String] Button text (optional if block given)
      # @param variant [String] Button style variant
      # @param size [String] Button size
      # @param disabled [Boolean] Whether the button is disabled
      # @param href [String] URL for link buttons
      # @param type [String] Button type for form buttons
      # @param method [String] HTTP method for Rails/Turbo links
      # @param target [String] Target for link buttons
      # @param rel [String] Rel attribute for link buttons
      # @param loading [Boolean] Whether to show loading state
      # @param active [Boolean] Whether button appears pressed
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(
        text: nil,
        variant: nil,
        size: nil,
        disabled: false,
        href: nil,
        type: 'button',
        method: nil,
        target: nil,
        rel: nil,
        loading: false,
        active: false,
        **system_arguments
      )
        @text = text
        @variant = variant if VARIANTS.include?(variant.to_s)
        @size = size if SIZES.include?(size.to_s)
        @disabled = disabled
        @href = href
        @type = BUTTON_TYPES.include?(type.to_s) ? type : 'button'
        @method = method
        @target = target
        @rel = rel
        @loading = loading
        @active = active
        super(**system_arguments)
      end

      def call
        if @href
          link_tag
        else
          button_tag
        end
      end

      private

      def button_tag
        tag.button(**button_arguments) { content || @text }
      end

      def link_tag
        tag.a(**link_arguments) { content || @text }
      end

      def shared_arguments
        classes = class_names(
          'btn',
          "btn-#{@variant}" => @variant,
          "btn-#{@size}" => @size,
          'btn-disabled' => @disabled,
          'loading' => @loading,
          'btn-active' => @active
        )

        {
          class: [classes, system_arguments[:class]].compact.join(' '),
          disabled: @disabled,
          'aria-disabled': @disabled,
          'aria-busy': @loading,
          role: @href ? 'button' : nil,
          **system_arguments.except(:class)
        }
      end

      def button_arguments
        shared_arguments.merge(
          type: @type,
          name: @disabled || @loading ? nil : system_arguments[:name]
        ).compact
      end

      def link_arguments
        shared_arguments.merge(
          href: @disabled || @loading ? nil : @href,
          data: { turbo_method: @method }.compact,
          target: @target,
          rel: link_rel,
          tabindex: @disabled ? '-1' : '0'
        ).compact
      end

      def link_rel
        return @rel if @rel

        'noopener noreferrer' if @target == '_blank'
      end
    end
  end
end
