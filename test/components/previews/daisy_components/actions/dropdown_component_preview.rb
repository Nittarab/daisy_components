# frozen_string_literal: true

module DaisyComponents
  module Actions
    # @label Dropdown
    # @display bg_color "#fff"
    class DropdownComponentPreview < ViewComponent::Preview
      include DaisyComponents::IconsHelper

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
      def playground( # rubocop:disable Metrics/MethodLength
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
        render(DropdownComponent.new(
                 position: position,
                 hover: hover,
                 open: open,
                 align: align,
                 variant: variant,
                 size: size,
                 trigger: {
                   text: trigger_text,
                   icon: trigger_icon ? warning_icon('h-5 w-5') : nil
                 },
                 header: show_header ? { title: 'Menu' } : nil,
                 footer: if show_footer
                           { content: tag.button('Save changes',
                                                 class: 'btn btn-primary btn-sm w-full') }
                         end,
                 items: [
                   { text: 'Item 1', href: '#' },
                   { text: 'Item 2', href: '#' },
                   { type: :divider },
                   { text: 'Item 3', href: '#', variant: :error }
                 ],
                 class: 'mb-40'
               ))
      end

      # @!endgroup

      # Card as dropdown content
      # ---------------
      # Example showing how to use a card as dropdown content
      def card_as_dropdown
        render_with_template
      end

      def dropdown_aligns_to_center_of_button_horizontally
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click ⬇️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 align: :center
               ))
      end

      def dropdown_aligns_to_end_of_button_horizontally
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click ⬇️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 align: :end
               ))
      end

      def dropdown_aligns_to_start_of_button_horizontally
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click ⬇️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 align: :start
               ))
      end

      def dropdown_left_aligns_to_end_of_button_vertically
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click  ⬅️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 position: 'left',
                 align: :end
               ))
      end

      def dropdown_menu
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ]
               ))
      end

      def dropdown_on_hover
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Hover', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 hover: true,
                 align: nil
               ))
      end

      def dropdown_right
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click  ➡️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 position: 'right',
                 align: nil
               ))
      end

      def dropdown_right_aligns_to_center_of_button_vertically
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click  ➡️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 position: 'right',
                 align: :center,
                 class: 'dropdown-center'
               ))
      end

      def dropdown_right_aligns_to_end_of_button_vertically
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click  ➡️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 position: 'right',
                 align: :end
               ))
      end

      def dropdown_top
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Click  ⬆️', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 position: 'top'
               ))
      end

      # def dropdown_using_popover_api_and_anchor_positioning
      #   render(DaisyComponents::Actions::DropdownComponent.new(
      #            trigger: { text: 'Click', class: 'm-1' },
      #            items: [
      #              { text: 'Item 1' },
      #              { text: 'Item 2' }
      #            ],
      #            menu_tabindex: 0,
      #            align_end: nil
      #          ))
      # end

      def force_open
        render(DaisyComponents::Actions::DropdownComponent.new(
                 trigger: { text: 'Button', class: 'm-1' },
                 items: [
                   { text: 'Item 1' },
                   { text: 'Item 2' }
                 ],
                 open: true
               ))
      end

      # def helper_dropdown
      #   render_with_template
      # end
    end
  end
end
