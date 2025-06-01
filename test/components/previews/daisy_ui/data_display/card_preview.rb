# frozen_string_literal: true

module DaisyUI
  module DataDisplay
    # @label Card
    # @display bg_color "#fff"
    class CardPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper
      # @!group Playground

      # Playground
      # ---------------
      # Interactive card component with customizable content and styling
      #
      # @param variant select [compact, side, bordered] "Card layout variant"
      # @param image_full toggle "Make the figure/image span full width"
      # @param title text "Card title"
      # @param description text "Card description"
      # @param img_url text "URL for the card image" default: "https://picsum.photos/400/200"
      # @param button_text text "Text for the action button"
      # @param button_color select [primary, secondary, accent, neutral, ghost, link, info, success, warning, error] "Button color"
      # @param button_variant select [outline, soft, dash, ghost, link] "Button variant"
      # @param button_size select [xs, sm, md, lg, xl] "Button size"
      # @param button_justify select [start, end, center, between, around, evenly] "Button justification"
      # @param bottom_image toggle "Display the image at the bottom of the card"
      def playground(
        variant: nil,
        image_full: false,
        title: 'Card Title',
        description: 'Card content goes here.',
        img_url: 'https://picsum.photos/seed/card/400/200',
        img_alt: 'Card image',
        button_text: 'Action',
        button_color: :primary,
        button_variant: nil,
        button_size: nil,
        button_justify: :end,
        bottom_image: false
      )
        render DaisyUI::Card.new(
          variant: variant,
          image_full: image_full,
          img_url: img_url,
          img_alt: img_alt,
          title: title,
          description: description,
          bottom_image: bottom_image,
          button: {
            text: button_text,
            color: button_color,
            variant: button_variant,
            size: button_size,
            justify: button_justify
          }
        )
      end

      # @!endgroup

      def card_sizes
        render_with_template
      end

      # Card with a card border
      # ---------------
      # Example of a card with a card-style border
      def card_with_a_card_border
        render DaisyUI::Card.new(
          title: 'Card Title',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: { text: 'Buy Now', color: :primary, justify: :end },
          variant: :bordered
        )
      end

      # Card with a dash border
      # ---------------
      # Example of a card with a dashed border
      def card_with_a_dash_border
        render DaisyUI::Card.new(
          title: 'Card Title',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: { text: 'Buy Now', color: :primary, justify: :end },
          variant: :dash
        )
      end

      # # Card with badge
      # # ---------------
      # # Card with badges in title and actions
      def card_with_badge
        render_with_template
      end

      # Card with bottom image
      # ---------------
      # Card with image displayed at the bottom
      def card_with_bottom_image
        render DaisyUI::Card.new(
          title: 'Card Title',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          img_url: 'https://picsum.photos/seed/card/400/200',
          img_alt: 'Card image',
          bottom_image: true,
          shadow: true
        )
      end

      # # Card with centered content and paddings
      # # ---------------
      # # Card with centered content and image padding
      def card_with_centered_content_and_paddings
        render_with_template
      end

      # # Card with custom color
      # # ---------------
      # # Card with primary background color
      def card_with_custom_color
        render DaisyUI::Card.new(
          title: 'Card title!',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: { text: 'Buy Now', justify: :end },
          color: :primary
        )
      end

      # Card with image on side
      # ---------------
      # Card with image displayed on the side
      def card_with_image_on_side
        render DaisyUI::Card.new(
          variant: :side,
          title: 'New movie is released!',
          description: 'Click the button to watch on Jetflix app.',
          button: { text: 'Watch', justify: :end, color: :primary },
          img_url: 'https://picsum.photos/seed/card/400/200',
          img_alt: 'Movie',
          shadow: true
        )
      end

      # # Card with image overlay
      # # ---------------
      # # Card with image as a full background
      def card_with_image_overlay
        render DaisyUI::Card.new(
          image_full: true,
          title: 'Card Title',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: { text: 'Buy Now', color: :primary, justify: :end },
          img_url: 'https://picsum.photos/seed/card/400/200',
          img_alt: 'Card image',
          shadow: true
        )
      end

      # Card with no image
      # ---------------
      # Basic card without an image
      def card_with_no_image
        render DaisyUI::Card.new(
          title: 'Card title!',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: { text: 'Buy Now', color: :primary, justify: :end },
          shadow: true
        )
      end

      # Default card
      # ---------------
      # Basic card with title, description, image and actions
      def card
        render DaisyUI::Card.new(
          img_url: 'https://picsum.photos/seed/card/400/200',
          title: 'Card Title',
          description: 'A card component has a figure, a body part, and inside body there are title and actions parts',
          button: {
            text: 'Buy Now',
            color: :primary,
            justify: :end
          },
          shadow: true
        )
      end

      # Centered card with neutral color
      # ---------------
      # Card with centered content and neutral background color
      def centered_card_with_neutral_color
        render DaisyUI::Card.new(
          title: 'Cookies!',
          description: 'We are using cookies for no reason.',
          color: :neutral
        ) do |component|
          component.with_body(class: 'items-center text-center') do |body|
            body.with_actions(justify: :end) do |actions|
              actions.with_button(text: 'Accept', color: :primary)
              actions.with_button(text: 'Deny', color: :ghost)
            end
          end
        end
      end

      # Pricing card
      # ---------------
      # Card with pricing information and feature list
      def pricing_card
        render_with_template(locals: { helpers: self })
      end

      # Responsive card
      # ---------------
      # # Card that changes layout based on screen size
      def responsive_card_vertical_on_small_screen_horizontal_on_large_screen
        render DaisyUI::Card.new(
          title: 'New album is released!',
          description: 'Click the button to listen on Spotiwhy app.',
          button: { text: 'Listen', color: :primary, justify: :end },
          img_url: 'https://img.daisyui.com/images/stock/photo-1494232410401-ad00d5433cfa.webp',
          img_alt: 'Album',
          shadow: true,
          variant: :side_responsive
        )
      end

      # def responsive_card_vertical_on_small_screen_horizontal_on_large_screen
    end
  end
end
