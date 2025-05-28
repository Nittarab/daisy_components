# frozen_string_literal: true

module DaisyUI
  module Actions
    # @label Dropdown
    # @display bg_color "#fff"
    class DropdownComponentPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper
      include ActionView::Helpers::TagHelper

      # @!group Playground

      # Playground
      # ---------------
      # Interactive dropdown menu with customizable trigger and content
      #
      # @param position select { choices: [top, top_end, top_center, bottom, bottom_end, bottom_center, left, left_end, left_center, right, right_end, right_center] }
      #                       "Position of the dropdown content relative to the trigger"
      # @param hover select { choices: [false, true, content] }
      #                    "How the dropdown opens on hover (false, true, or content)"
      # @param open toggle "When true, forces the dropdown to stay open"
      # @param align select { choices: [start, end, center] }
      #                    "Alignment of the dropdown content relative to the trigger"
      # @param menu_class text "Additional CSS classes for the dropdown menu"
      # @param menu_tabindex number "HTML tabindex attribute for the dropdown menu (default: 0)"
      # @param color select { choices: [primary, secondary, accent, info, success, warning, error, ghost, neutral] }
      #                    "Button color for the trigger"
      # @param size select { choices: [xs, sm, md, lg] }
      #                   "Size of the trigger button"
      # @param trigger_text text "Text for the trigger button"
      # @param trigger_icon toggle "Show icon in trigger button"
      # @param show_header toggle "Show header in dropdown"
      # @param show_footer toggle "Show footer in dropdown"
      def playground( # rubocop:disable Metrics/AbcSize
        position: nil,
        hover: false,
        open: false,
        align: nil,
        menu_class: nil,
        menu_tabindex: 0,
        color: nil,
        size: nil,
        trigger_text: 'Click me',
        trigger_icon: false,
        show_header: false,
        show_footer: false
      )
        render(DaisyUI::Dropdown.new(
                 position: position,
                 hover: hover,
                 open: open,
                 align: align,
                 menu_class: menu_class,
                 menu_tabindex: menu_tabindex,
                 class: 'mb-40'
               )) do |d|
          d.with_trigger(text: trigger_text, color: color, size: size,
                         icon_start: trigger_icon ? warning_icon : nil)
          d.with_title { 'Menu' } if show_header
          d.with_item(href: '#') { safe_join([home_icon, 'Item 1']) }
          d.with_item(href: '#') { safe_join([email_icon, 'Item 2']) }
          d.with_divider
          d.with_item(href: '#', class: 'text-error') { safe_join([sun_icon, 'Item 3']) }
          d.with_item { tag.button('Save changes', class: 'btn btn-primary btn-sm w-full') } if show_footer
        end
      end

      # @!endgroup

      # Card as dropdown content
      # ---------------
      # Example showing how to use a card as dropdown content
      def card_as_dropdown
        render(DaisyUI::Dropdown.new) do |d|
          d.with_trigger(text: 'Click')
          d.with_custom_content do
            tag.div(tabindex: 0, class: 'dropdown-content card card-sm bg-base-100 z-1 w-64 shadow-md') do
              tag.div(class: 'card-body') do
                tag.p('This is a card. You can use any element as a dropdown.')
              end
            end
          end
        end
      end

      def dropdown_aligns_to_center_of_button_horizontally
        render(DaisyUI::Dropdown.new(align: :center)) do |d|
          d.with_trigger(text: 'Click ⬇️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_aligns_to_end_of_button_horizontally
        render(DaisyUI::Dropdown.new(align: :end)) do |d|
          d.with_trigger(text: 'Click ⬇️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_aligns_to_start_of_button_horizontally
        render(DaisyUI::Dropdown.new(align: :start)) do |d|
          d.with_trigger(text: 'Click ⬇️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_left_aligns_to_end_of_button_vertically
        render(DaisyUI::Dropdown.new(position: :left, align: :end)) do |d|
          d.with_trigger(text: 'Click  ⬅️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_menu
        render(DaisyUI::Dropdown.new) do |d|
          d.with_trigger(text: 'Click')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_on_hover
        render(DaisyUI::Dropdown.new(hover: true)) do |d|
          d.with_trigger(text: 'Hover')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_right
        render(DaisyUI::Dropdown.new(position: :right)) do |d|
          d.with_trigger(text: 'Click  ➡️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_right_aligns_to_center_of_button_vertically
        render(DaisyUI::Dropdown.new(position: :right, align: :center)) do |d|
          d.with_trigger(text: 'Click  ➡️', class: 'm-1')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_right_aligns_to_end_of_button_vertically
        render(DaisyUI::Dropdown.new(position: :right, align: :end)) do |d|
          d.with_trigger(text: 'Click  ➡️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def dropdown_top
        render(DaisyUI::Dropdown.new(position: :top)) do |d|
          d.with_trigger(text: 'Click  ⬆️')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def force_open
        render(DaisyUI::Dropdown.new(open: true)) do |d|
          d.with_trigger(text: 'Button')
          d.with_item(href: '#') { 'Item 1' }
          d.with_item(href: '#') { 'Item 2' }
        end
      end

      def helper_dropdown
        render_with_template(locals: { helper: self })
      end
    end
  end
end
