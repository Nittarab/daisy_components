# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # @label Card
    # @display bg_color "#fff"
    class CardComponentPreview < Lookbook::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive card component with customizable content and styling
      #
      # @param style select [normal, compact, side] "Card layout style"
      # @param bordered toggle "Add a border around the card"
      # @param glass toggle "Apply a glass morphism effect"
      # @param image_full toggle "Make the figure/image span full width"
      # @param title text "Card title"
      # @param description text "Card description"
      # @param image_url text "URL for the card image"
      # @param button_text text "Text for the action button"
      def playground(
        style: :normal,
        bordered: false,
        glass: false,
        image_full: false,
        title: 'Card Title',
        description: 'Card content goes here.',
        image_url: 'https://placehold.co/400x200',
        button_text: 'Action'
      )
        render(
          CardComponent.new(
            style: style,
            bordered: bordered,
            glass: glass,
            image_full: image_full
          )
        ) do |component|
          component.with_figure { tag.img(src: image_url) } if image_url.present?

          component.with_body(description: description) do |body|
            body.with_title { title } if title.present?
            if button_text.present?
              body.with_actions do
                tag.button(button_text, class: 'btn btn-primary')
              end
            end
          end
        end
      end

      # @!group Variants

      # Basic Card
      # ---------------
      # Basic card with title and description
      #
      # @label Default
      def default
        render CardComponent.new do |component|
          component.with_body(description: 'Card content goes here.') do |body|
            body.with_title { 'Card Title' }
          end
        end
      end

      # Card with Image
      # ---------------
      # Card with an image, title, description and action button
      #
      # @label With Image
      def with_image
        render CardComponent.new do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/400x200') }
          component.with_body(description: 'Here is a description of the image above.') do |body|
            body.with_title { 'Image Card' }
            body.with_actions do
              tag.button('View Details', class: 'btn btn-primary')
            end
          end
        end
      end

      # Side Image Layout
      # ---------------
      # Card with image placed on the side
      #
      # @label Side Image
      def side_image
        render CardComponent.new(style: :side) do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/200x200') }
          component.with_body(description: 'This card uses a side image layout.') do |body|
            body.with_title { 'Side Image Card' }
            body.with_actions do
              tag.button('Learn More', class: 'btn btn-primary')
            end
          end
        end
      end

      # Card with Border
      # ---------------
      # Card with a border around its edges
      #
      # @label Bordered
      def bordered
        render CardComponent.new(bordered: true) do |component|
          component.with_body(description: 'This card has a border.')
        end
      end

      # Glass Effect
      # ---------------
      # Card with glass morphism effect
      #
      # @label Glass
      def glass
        render CardComponent.new(glass: true) do |component|
          component.with_body(description: 'This card has a glass effect.')
        end
      end

      # Full Width Image
      # ---------------
      # Card with image spanning full width
      #
      # @label Image Full
      def image_full
        render CardComponent.new(image_full: true) do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/400x200') }
          component.with_body(description: 'This card has a full image background.') do |body|
            body.with_title { 'Full Image Card' }
            body.with_actions do
              tag.button('Read More', class: 'btn btn-primary')
            end
          end
        end
      end

      # Compact Layout
      # ---------------
      # Card with reduced padding
      #
      # @label Compact
      def compact
        render CardComponent.new(style: :compact) do |component|
          component.with_body(description: 'This card uses compact padding.')
        end
      end
    end
  end
end
