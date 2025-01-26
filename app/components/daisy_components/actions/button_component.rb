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
      VARIANTS = %w[primary secondary accent neutral ghost link info success warning error].freeze

      # Available button sizes from DaisyUI
      SIZES = %w[xl lg md sm xs].freeze

      # Available button styles from DaisyUI
      STYLES = %w[outline soft].freeze

      # Available button shape modifiers
      SHAPES = %w[wide block circle square].freeze

      # Valid HTML button types
      BUTTON_TYPES = %w[button submit reset].freeze

      # @param text [String] The text content to display inside the button
      # @param variant [String] Visual style of the button
      #    (neutral/primary/secondary/accent/info/success/warning/error/ghost/link)
      # @param size [String] Size of the button (xl/lg/md/sm/xs)
      # @param style [String] Style of the button (outline/soft)
      # @param shape [String] Shape modifier of the button (wide/block/circle/square)
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
      def initialize( # rubocop:disable Metrics/ParameterLists
        text: nil,
        variant: nil,
        size: nil,
        style: nil,
        shape: nil,
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
        validate_and_assign_attributes(variant, size, style, shape, type)

        @disabled = disabled
        @href = href
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

      def validate_and_assign_attributes(variant, size, style, shape, type)
        @variant = validate_attribute(variant, VARIANTS, 'variant')
        @size = validate_attribute(size, SIZES, 'size')
        @style = validate_attribute(style, STYLES, 'style')
        @shape = validate_attribute(shape, SHAPES, 'shape')
        @type = BUTTON_TYPES.include?(type.to_s) ? type : 'button'
      end

      def validate_attribute(value, valid_values, attr_name)
        return value if !value || valid_values.include?(value.to_s)

        raise ArgumentError, "Invalid #{attr_name}: #{value}. Must be one of: #{valid_values.join(', ')}"
      end

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
          "btn-#{@style}" => @style,
          "btn-#{@shape}" => @shape,
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
