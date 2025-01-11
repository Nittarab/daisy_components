# frozen_string_literal: true

# @label Dropdown
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class DropdownComponentPreview < Lookbook::Preview
      # @!group Playground

      # Playground
      # ---------------
      # Interactive dropdown menu with customizable trigger and content
      #
      # @param position select { choices: [end, top, bottom, left, right] } "Position of the dropdown content relative
      #                                                                        to the trigger"
      # @param hover toggle "When true, opens the dropdown on hover instead of click"
      # @param open toggle "When true, forces the dropdown to stay open"
      # @param align_end toggle "When true, aligns the dropdown content to the end (right) of the trigger"
      # @param classes text "Additional CSS classes to apply to the dropdown container"
      def playground(
        position: nil,
        hover: false,
        open: false,
        align_end: false,
        classes: ''
      )
        render_with_template(
          template: 'daisy_components/actions/dropdown_component_preview/playground',
          locals: {
            position: position,
            hover: hover,
            open: open,
            align_end: align_end,
            classes: classes
          }
        )
      end

      # @!endgroup

      # @!group Positions

      # Dropdown Positions
      # ---------------
      # All available dropdown positions
      #
      # @label All Positions
      def positions
        render_with_template(
          template: 'daisy_components/actions/dropdown_component_preview/positions',
          locals: {
            positions: DaisyComponents::Actions::DropdownComponent::POSITIONS
          }
        )
      end

      # @!endgroup

      # @!group Alignments

      # Dropdown Alignments
      # ---------------
      # Different dropdown alignments
      #
      # @label Alignments
      def alignments
        render_with_template(
          template: 'daisy_components/actions/dropdown_component_preview/alignments'
        )
      end

      # @!endgroup

      # @!group Behaviors

      # Dropdown Behaviors
      # ---------------
      # Different dropdown behaviors: hover and force open
      #
      # @label Behaviors
      def behaviors
        render_with_template(
          template: 'daisy_components/actions/dropdown_component_preview/behaviors'
        )
      end

      # @!endgroup
    end
  end
end
