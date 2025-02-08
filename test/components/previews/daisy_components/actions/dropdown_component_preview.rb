# frozen_string_literal: true

module DaisyComponents
  module Actions
    # @label Dropdown
    # @display bg_color "#fff"
    class DropdownComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper
      include ActionView::Helpers::TagHelper

      # @!group Playground

      # Playground
      # ---------------
      # Interactive dropdown menu with customizable trigger and content
      #
      # @param position select { choices: [top, top-end, top-center, bottom, bottom-end, bottom-center, left, left-end, left-center, right, right-end, right-center] }
      #                       "Position of the dropdown content relative to the trigger"
      # @param hover select { choices: [false, true, content] }
      #                    "How the dropdown opens on hover (false, true, or content)"
      # @param open toggle "When true, forces the dropdown to stay open"
      # @param align select { choices: [start, end, center] }
      #                    "Alignment of the dropdown content relative to the trigger"
      # @param variant select { choices: [primary, secondary, accent, info, success, warning, error, ghost, neutral] }
      #                      "Button variant for the trigger"
      # @param size select { choices: [xs, sm, md, lg] }
      #                   "Size of the trigger button"
      # @param trigger_text text "Text for the trigger button"
      # @param trigger_icon toggle "Show icon in trigger button"
      # @param show_header toggle "Show header in dropdown"
      # @param show_footer toggle "Show footer in dropdown"
      def playground(
        position: nil,
        hover: false,
        open: false,
        align: nil,
        variant: nil,
        size: nil,
        trigger_text: 'Click me',
        trigger_icon: false,
        show_header: false,
        show_footer: false
      )
        render(DaisyComponents::Actions::DropdownComponent.new(
                 position: position,
                 hover: hover,
                 open: open,
                 align: align,
                 class: 'mb-40'
               )) do |d|
          d.with_trigger(text: trigger_text, variant: variant, size: size,
                         icon_start: trigger_icon ? warning_icon('h-5 w-5') : nil)
          d.with_title { 'Menu' } if show_header
          d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
          d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
          d.with_divider
          d.with_item(href: '#', class: 'text-error') { safe_join([helpers.trash_icon('h-5 w-5 mr-2'), 'Item 3']) }
          d.with_item { tag.button('Save changes', class: 'btn btn-primary btn-sm w-full') } if show_footer
        end
      end

      # @!endgroup

      # Card as dropdown content
      # ---------------
      # Example showing how to use a card as dropdown content
      # def card_as_dropdown
      #   render(DaisyComponents::Actions::DropdownComponent.new) do |d|
      #     d.with_trigger(text: 'Click', class: 'm-1')
      #     d.with_custom_content do
      #       tag.div(tabindex: 0, class: 'dropdown-content card card-sm bg-base-100 z-1 w-64 shadow-md') do
      #         tag.div(class: 'card-body') do
      #           tag.p('This is a card. You can use any element as a dropdown.')
      #         end
      #       end
      #     end
      #   end
      # end

      # def dropdown_aligns_to_center_of_button_horizontally
      #   render(DaisyComponents::Actions::DropdownComponent.new(align: :center)) do |d|
      #     d.with_trigger(text: 'Click ⬇️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_aligns_to_end_of_button_horizontally
      #   render(DaisyComponents::Actions::DropdownComponent.new(align: :end)) do |d|
      #     d.with_trigger(text: 'Click ⬇️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_aligns_to_start_of_button_horizontally
      #   render(DaisyComponents::Actions::DropdownComponent.new(align: :start)) do |d|
      #     d.with_trigger(text: 'Click ⬇️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_left_aligns_to_end_of_button_vertically
      #   render(DaisyComponents::Actions::DropdownComponent.new(position: :left, align: :end)) do |d|
      #     d.with_trigger(text: 'Click  ⬅️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_menu
      #   render(DaisyComponents::Actions::DropdownComponent.new) do |d|
      #     d.with_trigger(text: 'Click', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_on_hover
      #   render(DaisyComponents::Actions::DropdownComponent.new(hover: true)) do |d|
      #     d.with_trigger(text: 'Hover', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_right
      #   render(DaisyComponents::Actions::DropdownComponent.new(position: :right)) do |d|
      #     d.with_trigger(text: 'Click  ➡️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_right_aligns_to_center_of_button_vertically
      #   render(DaisyComponents::Actions::DropdownComponent.new(position: :right, align: :center)) do |d|
      #     d.with_trigger(text: 'Click  ➡️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_right_aligns_to_end_of_button_vertically
      #   render(DaisyComponents::Actions::DropdownComponent.new(position: :right, align: :end)) do |d|
      #     d.with_trigger(text: 'Click  ➡️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      # def dropdown_top
      #   render(DaisyComponents::Actions::DropdownComponent.new(position: :top)) do |d|
      #     d.with_trigger(text: 'Click  ⬆️', class: 'm-1')
      #     d.with_item(href: '#') { safe_join([helpers.user_icon('h-5 w-5 mr-2'), 'Item 1']) }
      #     d.with_item(href: '#') { safe_join([helpers.cog_icon('h-5 w-5 mr-2'), 'Item 2']) }
      #   end
      # end

      def force_open
        render(DaisyComponents::Actions::DropdownComponent.new(open: true)) do |d|
          d.with_trigger(text: 'Button', class: 'm-1', role: :button)
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def test
        render(ButtonComponent.new(text: 'Button', class: 'm-1', type: :button, tabindex: '0'))
      end

      # def helper_dropdown
      #   render_with_template
      # end
      #
    end
  end
end
