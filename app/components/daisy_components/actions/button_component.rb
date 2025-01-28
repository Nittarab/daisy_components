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
      STYLES = %w[outline soft dash].freeze

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
        tag_type = @href ? :a : :button
        if simple?
          tag.send(tag_type, button_content, **simple_arguments)
        else
          tag.send(tag_type, **full_arguments) { button_content }
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

      def simple?
        !@variant && !@style && !@size && !@shape && !@disabled && !@loading && !@active &&
          system_arguments.keys.empty? && (@type == 'button' || @href) && !@class &&
          !@method && !@target && !@rel
      end

      def simple_arguments
        {
          class: 'btn',
          role: (@href ? 'button' : nil),
          href: @href
        }.compact
      end

      def full_arguments
        base = {
          class: computed_classes,
          disabled: @disabled || @loading,
          'aria-disabled': @disabled || @loading,
          'aria-busy': @loading,
          **system_arguments.except(:class)
        }

        @href ? link_specific_arguments(base) : button_specific_arguments(base)
      end

      def button_specific_arguments(base)
        base.merge(type: @type).compact
      end

      def link_specific_arguments(base)
        base.merge(
          role: 'button',
          href: @href,
          data: { turbo_method: @method }.compact,
          target: @target,
          rel: link_rel,
          tabindex: @disabled ? '-1' : '0'
        ).compact
      end

      def button_content
        safe_join([
          start_icon,
          content || @text,
          end_icon
        ].compact)
      end

      def computed_classes
        return @class if @class

        # Order: base -> style/state -> variant -> size -> shape
        modifiers = []
        modifiers << 'btn'
        modifiers << "btn-#{@style}" if @style
        modifiers << 'btn-active' if @active
        modifiers << "btn-#{@variant}" if @variant
        modifiers << "btn-#{@size}" if @size
        modifiers << "btn-#{@shape}" if @shape
        modifiers << 'loading' if @loading
        modifiers << 'gap-2' if icon_and_content? && !content.present?

        class_names(modifiers.join(' '), system_arguments[:class])
      end

      def icon_and_content?
        (start_icon || end_icon) && (@text || content)
      end

      def link_rel
        return @rel if @rel

        'noopener noreferrer' if @target == '_blank'
      end
    end
  end
end
