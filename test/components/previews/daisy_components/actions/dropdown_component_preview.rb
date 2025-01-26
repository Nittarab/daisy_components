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
      # @param position select { choices: [top, bottom, left, right] }
      #                       "Position of the dropdown content relative to the trigger"
      # @param hover toggle "When true, opens the dropdown on hover instead of click"
      # @param open toggle "When true, forces the dropdown to stay open"
      # @param align_end toggle "When true, aligns the dropdown content to the end (right) of the trigger"
      # @param variant select { choices: [primary, secondary, accent, info, success, warning, error, ghost, neutral] }
      #                      "Button variant for the trigger"
      # @param size select { choices: [xs, sm, md, lg] }
      #                   "Size of the trigger button"
      # @param trigger_text text "Text for the trigger button"
      # @param trigger_icon toggle "Show icon in trigger button"
      def playground(
        position: nil,
        hover: false,
        open: false,
        align_end: false,
        variant: nil,
        size: nil,
        trigger_text: 'Click me',
        trigger_icon: false
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
      # Showcase of different dropdown features: icons, dividers, and variants
      #
      # @label Features
      def features
        render_with_template(locals: { helpers: self })
      end

      # @!endgroup
    end
  end
end
