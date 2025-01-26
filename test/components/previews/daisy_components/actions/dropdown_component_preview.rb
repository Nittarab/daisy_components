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
      # @param position select { choices: [top, top-end, bottom, bottom-end, left, left-end, right, right-end] }
      #                       "Position of the dropdown content relative to the trigger"
      # @param hover select { choices: [false, true, content] }
      #                    "How the dropdown opens on hover (false, true, or content)"
      # @param open toggle "When true, forces the dropdown to stay open"
      # @param align_end toggle "When true, aligns the dropdown content to the end (right) of the trigger"
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
        align_end: false,
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
                 align_end: align_end,
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

      # @!group Positions

      # Dropdown Positions
      # ---------------
      # All available dropdown positions
      #
      # @label All Positions
      def positions
        render_with_template(locals: {
                               positions: DropdownComponent::POSITIONS,
                               helpers: self
                             })
      end

      # @!endgroup

      # @!group Variants

      # Dropdown Variants
      # ---------------
      # Different button variants for the trigger
      #
      # @label Variants
      def variants
        render_with_template(locals: {
                               variants: DropdownComponent::VARIANTS,
                               helpers: self
                             })
      end

      # @!endgroup

      # @!group Sizes

      # Dropdown Sizes
      # ---------------
      # Different sizes for the trigger button
      #
      # @label Sizes
      def sizes
        render_with_template(locals: {
                               sizes: DropdownComponent::SIZES,
                               helpers: self
                             })
      end

      # @!endgroup

      # @!group Features

      # Dropdown Features
      # ---------------
      # Showcase of different dropdown features: icons, dividers, variants, headers, and footers
      #
      # @label Features
      def features
        render_with_template(locals: { helpers: self })
      end

      # @!endgroup
    end
  end
end
