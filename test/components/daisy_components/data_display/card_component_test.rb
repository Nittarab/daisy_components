# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module DataDisplay
    class CardComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_basic_card
        render_inline(CardComponent.new) do |component|
          component.with_body do |body|
            body.with_description { 'Content' }
          end
        end

        assert_selector '.card.bg-base-100.w-96.shadow-xl'
        assert_selector '.card-body'
        assert_text 'Content'
      end

      def test_renders_figure
        render_inline(CardComponent.new) do |component|
          component.with_figure { tag.img(src: 'test.jpg') }
        end

        assert_selector '.card figure img[src="test.jpg"]'
      end

      def test_renders_body_content
        render_inline(CardComponent.new) do |component|
          component.with_body do |body|
            body.with_title { 'Title' }
            body.with_description { 'Description' }
            body.with_actions { tag.button('Action', class: 'btn') }
          end
        end

        assert_selector '.card-body'
        assert_selector '.card-title', text: 'Title'
        assert_text 'Description'
        assert_selector '.card-actions .btn', text: 'Action'
      end

      # TODO: Fix this test
      # def test_renders_with_complex_description
      #   render_inline(CardComponent.new) do |component|
      #     component.with_body do |body|
      #       body.with_description do
      #         tag.div(class: 'flex gap-2') do
      #           safe_join([
      #                       render_inline(DaisyComponents::DataDisplay::BadgeComponent.new('Badge')).to_html,
      #                       tag.p('Text content')
      #                     ])
      #         end
      #       end
      #     end
      #   end

      #   assert_selector '.card-body .flex.gap-2'
      #   assert_selector '.badge', text: 'Badge'
      #   assert_selector 'p', text: 'Text content'
      # end

      def test_renders_side_image_card
        render_inline(CardComponent.new(style: :side)) do |component|
          component.with_figure { tag.img(src: 'test.jpg') }
          component.with_body do |body|
            body.with_title { 'Title' }
            body.with_description { 'Content' }
            body.with_actions { tag.button('Action', class: 'btn') }
          end
        end

        assert_selector '.card.card-side'
        assert_selector '.card-body.flex.flex-col.justify-between'
        assert_selector '.card-title', text: 'Title'
        assert_text 'Content'
        assert_selector '.card-actions .btn', text: 'Action'
      end

      def test_applies_variants
        render_inline(CardComponent.new(bordered: true, glass: true, image_full: true)) do |component|
          component.with_body do |body|
            body.with_description { 'Content' }
          end
        end

        assert_selector '.card.card-bordered.glass.image-full'
        assert_text 'Content'
      end

      def test_renders_compact_style
        render_inline(CardComponent.new(style: :compact)) do |component|
          component.with_body do |body|
            body.with_description { 'Content' }
          end
        end

        assert_selector '.card.card-compact'
        assert_text 'Content'
      end

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
