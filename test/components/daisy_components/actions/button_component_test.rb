# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class ButtonComponentTest < ViewComponent::TestCase
      def test_renders_button_with_text
        render_inline(ButtonComponent.new(text: 'Click me'))

        assert_selector('button.btn', text: 'Click me')
        assert_selector("button[type='button']")
        refute_selector('a') # Ensure it's not a link
      end

      def test_renders_button_with_block_content
        render_inline(ButtonComponent.new) { 'Block content' }

        assert_selector('button.btn', text: 'Block content')
        assert_selector("button[type='button']")
        refute_selector('a')
      end

      def test_renders_button_with_html_content
        render_inline(ButtonComponent.new) do
          "<i class='icon'></i> With Icon".html_safe
        end

        assert_selector('button.btn i.icon')
        assert_text('With Icon')
      end

      def test_renders_link_when_href_provided
        render_inline(ButtonComponent.new(
                        text: 'Visit site',
                        href: 'https://example.com',
                        target: '_blank'
                      ))

        assert_selector("a.btn[href='https://example.com']", text: 'Visit site')
        assert_selector("a[target='_blank'][rel='noopener noreferrer']")
        refute_selector('button') # Ensure it's not a button
      end

      def test_renders_submit_button
        render_inline(ButtonComponent.new(
                        text: 'Submit',
                        type: 'submit',
                        variant: 'primary'
                      ))

        assert_selector("button[type='submit'].btn.btn-primary", text: 'Submit')
        refute_selector('a')
      end

      def test_renders_disabled_button
        render_inline(ButtonComponent.new(
                        text: 'Disabled',
                        disabled: true
                      ))

        assert_selector("button.btn.btn-disabled[disabled][aria-disabled='true']")
        refute_selector('[href]') # Ensure no href attribute
      end

      def test_renders_loading_button
        render_inline(ButtonComponent.new(
                        text: 'Loading',
                        loading: true
                      ))

        assert_selector('button.btn.loading[aria-busy="true"]')
        assert_selector('[disabled]') # Loading buttons should be disabled
        assert_selector('[aria-disabled="true"]')
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
          assert_text(variant.capitalize)
        end
      end

      def test_invalid_variant_is_ignored
        render_inline(ButtonComponent.new(
                        text: 'Invalid',
                        variant: 'invalid-variant'
                      ))

        assert_selector('button.btn')
        refute_selector('button[class*="invalid-variant"]')
      end

      def test_renders_with_size
        ButtonComponent::SIZES.each do |size|
          render_inline(ButtonComponent.new(
                          text: size.upcase,
                          size: size
                        ))

          assert_selector("button.btn.btn-#{size}")
          assert_text(size.upcase)
        end
      end

      def test_invalid_size_is_ignored
        render_inline(ButtonComponent.new(
                        text: 'Invalid',
                        size: 'invalid-size'
                      ))

        assert_selector('button.btn')
        refute_selector('button[class*="invalid-size"]')
      end

      def test_renders_with_turbo_method
        render_inline(ButtonComponent.new(
                        text: 'Delete',
                        href: '/items/1',
                        method: 'delete'
                      ))

        assert_selector("a.btn[data-turbo-method='delete'][href='/items/1']")
        assert_text('Delete')
      end

      def test_disabled_link_has_no_href
        render_inline(ButtonComponent.new(
                        text: 'Disabled Link',
                        href: '/path',
                        disabled: true
                      ))

        assert_selector('a.btn.btn-disabled')
        assert_selector('[aria-disabled="true"]')
        assert_selector('[tabindex="-1"]')
        refute_selector('[href]')
      end

      def test_renders_with_additional_classes
        render_inline(ButtonComponent.new(
                        text: 'Custom',
                        class: 'custom-class another-class'
                      ))

        assert_selector('button.btn.custom-class.another-class')
        assert_text('Custom')
      end

      def test_renders_with_data_attributes
        render_inline(ButtonComponent.new(
                        text: 'Data',
                        data: { controller: 'button', action: 'click->button#click' }
                      ))

        assert_selector('button.btn[data-controller="button"][data-action="click->button#click"]')
      end

      def test_renders_with_aria_attributes
        render_inline(ButtonComponent.new(
                        text: 'Aria',
                        'aria-label': 'Custom Label',
                        'aria-expanded': 'true'
                      ))

        assert_selector('button.btn[aria-label="Custom Label"][aria-expanded="true"]')
      end

      def test_button_type_validation
        render_inline(ButtonComponent.new(
                        text: 'Invalid',
                        type: 'invalid-type'
                      ))

        assert_selector("button[type='button']") # Falls back to default
        refute_selector("button[type='invalid-type']")
      end

      def test_link_with_custom_rel
        render_inline(ButtonComponent.new(
                        text: 'Custom Rel',
                        href: '/path',
                        rel: 'nofollow'
                      ))

        assert_selector("a.btn[rel='nofollow']")
      end

      def test_loading_and_disabled_state_combination
        render_inline(ButtonComponent.new(
                        text: 'Processing',
                        loading: true,
                        disabled: true
                      ))

        assert_selector('button.btn.loading.btn-disabled[disabled][aria-disabled="true"][aria-busy="true"]')
      end
    end
  end
end
