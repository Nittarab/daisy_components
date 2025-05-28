# frozen_string_literal: true

module DaisyUI
  # Badge component implementing DaisyUI's badge styles
  #
  # @example Basic usage
  #   <%= render(BadgeComponent.new(text: "Badge")) %>
  #
  # @example Primary variant
  #   <%= render(BadgeComponent.new(text: "Primary", color: :primary)) %>
  #
  # @example Outline style
  #   <%= render(BadgeComponent.new(text: "Outline", variant: :outline)) %>
  #
  # @example Small size with icon
  #   <%= render(BadgeComponent.new(
  #     text: "Icon",
  #     size: :sm,
  #     icon: helpers.check_icon
  #   )) %>
  #
  # @example Soft style with color
  #   <%= render(BadgeComponent.new(
  #     text: "Soft",
  #     variant: :soft,
  #     color: :primary
  #   )) %>
  #
  # @example With block content
  #   <%= render(BadgeComponent.new) do %>
  #     Complex <strong>content</strong>
  #   <% end %>
  #
  # @example With custom tag type
  #   <%= render(BadgeComponent.new(text: "Badge", tag_type: :span)) %>
  class Badge < DaisyUI::BaseComponent
    renders_one :icon

    # Available badge colors from DaisyUI
    COLORS = {
      primary: 'badge-primary',
      secondary: 'badge-secondary',
      accent: 'badge-accent',
      neutral: 'badge-neutral',
      ghost: 'badge-ghost',
      info: 'badge-info',
      success: 'badge-success',
      warning: 'badge-warning',
      error: 'badge-error'
    }.freeze

    # Available badge sizes from DaisyUI
    SIZES = {
      xl: 'badge-xl',
      lg: 'badge-lg',
      md: 'badge-md',
      sm: 'badge-sm',
      xs: 'badge-xs'
    }.freeze

    # Available badge variants from DaisyUI
    VARIANTS = {
      outline: 'badge-outline',
      soft: 'badge-soft',
      dash: 'badge-dash',
      ghost: 'badge-ghost'
    }.freeze

    # @param text [String] The text content to display inside the badge
    # @param color [String] Visual style of the badge
    #    (neutral/primary/secondary/accent/info/success/warning/error/ghost)
    # @param size [String] Size of the badge (xl/lg/md/sm/xs)
    # @param variant [String] Variant of the badge (outline/soft/dash/ghost)
    # @param icon [String] SVG icon to display before the text
    # @param tag_type [Symbol] HTML tag to use for the badge (default: :div)
    # @param system_arguments [Hash] Additional HTML attributes to be applied to the badge
    def initialize(
      text = nil,
      color: nil,
      size: nil,
      variant: nil,
      icon: nil,
      tag_type: :div,
      **system_arguments
    )
      @text = text
      @color = build_argument(color, COLORS, 'color')
      @size = build_argument(size, SIZES, 'size')
      @variant = build_argument(variant, VARIANTS, 'variant')
      @tag_type = tag_type

      with_icon { icon } if icon
      super(**system_arguments)
    end

    def call
      tag.public_send(@tag_type, **html_attributes) do
        safe_join([icon, content || @text].compact)
      end
    end

    delegate :to_s, to: :call

    private

    def computed_classes
      modifiers = ['badge']
      modifiers << @variant
      modifiers << @color
      modifiers << @size

      class_names(modifiers, system_arguments[:class])
    end

    def html_attributes
      attrs = system_arguments.except(:class)
      attrs[:class] = computed_classes
      attrs
    end
  end
end
