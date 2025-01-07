# frozen_string_literal: true

# @label Dropdown
# @display bg_color "#fff"
module DaisyComponents
  module Actions
    class DropdownComponentPreview < Lookbook::Preview
      # @!group Playground

      # @title Default
      # @description Basic dropdown example with all available options
      #
      # @param position [String] select [end, top, bottom, left, right]
      # @param hover toggle
      # @param open toggle
      # @param align_end toggle
      def playground(
        position: nil,
        hover: false,
        open: false,
        align_end: false
      )
        render_with_template(
          template: 'daisy_components/actions/dropdown_component_preview/playground',
          locals: {
            position: position,
            hover: hover,
            open: open,
            align_end: align_end
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
