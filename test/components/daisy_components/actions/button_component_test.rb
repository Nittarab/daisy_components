require 'test_helper'

module DaisyComponents
  module Actions
    class ButtonComponentTest < ViewComponent::TestCase
      def test_renders_button_with_text
        render_inline(ButtonComponent.new(text: 'Click me'))

        assert_selector('button.btn', text: 'Click me')
        assert_selector("button[type='button']")
      end

      def test_renders_button_with_block_content
        render_inline(ButtonComponent.new) { 'Block content' }

        assert_selector('button.btn', text: 'Block content')
      end

      def test_renders_link_when_href_provided
        render_inline(ButtonComponent.new(
                        text: 'Visit site',
                        href: 'https://example.com',
                        target: '_blank'
                      ))

        assert_selector("a.btn[href='https://example.com']", text: 'Visit site')
        assert_selector("a[target='_blank'][rel='noopener noreferrer']")
      end

      def test_renders_submit_button
        render_inline(ButtonComponent.new(
                        text: 'Submit',
                        type: 'submit',
                        variant: 'primary'
                      ))

        assert_selector("button[type='submit'].btn.btn-primary", text: 'Submit')
      end

      def test_renders_disabled_button
        render_inline(ButtonComponent.new(
                        text: 'Disabled',
                        disabled: true
                      ))

        assert_selector("button.btn.btn-disabled[disabled][aria-disabled='true']")
      end

      def test_renders_loading_button
        render_inline(ButtonComponent.new(
                        text: 'Loading',
                        loading: true
                      ))

        assert_selector('button.btn.loading[aria-busy="true"]')
      end

      def test_renders_active_button
        render_inline(ButtonComponent.new(
                        text: 'Active',
                        active: true
                      ))

        assert_selector('button.btn.btn-active')
      end

      def test_renders_with_variant
        ButtonComponent::VARIANTS.each do |variant|
          render_inline(ButtonComponent.new(
                          text: variant.capitalize,
                          variant: variant
                        ))

          assert_selector("button.btn.btn-#{variant}")
        end
      end

      def test_renders_with_size
        ButtonComponent::SIZES.each do |size|
          render_inline(ButtonComponent.new(
                          text: size.upcase,
                          size: size
                        ))

          assert_selector("button.btn.btn-#{size}")
        end
      end

      def test_renders_with_turbo_method
        render_inline(ButtonComponent.new(
                        text: 'Delete',
                        href: '/items/1',
                        method: 'delete'
                      ))

        assert_selector("a.btn[data-turbo-method='delete'][href='/items/1']")
      end

      def test_disabled_link_has_no_href
        render_inline(ButtonComponent.new(
                        text: 'Disabled Link',
                        href: '/path',
                        disabled: true
                      ))

        assert_selector('a.btn.btn-disabled')
        refute_selector('a[href]')
      end

      def test_renders_with_additional_classes
        render_inline(ButtonComponent.new(
                        text: 'Custom',
                        class: 'custom-class'
                      ))

        assert_selector('button.btn.custom-class')
      end
    end
  end
end
