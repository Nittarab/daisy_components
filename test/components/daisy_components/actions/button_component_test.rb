# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class ButtonComponentTest < DaisyComponents::ComponentTestCase
      def test_renders_primary_button
        render_preview(:primary)
        assert_selector('button.btn.btn-primary', text: 'Primary Action')
      end

      def test_renders_secondary_button
        render_preview(:secondary)
        assert_selector('button.btn.btn-secondary', text: 'Secondary Action')
      end

      def test_renders_ghost_button
        render_preview(:ghost)
        assert_selector('button.btn.btn-ghost', text: 'Ghost Button')
      end

      def test_renders_button_variants
        render_preview(:variants)
        ButtonComponent::VARIANTS.each do |variant|
          assert_selector("button.btn.btn-#{variant}", text: variant.titleize)
        end
      end

      def test_renders_button_sizes
        render_preview(:sizes)
        ButtonComponent::SIZES.each do |size|
          assert_selector("button.btn.btn-#{size}", text: size.upcase)
        end
      end

      def test_renders_loading_button
        render_preview(:loading)
        assert_selector('button.btn.loading[aria-busy="true"]')
        assert_selector('[disabled]')
        assert_selector('[aria-disabled="true"]')
        assert_text('Processing...')
      end

      def test_renders_active_button
        render_preview(:active)
        assert_selector('button.btn.btn-active', text: 'Active Button')
      end

      def test_renders_disabled_button
        render_preview(:disabled)
        assert_selector("button.btn.btn-disabled[disabled][aria-disabled='true']")
        assert_text("Can't click me")
      end

      def test_renders_link_button
        render_preview(:link_button)
        assert_selector("a.btn[href='https://google.com']", text: 'Visit Google')
        assert_selector("a[target='_blank'][rel='noopener noreferrer']")
      end

      def test_renders_submit_button
        render_preview(:submit_button)
        assert_selector("button[type='submit'].btn.btn-primary", text: 'Submit Form')
      end

      def test_renders_reset_button
        render_preview(:reset_button)
        assert_selector("button[type='reset'].btn.btn-ghost", text: 'Reset Form')
      end

      def test_renders_turbo_method_button
        render_preview(:turbo_method)
        assert_selector("a.btn.btn-error[data-turbo-method='delete'][href='/items/1']", text: 'Delete Item')
      end

      def test_renders_with_icon
        render_preview(:with_icon)
        assert_selector('button.btn i.fas.fa-heart')
        assert_text('Like')
      end

      def test_renders_block_button
        render_preview(:block)
        assert_selector('button.btn.btn-block', text: 'Full width button')
      end

      def test_renders_icon_only_button
        render_preview(:icon_only)
        assert_selector('button.btn.btn-square svg.h-6.w-6')
      end

      def test_renders_with_custom_classes
        render_inline(ButtonComponent.new(text: 'Custom', class: 'custom-class'))
        assert_selector('button.btn.custom-class', text: 'Custom')
      end

      def test_playground_renders_with_all_options
        render_preview(:playground, params: {
                         text: 'Custom Button',
                         variant: 'primary',
                         size: 'lg',
                         disabled: true,
                         loading: true,
                         active: true,
                         type: 'button',
                         classes: 'custom-class'
                       })

        assert_selector('button.btn.btn-primary.btn-lg.btn-disabled.loading.btn-active.custom-class')
        assert_text('Custom Button')
      end

      def test_renders_with_block_content
        render_inline(ButtonComponent.new) { 'Block content' }
        assert_selector('button.btn', text: 'Block content')
        assert_selector("button[type='button']")
        refute_selector('a')
      end

      def test_renders_with_html_content
        render_inline(ButtonComponent.new) do
          "<i class='icon'></i> With Icon".html_safe
        end
        assert_selector('button.btn i.icon')
        assert_text('With Icon')
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
    end
  end
end
