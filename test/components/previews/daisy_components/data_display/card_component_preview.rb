# frozen_string_literal: true

module DaisyComponents
  module DataDisplay
    # @label Card
    # @display bg_color "#fff"
    class CardComponentPreview < ViewComponent::Preview
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
      # @param button_class text "CSS classes for the button" default: "btn btn-primary"
      def playground(
        style: :normal,
        bordered: false,
        glass: false,
        image_full: false,
        title: 'Card Title',
        description: 'Card content goes here.',
        image_url: 'https://placehold.co/400x200',
        button_text: 'Action',
        button_class: 'btn btn-primary'
      )
        render CardComponent.new(
          style: style,
          bordered: bordered,
          glass: glass,
          image_full: image_full,
          title: title,
          description: description,
          image_url: image_url,
          button_text: button_text,
          button_class: button_class
        )
      end

      # @!group Variants

      # Basic Card
      # ---------------
      # Basic card with title and description
      #
      # @label Default
      def default
        render CardComponent.new(title: 'Card Title', description: 'Card content goes here.')
      end

      # Card with Image
      # ---------------
      # Card with an image, title, description and action button
      #
      # @label With Image
      def with_image
        render CardComponent.new(
          title: 'Image Card',
          description: 'Here is a description of the image above.',
          image_url: 'https://placehold.co/400x200',
          button_text: 'View Details',
          button_class: 'btn btn-primary'
        )
      end

      # Side Image Layout
      # ---------------
      # Card with image placed on the side
      #
      # @label Side Image
      def side_image
        render CardComponent.new(
          style: :side,
          title: 'Side Image Card',
          description: 'This card uses a side image layout.',
          image_url: 'https://placehold.co/200x200',
          button_text: 'Learn More',
          button_class: 'btn btn-primary'
        )
      end

      # Card with Border
      # ---------------
      # Card with a border around its edges
      #
      # @label Bordered
      def bordered
        render CardComponent.new(
          bordered: true,
          description: 'This card has a border.'
        )
      end

      # Glass Effect
      # ---------------
      # Card with glass morphism effect
      #
      # @label Glass
      def glass
        render CardComponent.new(
          glass: true,
          description: 'This card has a glass effect.'
        )
      end

      # Full Width Image
      # ---------------
      # Card with image spanning full width
      #
      # @label Image Full
      def image_full
        render CardComponent.new(
          image_full: true,
          title: 'Full Image Card',
          description: 'This card has a full image background.',
          image_url: 'https://placehold.co/400x200',
          button_text: 'Read More',
          button_class: 'btn btn-primary'
        )
      end

      # Compact Layout
      # ---------------
      # Card with reduced padding
      #
      # @label Compact
      def compact
        render CardComponent.new(
          style: :compact,
          description: 'This card uses compact padding.'
        )
      end
    end
  end
end
