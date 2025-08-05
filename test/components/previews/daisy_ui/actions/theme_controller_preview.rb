# frozen_string_literal: true

# @label Theme Controller
# @display bg_color "#fff"
module DaisyUI
  module Actions
    class ThemeControllerPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Default
      # ---------------
      # Interactive theme controller component with customizable options
      #
      # @param type select {choices: [checkbox, toggle, radio, radio_button, dropdown, swap, toggle_icons_inside]}
      # @param value text "Theme value"
      # @param checked toggle "Checked state"
      # @param text_before text "Text before toggle"
      # @param text_after text "Text after toggle" 
      # @param has_icons toggle "Add sun/moon icons"
      # @param button_text text "Dropdown button text"
      # @param classes text "Additional CSS classes"
      def playground(
        type: 'checkbox',
        value: 'synthwave',
        checked: false,
        text_before: '',
        text_after: '',
        has_icons: false,
        button_text: 'Theme',
        classes: ''
      )
        options = {
          type: type.to_sym,
          value: value,
          checked: checked,
          class: classes
        }

        case type.to_s
        when 'toggle'
          options[:text_before] = text_before.present? ? text_before : nil
          options[:text_after] = text_after.present? ? text_after : nil
          if has_icons
            options[:icon_before] = sun_icon(width: "20", height: "20")
            options[:icon_after] = moon_icon(width: "20", height: "20")
          end
        when 'radio', 'radio_button'
          options[:themes] = [
            { value: 'default', label: 'Default' },
            { value: 'retro', label: 'Retro' },
            { value: 'cyberpunk', label: 'Cyberpunk' }
          ]
        when 'dropdown'
          options[:button_text] = button_text
          options[:themes] = [
            { value: 'default', label: 'Default' },
            { value: 'retro', label: 'Retro' },
            { value: 'cyberpunk', label: 'Cyberpunk' }
          ]
        when 'toggle_icons_inside'
          # This type has fixed icons, no additional options needed
        end

        render(DaisyUI::ThemeController.new(**options))
      end

      # @!endgroup

      # Theme Controller using a Checkbox
      # ---------------
      # Simple checkbox for theme switching
      def theme_controller_using_a_checkbox
        render_with_template
      end

      # Theme Controller using a Toggle
      # ---------------
      # Toggle switch for theme switching
      def theme_controller_using_a_toggle
        render_with_template
      end

      # Theme Controller using a Radio Input
      # ---------------
      # Radio inputs with labels for theme selection
      def theme_controller_using_a_radio_input
        render_with_template
      end

      # Theme Controller using a Radio Button
      # ---------------
      # Radio inputs styled as buttons
      def theme_controller_using_a_radio_button
        render_with_template
      end

      # Theme Controller using a Dropdown
      # ---------------
      # Dropdown menu with theme options
      def theme_controller_using_a_dropdown
        render_with_template
      end

      # Theme Controller using a Swap
      # ---------------
      # Swap component with sun/moon icons
      def theme_controller_using_a_swap
        render_with_template
      end

      # Theme Controller using a Toggle with Icons
      # ---------------
      # Toggle with sun and moon icons
      def theme_controller_using_a_toggle_with_icons
        render_with_template(locals: { helper: self })
      end

      # Theme Controller using a Toggle with Text
      # ---------------
      # Toggle with text labels before and after
      def theme_controller_using_a_toggle_with_text
        render_with_template
      end

      # Theme Controller using a Toggle with Custom Colors
      # ---------------
      # Toggle with custom Tailwind color classes
      def theme_controller_using_a_toggle_with_custom_colors
        render_with_template
      end

      # Theme Controller using a Toggle with Icons Inside
      # ---------------
      # Toggle with icons positioned inside
      def theme_controller_using_a_toggle_with_icons_inside
        render_with_template
      end
    end
  end
end