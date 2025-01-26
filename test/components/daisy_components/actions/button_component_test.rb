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

      def test_renders_basic_button
        render_preview(:basic_text)
        assert_selector('button.btn', text: 'Click Me')
      end

      def test_renders_with_icon_start
        render_inline(ButtonComponent.new(
                        text: 'Submit',
                        icon_start: warning_icon('h-5 w-5')
                      ))
        assert_selector 'button.btn.gap-2'
        assert_selector 'button.btn svg'
        assert_text 'Submit'
      end

      def test_renders_with_icon_end
        render_inline(ButtonComponent.new(
                        text: 'Next',
                        icon_end: warning_icon('h-5 w-5')
                      ))
        assert_selector 'button.btn.gap-2'
        assert_selector 'button.btn svg'
        assert_text 'Next'
      end

      def test_renders_with_both_icons
        render_inline(ButtonComponent.new(
                        text: 'Sync',
                        icon_start: warning_icon('h-5 w-5'),
                        icon_end: chevron_down_icon('h-5 w-5')
                      ))
        assert_selector 'button.btn.gap-2'
        assert_selector 'button.btn svg', count: 2
        assert_text 'Sync'
      end

      def test_renders_icon_only
        render_inline(ButtonComponent.new(
                        icon_start: warning_icon('h-6 w-6'),
                        class: 'btn-square'
                      ))
        assert_selector 'button.btn.btn-square svg'
        assert_selector 'button.btn svg', count: 1
      end

      def test_renders_with_variant
        render_preview(:primary)
        assert_selector('button.btn.btn-primary', text: 'Primary Action')
      end

      def test_renders_with_size
        render_preview(:sizes)
        assert_selector('button.btn.btn-lg', text: 'LG')
      end

      def test_renders_with_style
        render_preview(:outline)
        assert_selector('button.btn.btn-outline', text: 'Outline Button')
      end

      def test_renders_with_shape
        render_preview(:wide)
        assert_selector('button.btn.btn-wide', text: 'Wide Button')
      end

      def test_renders_with_disabled
        render_preview(:disabled)
        assert_selector('button.btn.btn-disabled', text: "Can't click me")
      end

      def test_renders_with_loading
        render_preview(:loading)
        assert_selector('button.btn.loading', text: 'Processing...')
      end

      def test_renders_with_active
        render_preview(:active)
        assert_selector('button.btn.btn-active', text: 'Active Button')
      end

      def test_renders_as_link
        render_preview(:link_button)
        assert_selector('a.btn[href="https://google.com"]', text: 'Visit Google')
      end

      def test_renders_with_turbo_method
        render_preview(:turbo_method)
        assert_selector('a.btn.btn-error[data-turbo-method="delete"]', text: 'Delete Item')
      end

      def test_renders_with_target_blank
        render_preview(:link_button)
        assert_selector('a.btn[target="_blank"][rel="noopener noreferrer"]', text: 'Visit Google')
      end

      def test_renders_with_icon_start
        render_preview(:icon_start)
        assert_selector('button.btn svg')
        assert_text('Submit')
      end

      def test_renders_with_icon_end
        render_preview(:icon_end)
        assert_selector('button.btn svg')
        assert_text('Next')
      end

      def test_renders_with_both_icons
        render_preview(:both_icons)
        assert_selector('button.btn svg', count: 2)
        assert_text('Sync')
      end

      def test_renders_icon_only
        render_preview(:icon_only)
        assert_selector('button.btn.btn-square svg')
      end

      def test_renders_block_button
        render_preview(:block)
        assert_selector('button.btn.btn-block', text: 'Block Button')
      end

      def test_renders_with_block_content
        render_preview(:block_content)
        assert_selector('button.btn strong', text: 'content')
      end

      def test_renders_with_html_content
        render_preview(:block_content)
        assert_selector('button.btn strong')
        assert_text('content')
      end

      def test_renders_with_component_content
        render_preview(:component_content)
        assert_selector('button.btn')
        assert_selector('.badge')
        assert_text('New')
      end

      def test_renders_submit_button
        render_preview(:submit_button)
        assert_selector('button.btn[type="submit"]', text: 'Submit Form')
      end

      def test_renders_reset_button
        render_preview(:reset_button)
        assert_selector('button.btn[type="reset"]', text: 'Reset Form')
      end

      def test_renders_external_link
        render_preview(:external_link)
        assert_selector('a.btn[target="_blank"]', text: 'External Link')
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

      def test_primary_preview
        render_preview(:primary)
        assert_selector('.btn.btn-primary')
      end

      def test_secondary_preview
        render_preview(:secondary)
        assert_selector('.btn.btn-secondary')
      end

      def test_ghost_preview
        render_preview(:ghost)
        assert_selector('.btn.btn-ghost')
      end

      def test_variants_preview
        render_preview(:variants)
        assert_selector('.btn', count: 11)
      end

      def test_sizes_preview
        render_preview(:sizes)
        assert_selector('.btn', count: 5)
      end

      def test_styles_preview
        render_preview(:styles)
        assert_selector('.btn', count: 2)
      end

      def test_shapes_preview
        render_preview(:shapes)
        assert_selector('.btn', count: 4)
      end

      def test_loading_preview
        render_preview(:loading)
        assert_selector('.btn.loading')
      end

      def test_active_preview
        render_preview(:active)
        assert_selector('.btn.btn-active')
      end

      def test_disabled_preview
        render_preview(:disabled)
        assert_selector('.btn.btn-disabled')
      end

      def test_with_icon_preview
        render_preview(:with_icon)
        assert_selector('.btn svg')
      end

      def test_renders_outline_button
        render_preview(:outline)
        assert_selector('button.btn.btn-outline', text: 'Outline Button')
      end

      def test_renders_soft_button
        render_preview(:soft)
        assert_selector('button.btn.btn-soft', text: 'Soft Button')
      end

      def test_renders_wide_button
        render_preview(:wide)
        assert_selector('button.btn.btn-wide', text: 'Wide Button')
      end

      def test_renders_circle_button
        render_preview(:circle)
        assert_selector('button.btn.btn-circle svg.h-6.w-6')
      end

      def test_renders_square_button
        render_preview(:square)
        assert_selector('button.btn.btn-square svg.h-6.w-6')
      end

      def test_renders_with_variant
        render_preview(:primary)
        assert_selector('button.btn.btn-primary', text: 'Primary Action')
      end

      def test_renders_with_size
        render_preview(:sizes)
        assert_selector('button.btn.btn-lg', text: 'LG')
      end

      def test_renders_with_style
        render_preview(:outline)
        assert_selector('button.btn.btn-outline', text: 'Outline Button')
      end

      def test_renders_with_shape
        render_preview(:wide)
        assert_selector('button.btn.btn-wide', text: 'Wide Button')
      end

      def test_renders_with_disabled
        render_preview(:disabled)
        assert_selector('button.btn.btn-disabled', text: "Can't click me")
      end

      def test_renders_with_loading
        render_preview(:loading)
        assert_selector('button.btn.loading', text: 'Processing...')
      end

      def test_renders_with_active
        render_preview(:active)
        assert_selector('button.btn.btn-active', text: 'Active Button')
      end

      def test_renders_as_link
        render_preview(:link_button)
        assert_selector('a.btn[href="https://google.com"]', text: 'Visit Google')
      end

      def test_renders_with_turbo_method
        render_preview(:turbo_method)
        assert_selector('a.btn.btn-error[data-turbo-method="delete"]', text: 'Delete Item')
      end

      def test_renders_with_target_blank
        render_preview(:link_button)
        assert_selector('a.btn[target="_blank"][rel="noopener noreferrer"]', text: 'Visit Google')
      end

      def test_renders_with_icon_start
        render_preview(:icon_start)
        assert_selector('button.btn svg')
        assert_text('Submit')
      end

      def test_renders_with_icon_end
        render_preview(:icon_end)
        assert_selector('button.btn svg')
        assert_text('Next')
      end

      def test_renders_with_both_icons
        render_preview(:both_icons)
        assert_selector('button.btn svg', count: 2)
        assert_text('Sync')
      end

      def test_renders_icon_only
        render_preview(:icon_only)
        assert_selector('button.btn.btn-square svg')
      end

      def test_renders_block_button
        render_preview(:block)
        assert_selector('button.btn.btn-block', text: 'Block Button')
      end

      def test_renders_with_block_content
        render_preview(:block_content)
        assert_selector('button.btn strong', text: 'content')
      end

      def test_renders_with_html_content
        render_preview(:block_content)
        assert_selector('button.btn strong')
        assert_text('content')
      end

      def test_renders_with_component_content
        render_preview(:component_content)
        assert_selector('button.btn')
        assert_selector('.badge')
        assert_text('New')
      end

      def test_renders_submit_button
        render_preview(:submit_button)
        assert_selector('button.btn[type="submit"]', text: 'Submit Form')
      end

      def test_renders_reset_button
        render_preview(:reset_button)
        assert_selector('button.btn[type="reset"]', text: 'Reset Form')
      end

      def test_renders_external_link
        render_preview(:external_link)
        assert_selector('a.btn[target="_blank"]', text: 'External Link')
      end
    end
  end
end
