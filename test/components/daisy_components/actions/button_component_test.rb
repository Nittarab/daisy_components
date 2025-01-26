# frozen_string_literal: true

require 'test_helper'

module DaisyComponents
  module Actions
    class ButtonComponentTest < DaisyComponents::ComponentTestCase
      include DaisyComponents::IconsHelper

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
        assert_selector('button.btn svg')
        assert_text('Like')
      end

      def test_renders_block_button
        render_preview(:block)
        assert_selector('button.btn.btn-block', text: 'Block Button')
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
                         style: 'outline',
                         shape: 'wide',
                         disabled: true,
                         loading: true,
                         active: true,
                         has_start_icon: true,
                         has_end_icon: true,
                         classes: 'custom-class'
                       })

        assert_selector('.btn.btn-primary.btn-lg.btn-outline.btn-wide' \
                        '.btn-disabled.loading.btn-active.custom-class')
        assert_selector('button svg', count: 2)
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

      def test_link_without_target_blank_has_no_rel
        render_inline(ButtonComponent.new(
                        text: 'No Rel',
                        href: '/path',
                        target: '_self'
                      ))

        assert_selector("a.btn[target='_self']")
        refute_selector('a[rel]')
      end

      def test_loading_and_disabled_state_combination
        render_inline(ButtonComponent.new(
                        text: 'Processing',
                        loading: true,
                        disabled: true
                      ))

        assert_selector('button.btn.loading.btn-disabled')
        assert_selector('[disabled][aria-disabled="true"][aria-busy="true"]')
      end

      def test_base_component_classes
        button = ButtonComponent.new(text: 'Test', classes: 'custom-class-1 custom-class-2')
        assert_equal 'custom-class-1 custom-class-2', button.send(:classes)
      end

      def test_base_component_nil_classes
        button = ButtonComponent.new(text: 'Test', classes: nil)
        assert_equal '', button.send(:classes)
      end

      def test_link_without_turbo_method
        render_inline(ButtonComponent.new(
                        text: 'No Method',
                        href: '/path'
                      ))

        refute_selector('a[data-turbo-method]')
      end

      def test_link_with_non_blank_target
        render_inline(ButtonComponent.new(
                        text: 'Self Target',
                        href: '/path',
                        target: '_self'
                      ))

        assert_selector("a[target='_self']")
        refute_selector('a[rel]')
      end

      def test_link_with_nil_href
        render_inline(ButtonComponent.new(
                        text: 'No Href',
                        href: nil
                      ))

        assert_selector('button.btn')
        refute_selector('a')
      end

      def test_link_with_disabled_and_loading
        render_inline(ButtonComponent.new(
                        text: 'Disabled and Loading',
                        href: '/path',
                        disabled: true,
                        loading: true
                      ))
        assert_selector('a.btn.btn-disabled.loading')
        assert_selector('[disabled][aria-disabled="true"][aria-busy="true"]')
      end

      def test_link_with_nil_name_when_disabled
        render_inline(ButtonComponent.new(
                        text: 'No Name',
                        name: 'test-name',
                        disabled: true
                      ))

        refute_selector('[name]')
      end

      def test_variant_type_conversion
        render_inline(ButtonComponent.new(
                        text: 'Symbol Variant',
                        variant: :primary
                      ))

        assert_selector('button.btn.btn-primary')
      end

      def test_size_type_conversion
        render_inline(ButtonComponent.new(
                        text: 'Symbol Size',
                        size: :lg
                      ))

        assert_selector('button.btn.btn-lg')
      end

      def test_type_type_conversion
        render_inline(ButtonComponent.new(
                        text: 'Symbol Type',
                        type: :submit
                      ))

        assert_selector("button[type='submit']")
      end

      def test_link_rel_with_nil_rel_and_non_blank_target
        render_inline(ButtonComponent.new(
                        text: 'Parent Target',
                        href: '/path',
                        target: '_parent'
                      ))

        assert_selector("a[target='_parent']")
        refute_selector('a[rel]')
      end

      def test_renders_with_invalid_variant
        assert_raises(ArgumentError) do
          render_inline(ButtonComponent.new(text: 'Invalid', variant: 'invalid'))
        end
      end

      def test_renders_with_invalid_size
        assert_raises(ArgumentError) do
          render_inline(ButtonComponent.new(text: 'Invalid', size: 'invalid'))
        end
      end

      def test_renders_with_invalid_style
        assert_raises(ArgumentError) do
          render_inline(ButtonComponent.new(text: 'Invalid', style: 'invalid'))
        end
      end

      def test_renders_with_invalid_shape
        assert_raises(ArgumentError) do
          render_inline(ButtonComponent.new(text: 'Invalid', shape: 'invalid'))
        end
      end

      def test_playground_preview
        render_preview(:playground)
        assert_selector('.btn')
      end

      def test_renders_outline_button
        render_preview(:outline)
        assert_selector('button.btn.btn-outline', text: 'Outline Button')
      end

      def test_renders_soft_button
        render_preview(:soft)
        assert_selector('button.btn.btn-soft', text: 'Soft Button')
      end

      def test_renders_circle_button
        render_preview(:circle)
        assert_selector('button.btn.btn-circle svg.h-6.w-6')
      end

      def test_renders_square_button
        render_preview(:square)
        assert_selector('button.btn.btn-square svg.h-6.w-6')
      end

      def test_renders_with_component_content
        render_preview(:component_content)
        assert_selector('button.btn')
        assert_selector('.badge')
        assert_text('New')
      end

      def test_renders_external_link
        render_preview(:external_link)
        assert_selector('a.btn[target="_blank"]', text: 'External Link')
      end
    end
  end
end
