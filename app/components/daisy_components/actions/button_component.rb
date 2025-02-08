# frozen_string_literal: true

module DaisyComponents
  module Actions
    # Button component implementing DaisyUI's button styles
    #
    # @example Basic usage
    #   <%= render(ButtonComponent.new(text: "Click me")) %>
    #
    # @example Primary variant
    #   <%= render(ButtonComponent.new(text: "Submit", variant: :primary)) %>
    #
    # @example Outline button
    #   <%= render(ButtonComponent.new(text: "Download", style: :outline)) %>
    #
    # @example Small size with icon
    #   <%= render(ButtonComponent.new(
    #     text: "Save",
    #     size: :sm,
    #     icon_start: helpers.check_icon
    #   )) %>
    #
    # @example Block-level button
    #   <%= render(ButtonComponent.new(
    #     text: "Full width",
    #     shape: :block
    #   )) %>
    #
    # @example Icon only button
    #   <%= render(ButtonComponent.new(
    #     icon_start: helpers.search_icon,
    #     shape: :square
    #   )) %>
    #
    # @example Loading state
    #   <%= render(ButtonComponent.new(
    #     text: "Processing...",
    #     loading: true
    #   )) %>
    #
    # @example Disabled state
    #   <%= render(ButtonComponent.new(
    #     text: "Disabled",
    #     disabled: true
    #   )) %>
    #
    # @example Active state
    #   <%= render(ButtonComponent.new(
    #     text: "Pressed",
    #     active: true
    #   )) %>
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
      renders_one :start_icon
      renders_one :end_icon

      # Available button colors from DaisyUI
      COLORS = {
        primary: 'btn-primary',
        secondary: 'btn-secondary',
        accent: 'btn-accent',
        neutral: 'btn-neutral',
        ghost: 'btn-ghost',
        link: 'btn-link',
        info: 'btn-info',
        success: 'btn-success',
        warning: 'btn-warning',
        error: 'btn-error'
      }.freeze

      # Available button sizes from DaisyUI
      SIZES = {
        xl: 'btn-xl',
        lg: 'btn-lg',
        md: 'btn-md',
        sm: 'btn-sm',
        xs: 'btn-xs'
      }.freeze

      # Available button variants from DaisyUI
      VARIANTS = {
        outline: 'btn-outline',
        soft: 'btn-soft',
        dash: 'btn-dash',
        ghost: 'btn-ghost',
        link: 'btn-link'
      }.freeze

      # Available button shape modifiers
      SHAPES = {
        wide: 'btn-wide',
        block: 'btn-block',
        circle: 'btn-circle',
        square: 'btn-square'
      }.freeze

      # Valid HTML button types
      BUTTON_TYPES = %w[button submit reset].freeze

      # @param text [String] The text content to display inside the button
      # @param color [String] Visual style of the button
      #    (neutral/primary/secondary/accent/info/success/warning/error/ghost/link)
      # @param size [String] Size of the button (xl/lg/md/sm/xs)
      # @param variant [String] Variant of the button (outline/soft/dash)
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
        tag_type: :button,
        text: nil,
        color: nil,
        size: nil,
        variant: nil,
        shape: nil,
        disabled: false,
        href: nil,
        type: nil,
        method: nil,
        target: nil,
        rel: nil,
        loading: false,
        active: false,
        icon_start: nil,
        icon_end: nil,
        **system_arguments
      )
        @tag_type = tag_type
        @color = build_argument(color, COLORS, 'color')
        @size = build_argument(size, SIZES, 'size')
        @variant = build_argument(variant, VARIANTS, 'variant')
        @shape = build_argument(shape, SHAPES, 'shape')
        @disabled = disabled
        @href = href
        @method = method
        @target = target
        @rel = rel
        @loading = loading
        @active = active
        @type = type
        @text = text

        with_start_icon { icon_start } if icon_start
        with_end_icon { icon_end } if icon_end
        super(**system_arguments)
      end

      def call
        tag.send(@tag_type, **full_arguments) { button_content }
      end

      private

      def build_argument(key, valid_values, attr_name)
        return unless key

        class_name = valid_values[key.to_sym]

        return class_name if class_name

        raise ArgumentError, "Invalid #{attr_name}: #{key}. Must be one of: #{valid_values.keys.join(', ')}"
      end

      def full_arguments
        base = {
          class: computed_classes,
          disabled: @disabled,
          **system_arguments.except(:class)
        }

        @href || @tag_type.to_s == 'a' ? link_specific_arguments(base) : button_specific_arguments(base)
      end

      # Order: base -> style/state(active) -> variant -> size -> shape
      def computed_classes
        modifiers = ['btn']
        modifiers << @variant
        modifiers << 'btn-active' if @active
        modifiers << @color
        modifiers << @size
        modifiers << @shape

        class_names(modifiers, system_arguments[:class])
      end

      def button_specific_arguments(base)
        type = if @tag_type.to_s == 'button'
                 @type || 'button'
               elsif @tag_type.to_s == 'input'
                 @type || 'button'
               else
                 @type
               end
        base.merge(type: type).compact
      end

      def link_specific_arguments(base)
        base.merge(
          role: 'button',
          href: @href,
          data: { turbo_method: @method }.compact,
          target: @target,
          rel: link_rel
        ).compact
      end

      def button_content
        safe_join([
          loading_spinner,
          start_icon,
          content || @text,
          end_icon
        ].compact)
      end

      def link_rel
        return @rel if @rel

        'noopener noreferrer' if @target == '_blank'
      end

      def loading_spinner
        tag.span(class: 'loading loading-spinner') if @loading
      end
    end
  end
end
