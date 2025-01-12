# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class CardComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_card
        render_inline(CardComponent.new) do |component|
          component.with_body(description: 'Content')
        end

        assert_selector '.card.bg-base-100.w-96.shadow-xl'
        assert_selector '.card-body'
        assert_selector 'p', text: 'Content'
      end

      def test_renders_card_with_all_slots
        render_inline(CardComponent.new) do |component|
          component.with_figure { tag.img(src: 'test.jpg') }
          component.with_body(description: 'Content') do |body|
            body.with_title { 'Title' }
            body.with_actions { 'Actions' }
          end
        end

        assert_selector '.card'
        assert_selector 'figure img[src="test.jpg"]'
        assert_selector '.card-body'
        assert_selector '.card-title', text: 'Title'
        assert_selector 'p', text: 'Content'
        assert_selector '.card-actions.justify-end', text: 'Actions'
      end

      def test_renders_side_image_card
        render_inline(CardComponent.new(style: :side)) do |component|
          component.with_figure { tag.img(src: 'test.jpg') }
          component.with_body(description: 'Content') do |body|
            body.with_title { 'Title' }
            body.with_actions { 'Actions' }
          end
        end

        assert_selector '.card.card-side'
        assert_selector '.card-body.flex.flex-col.justify-between'
        assert_selector 'p', text: 'Content'
      end

      def test_applies_variants
        render_inline(CardComponent.new(bordered: true, glass: true, image_full: true)) do |component|
          component.with_body(description: 'Content')
        end

        assert_selector '.card.card-bordered.glass.image-full'
        assert_selector 'p', text: 'Content'
      end

      def test_renders_compact_style
        render_inline(CardComponent.new(style: :compact)) do |component|
          component.with_body(description: 'Content')
        end

        assert_selector '.card.card-compact'
        assert_selector 'p', text: 'Content'
      end

      def test_handles_invalid_style
        render_inline(CardComponent.new(style: :invalid)) do |component|
          component.with_body(description: 'Content')
        end

        assert_selector '.card.card-normal'
        assert_selector 'p', text: 'Content'
      end

      def test_renders_custom_classes
        render_inline(CardComponent.new(class: 'custom-class')) do |component|
          component.with_body(description: 'Content')
        end

        assert_selector '.card.custom-class'
      end
    end
  end
end
