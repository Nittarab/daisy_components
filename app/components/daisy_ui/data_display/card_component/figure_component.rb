# frozen_string_literal: true

module DaisyUI
  module DataDisplay
    class CardComponent
      # Figure component for the card, handling image display
      #
      # @example Basic usage with URL
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_figure(img_url: "https://picsum.photos/400/200") %>
      #   <% end %>
      #
      # @example Custom image tag
      #   <%= render(CardComponent.new) do |component| %>
      #     <% component.with_figure do |figure| %>
      #       <% figure.with_image do %>
      #         <%= image_tag "custom.jpg", class: "rounded-xl" %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      class FigureComponent < BaseComponent
        # Image is a content slot that can contain any image content
        renders_one :image

        # @param img_url [String] URL for the card image
        # @param alt [String] Alt text for the image
        # @param system_arguments [Hash] Additional HTML attributes
        def initialize(img_url: nil, img_alt: nil, **system_arguments)
          @img_url = img_url
          @img_alt = img_alt
          super(**system_arguments)
        end

        def before_render
          with_image { tag.img(src: @img_url, alt: @img_alt) } if @img_url && !image?
        end

        def call
          tag.figure(**system_arguments) do
            safe_join([image, content].compact)
          end
        end
      end
    end
  end
end
