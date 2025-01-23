# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class CardComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_card
        render_preview(:default, from: CardComponentPreview)
        assert_selector '.card.bg-base-100.w-96.shadow-xl'
        assert_selector '.card-body'
        assert_text 'Card Title'
        assert_text 'Card content goes here.'
      end

      def test_renders_with_image
        render_preview(:with_image, from: CardComponentPreview)
        assert_selector '.card figure img[src="https://placehold.co/400x200"]'
        assert_selector '.card-title', text: 'Image Card'
        assert_text 'Here is a description of the image above.'
        assert_selector '.card-actions .btn', text: 'View Details'
      end

      def test_renders_side_image_card
        render_preview(:side_image, from: CardComponentPreview)
        assert_selector '.card.card-side'
        assert_selector '.card figure img[src="https://placehold.co/200x200"]'
        assert_selector '.card-title', text: 'Side Image Card'
        assert_text 'This card uses a side image layout.'
        assert_selector '.card-actions .btn', text: 'Learn More'
      end

      def test_renders_bordered_card
        render_preview(:bordered, from: CardComponentPreview)
        assert_selector '.card.card-bordered'
        assert_text 'This card has a border.'
      end

      def test_renders_glass_card
        render_preview(:glass, from: CardComponentPreview)
        assert_selector '.card.glass'
        assert_text 'This card has a glass effect.'
      end

      def test_renders_image_full_card
        render_preview(:image_full, from: CardComponentPreview)
        assert_selector '.card.image-full'
        assert_selector '.card figure img[src="https://placehold.co/400x200"]'
        assert_selector '.card-title', text: 'Full Image Card'
        assert_text 'This card has a full image background.'
        assert_selector '.card-actions .btn', text: 'Read More'
      end

      def test_renders_compact_card
        render_preview(:compact, from: CardComponentPreview)
        assert_selector '.card.card-compact'
        assert_text 'This card uses compact padding.'
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, from: CardComponentPreview,
                                    params: { style: :side,
                                              bordered: true,
                                              glass: true,
                                              image_full: true,
                                              title: 'Custom Title',
                                              description: 'Custom Description',
                                              image_url: 'https://placehold.co/300x300',
                                              button_text: 'Custom Action' })

        assert_selector '.card.card-side.card-bordered.glass.image-full'
        assert_selector '.card figure img[src="https://placehold.co/300x300"]'
        assert_selector '.card-title', text: 'Custom Title'
        assert_text 'Custom Description'
        assert_selector '.card-actions .btn', text: 'Custom Action'
      end

      # Edge cases and special features
      def test_handles_invalid_style
        render_inline(CardComponent.new(style: :invalid)) do |component|
          component.with_body do |body|
            body.with_description { 'Content' }
          end
        end

        assert_selector '.card.card-normal'
        assert_text 'Content'
      end

      def test_renders_custom_classes
        render_inline(CardComponent.new(class: 'custom-class')) do |component|
          component.with_body do |body|
            body.with_description { 'Content' }
          end
        end

        assert_selector '.card.custom-class'
      end

      def test_renders_with_custom_title_tag
        render_inline(CardComponent.new) do |component|
          component.with_body do |body|
            body.with_title(tag_name: :h3) { 'Custom Title' }
          end
        end

        assert_selector '.card-body h3.card-title', text: 'Custom Title'
      end
    end
  end
end
