# frozen_string_literal: true

module DaisyUI
  # Card component for displaying content in a contained card format
  #
  # @example Basic usage with simple button
  #   <%= render(CardComponent.new(
  #     title: "Card Title",
  #     description: "Card description here",
  #     button: { text: "Action", color: :primary, justify: :end }
  #   )) %>
  #
  # @example With figure/image
  #   <%= render(CardComponent.new(
  #     img_url: "https://picsum.photos/400/200"
  #   )) %>
  #
  # @example Bordered variant
  #   <%= render(CardComponent.new(variant: :bordered)) do |component| %>
  #     <% component.with_body(title: "Bordered Card") %>
  #   <% end %>
  #
  # @example Side image variant
  #   <%= render(CardComponent.new(
  #     variant: :side,
  #     img_url: "https://picsum.photos/200/400"
  #   )) do |component| %>
  #     <% component.with_body do |body| %>
  #       <% body.with_title { "Side Image" } %>
  #     <% end %>
  #   <% end %>
  #
  # @example With actions
  #   <%= render(CardComponent.new) do |component| %>
  #     <% component.with_body do |body| %>
  #       <% body.with_title { "Card with Actions" } %>
  #       <% body.with_actions(justify: :between) do %>
  #         <%= render(ButtonComponent.new(text: "Action")) %>
  #       <% end %>
  #     <% end %>
  #   <% end %>
  class CardComponent < BaseComponent
    # Available card variants
    VARIANTS = {
      compact: 'card-compact',
      side: 'card-side',
      side_responsive: 'lg:card-side',
      bordered: 'card-border',
      dash: 'card-dash'
    }.freeze

    COLORS = {
      primary: 'bg-primary text-primary-content',
      secondary: 'bg-secondary text-secondary-content',
      accent: 'bg-accent text-accent-content',
      neutral: 'bg-neutral text-neutral-content',
      base: 'bg-base-100'
    }.freeze

    SIZES = {
      xs: 'card-xs',
      sm: 'card-sm',
      md: 'card-md',
      lg: 'card-lg',
      xl: 'card-xl'
    }.freeze

    renders_one :figure, lambda { |**system_arguments|
      FigureComponent.new(img_url: @img_url, img_alt: @img_alt, **system_arguments)
    }

    renders_one :body, lambda { |**system_arguments|
      BodyComponent.new(
        variant: @variant,
        title: @title,
        description: @description,
        button: @button,
        **system_arguments
      )
    }

    # @param variant [Symbol] Card layout variant (:compact, :side, :bordered)
    # @param image_full [Boolean] Makes the image cover the full card
    # @param title [String] Card title (optional)
    # @param description [String] Card description (optional)
    # @param button [Hash] Simple button configuration (optional)
    # @option button [String] :text Button text
    # @option button [Symbol] :color Button color (primary, secondary, etc)
    # @option button [Symbol] :variant Button variant (outline, soft, etc)
    # @option button [Symbol] :size Button size (xs, sm, md, lg, xl)
    # @option button [Symbol] :justify Button justification (start, end, center, between, around, evenly)
    # @param img_url [String] URL for the card image (optional)
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize(variant: nil,
                   image_full: false,
                   title: nil,
                   description: nil,
                   button: nil,
                   img_url: nil,
                   img_alt: nil,
                   bottom_image: false,
                   shadow: false,
                   size: nil,
                   color: :base,
                   **system_arguments)
      @variant = build_argument(variant, VARIANTS, 'variant')
      @color = build_argument(color, COLORS, 'color')
      @size = build_argument(size, SIZES, 'size')
      @image_full = image_full
      @title = title
      @description = description
      @button = button
      @img_url = img_url
      @img_alt = img_alt
      @shadow = shadow
      @bottom_image = bottom_image
      super(**system_arguments)
    end

    def before_render
      with_figure if @img_url && !figure?
      with_body unless body?
    end

    def call
      tag.div(**html_attributes) do
        safe_join(render_in_oder)
      end
    end

    def render_in_oder
      if @bottom_image
        [body, figure].compact
      else
        [figure, body].compact
      end
    end

    private

    def computed_classes
      modifiers = %w[card]
      modifiers << @color if @color.present?
      modifiers << @variant if @variant.present?
      modifiers << 'image-full' if @image_full
      modifiers << 'shadow-sm' if @shadow
      modifiers << 'w-96' unless @variant.in?([VARIANTS[:side], VARIANTS[:side_responsive]])
      modifiers << @size if @size.present?
      class_names(modifiers, system_arguments[:class])
    end

    def html_attributes
      safe_args = system_arguments.except(:bottom_image)
      safe_args.merge(class: computed_classes)
    end
  end
end
