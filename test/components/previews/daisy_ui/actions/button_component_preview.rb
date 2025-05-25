# frozen_string_literal: true

# @label Button
# @display bg_color "#fff"
module DaisyUI
  module Actions
    class ButtonComponentPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper
      # @!group Playground

      # Default
      # ---------------
      # Interactive button component with customizable styling
      #
      # @param text text "Text content inside the button"
      # @param color select {choices: [neutral, primary, secondary, accent, info, success, warning, error, ghost, link]}
      # @param size select { choices: [xs, sm, md, lg, xl] }
      # @param variant select { choices: [outline, soft, dash] }
      # @param shape select { choices: [wide, block, circle, square] }
      # @param disabled toggle "Disable the button"
      # @param loading toggle "Show loading state"
      # @param active toggle "Show active state"
      # @param has_start_icon toggle "Add start icon"
      # @param has_end_icon toggle "Add end icon"
      # @param classes text "Additional CSS classes"
      def playground(
        text: 'Button',
        color: nil,
        size: nil,
        variant: nil,
        shape: nil,
        disabled: false,
        loading: false,
        active: false,
        has_start_icon: false,
        has_end_icon: false,
        classes: ''
      )
        render(DaisyUI::ButtonComponent.new(
                 text:,
                 color:,
                 size:,
                 variant:,
                 shape:,
                 disabled:,
                 loading:,
                 active:,
                 icon_start: has_start_icon ? warning_icon('h-5 w-5') : nil,
                 icon_end: has_end_icon ? chevron_down_icon('h-5 w-5') : nil,
                 class: classes
               ))
      end

      # @!endgroup

      # Active Buttons
      # ---------------
      # Buttons with active state
      def active_buttons
        render_with_template
      end

      # Basic Button
      # ---------------
      # Simple button with default styling
      def button
        render_with_template
      end

      # Block Button
      # ---------------
      # Button that spans full width
      def button_block
        render_with_template
      end

      # Button Sizes
      # ---------------
      # Different button size variations
      def button_sizes
        render_with_template
      end

      # Button with Icon
      # ---------------
      # Button with icon examples
      def button_with_icon
        render_with_template(locals: { helper: self })
      end

      # Loading Buttons
      # ---------------
      # Buttons with loading stateb
      def button_with_loading_spinner
        render_with_template
      end

      # Button Colors
      # ---------------
      # Different button color variations
      def buttons_colors
        render_with_template
      end

      # Ghost and Link Buttons
      # ---------------
      # Ghost and link style buttons
      def buttons_ghost_and_button_link
        render_with_template
      end

      # Buttons with HTML Content
      # ---------------
      # Buttons with custom HTML content
      def buttons_with_any_html_tags
        render_with_template
      end

      # Circle and Square Buttons
      # ---------------
      # Circle and square shaped buttons
      def circle_button_and_square_button
        render_with_template(locals: { helper: self })
      end

      # Dash Buttons
      # ---------------
      # Buttons with dashed border style
      def dash_buttons
        render_with_template
      end

      # Disabled Buttons
      # ---------------
      # Buttons in disabled state
      def disabled_buttons
        render_with_template
      end

      # Login Buttons
      # ---------------
      # Social login button examples
      def login_buttons
        render_with_template(locals: { helper: self })
      end

      # Outline Buttons
      # ---------------
      # Buttons with outline style
      def outline_buttons
        render_with_template
      end

      # Responsive Button
      # ---------------
      # Button that adapts to screen size
      def responsive_button
        render_with_template
      end

      # Soft Buttons
      # ---------------
      # Buttons with soft color style
      def soft_buttons
        render_with_template
      end

      # Wide Button
      # ---------------
      # Extra wide button
      def wide_button
        render_with_template
      end

      # @!endgroup
    end
  end
end
