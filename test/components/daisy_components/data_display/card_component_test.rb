# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class CardComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_card
        render_inline(CardComponent.new) do |component|
          component.with_body { 'Card content' }
        end

        assert_selector('.card')
        assert_selector('.card-body', text: 'Card content')
      end

      def test_renders_with_figure
        render_inline(CardComponent.new) do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/400x200') }
          component.with_body { 'Card content' }
        end

        assert_selector('.card img[src="https://placehold.co/400x200"]')
      end

      def test_renders_with_title
        render_inline(CardComponent.new) do |component|
          component.with_body do |body|
            body.with_title('Card Title')
            'Card content'
          end
        end

        assert_selector('.card-title', text: 'Card Title')
        assert_selector('.card-body', text: 'Card content')
      end

      def test_renders_with_actions
        render_inline(CardComponent.new) do |component|
          component.with_body { 'Card content' }
          component.with_actions do
            'Card actions'
          end
        end

        assert_selector('.card-actions', text: 'Card actions')
      end

      def test_renders_with_bordered_style
        render_inline(CardComponent.new(bordered: true)) do |component|
          component.with_body { 'Card content' }
        end

        assert_selector('.card.card-bordered')
      end

      def test_renders_with_image_full
        render_inline(CardComponent.new(image_full: true)) do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/400x200') }
          component.with_body { 'Card content' }
        end

        assert_selector('.card.image-full')
      end

      def test_renders_with_compact_style
        render_inline(CardComponent.new(style: :compact)) do |component|
          component.with_body { 'Card content' }
        end

        assert_selector('.card.card-compact')
      end

      def test_renders_with_side_style
        render_inline(CardComponent.new(style: :side)) do |component|
          component.with_figure { tag.img(src: 'https://placehold.co/400x200') }
          component.with_body { 'Card content' }
        end

        assert_selector('.card.card-side')
      end

      def test_renders_with_glass_effect
        render_inline(CardComponent.new(glass: true)) do |component|
          component.with_body { 'Card content' }
        end

        assert_selector('.card.glass')
      end

      def test_renders_with_custom_classes
        render_inline(CardComponent.new(class: 'custom-class')) do |component|
          component.with_body { 'Card content' }
        end

        assert_selector('.card.custom-class')
      end

      def test_renders_with_justified_actions
        render_inline(CardComponent.new) do |component|
          component.with_body { 'Card content' }
          component.with_actions(justify: 'between') do
            'Card actions'
          end
        end

        assert_selector('.card-actions.justify-between')
      end

      def test_renders_with_custom_title_tag
        render_inline(CardComponent.new) do |component|
          component.with_body do |body|
            body.with_title('Card Title', tag_name: :h3)
            'Card content'
          end
        end

        assert_selector('h3.card-title', text: 'Card Title')
      end
    end
  end
end
