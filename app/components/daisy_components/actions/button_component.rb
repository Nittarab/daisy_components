# frozen_string_literal: true

module DaisyComponents
  module Actions
    # Button component implementing DaisyUI's button styles
    #
    # @example Basic usage
    #   <%= render(ButtonComponent.new(text: "Click me")) %>
    #
    # @example With icons
    #   <%= render(ButtonComponent.new(
    #     text: "Submit",
    #     icon_start: helpers.check_icon("h-5 w-5"),
    #     variant: "primary"
    #   )) %>
    #
    # @example With both icons
    #   <%= render(ButtonComponent.new(
    #     text: "Next",
    #     icon_start: helpers.sync_icon("h-5 w-5"),
    #     icon_end: helpers.arrow_right_icon("h-5 w-5")
    #   )) %>
    #
    # @example Icon only button
    #   <%= render(ButtonComponent.new(
    #     icon_start: helpers.search_icon("h-6 w-6"),
    #     class: "btn-square"
    #   )) %>
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
    class ButtonComponent < BaseComponent # rubocop:disable Metrics/ClassLength
      renders_one :start_icon
      renders_one :end_icon

      # Available button variants from DaisyUI
      VARIANTS = %w[neutral primary secondary accent info success warning error ghost link].freeze

      # Available button sizes from DaisyUI
      SIZES = %w[lg md sm xs].freeze

      # Valid HTML button types
      BUTTON_TYPES = %w[button submit reset].freeze

      # @param text [String] The text content to display inside the button
      # @param variant [String] Visual style of the button
      #    (neutral/primary/secondary/accent/info/success/warning/error/ghost/link)
      # @param size [String] Size of the button (lg/md/sm/xs)
      # @param disabled [Boolean] When true, prevents user interaction and grays out the button
      # @param href [String] Turns the button into a link pointing to this URL
      # @param type [String] HTML button type attribute (button/submit/reset)
      # @param method [String] HTTP method for Rails/Turbo links (get/post/put/patch/delete)
      # @param target [String] Link target attribute (_blank/_self/_parent/_top)
      # @param rel [String] Link relationship attribute (e.g., noopener, noreferrer)
      # @param loading [Boolean] When true, shows a loading spinner and disables the button
      # @param active [Boolean] When true, gives the button a pressed appearance
      # @param icon_start [String] SVG icon to display before the text
      # @param icon_end [String] SVG icon to display after the text
      # @param system_arguments [Hash] Additional HTML attributes to be applied to the button
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
        icon_start: nil,
        icon_end: nil,
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

        with_start_icon { icon_start } if icon_start
        with_end_icon { icon_end } if icon_end

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
        tag.button(**button_arguments) { button_content }
      end

      def link_tag
        tag.a(**link_arguments) { button_content }
      end

      def button_content
        parts = []
        parts << start_icon if start_icon
        parts << (content || @text)
        parts << end_icon if end_icon
        safe_join(parts)
      end

      def shared_arguments
        {
          class: computed_classes,
          disabled: @disabled || @loading,
          'aria-disabled': @disabled || @loading,
          'aria-busy': @loading,
          role: @href ? 'button' : nil,
          **system_arguments.except(:class)
        }
      end

      def computed_classes
        base_classes = class_names(
          'btn',
          "btn-#{@variant}" => @variant,
          "btn-#{@size}" => @size,
          'btn-disabled' => @disabled || @loading,
          'loading' => @loading,
          'btn-active' => @active,
          'gap-2' => icon_and_content?
        )

        [base_classes, system_arguments[:class]].compact.join(' ')
      end

      def icon_and_content?
        (start_icon || end_icon) && (@text || content)
      end

      def button_arguments
        shared_arguments.merge(
          type: @type,
          name: @disabled || @loading ? nil : system_arguments[:name]
        ).compact
      end

      def link_arguments
        shared_arguments.merge(
          href: @href,
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
