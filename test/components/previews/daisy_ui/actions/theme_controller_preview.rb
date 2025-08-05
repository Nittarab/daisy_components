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
      # @param type select { choices: [checkbox, toggle, radio_buttons, radio_inputs, dropdown, swap] }
      # @param value text "Theme value"
      # @param checked toggle "Initially checked"
      # @param label_before text "Label before input"
      # @param label_after text "Label after input"
      # @param custom_classes text "Additional CSS classes"
      def playground(
        type: 'toggle',
        value: 'synthwave',
        checked: false,
        label_before: '',
        label_after: '',
        custom_classes: ''
      )
        case type
        when 'radio_buttons', 'radio_inputs', 'dropdown'
          render(DaisyUI::ThemeController.new(
                   type: type,
                   name: 'theme-demo',
                   themes: sample_themes,
                   class: custom_classes
                 ))
        else
          render(DaisyUI::ThemeController.new(
                   type: type,
                   value: value,
                   checked: checked,
                   label_before: label_before.presence,
                   label_after: label_after.presence,
                   class: custom_classes
                 ))
        end
      end

      # @!endgroup

      private

      # Theme Controller using a Checkbox
      # ---------------
      # Simple checkbox theme controller
      def theme_controller_using_a_checkbox
        render_with_template
      end

      # Theme Controller using a Dropdown
      # ---------------
      # Dropdown menu for theme selection
      def theme_controller_using_a_dropdown
        render_with_template
      end

      # Theme Controller using a Radio Button
      # ---------------
      # Group of radio buttons styled as buttons
      def theme_controller_using_a_radio_button
        render_with_template
      end

      # Theme Controller using a Radio Input
      # ---------------
      # Traditional radio inputs with labels
      def theme_controller_using_a_radio_input
        render_with_template
      end

      # Theme Controller using a Swap
      # ---------------
      # Swap component with sun/moon icons
      def theme_controller_using_a_swap
        render_with_template(locals: { helper: self })
      end

      # Theme Controller using a Toggle
      # ---------------
      # Simple toggle switch
      def theme_controller_using_a_toggle
        render_with_template
      end

      # Theme Controller using a Toggle with Custom Colors
      # ---------------
      # Toggle with custom CSS color styling
      def theme_controller_using_a_toggle_with_custom_colors
        render_with_template
      end

      # Theme Controller using a Toggle with Icons
      # ---------------
      # Toggle with sun/moon icons outside
      def theme_controller_using_a_toggle_with_icons
        render_with_template(locals: { helper: self })
      end

      # Theme Controller using a Toggle with Icons Inside
      # ---------------
      # Toggle with Phosphor icons inside
      def theme_controller_using_a_toggle_with_icons_inside
        render_with_template
      end

      # Theme Controller using a Toggle with Text
      # ---------------
      # Toggle with text labels
      def theme_controller_using_a_toggle_with_text
        render_with_template
      end

      def sample_themes
        [
          { value: 'default', label: 'Default' },
          { value: 'retro', label: 'Retro' },
          { value: 'cyberpunk', label: 'Cyberpunk' },
          { value: 'valentine', label: 'Valentine' },
          { value: 'aqua', label: 'Aqua' }
        ]
      end

      def sun_icon(options = {})
        classes = options[:class]

        tag.svg(
          xmlns: 'http://www.w3.org/2000/svg',
          width: '20',
          height: '20',
          viewBox: '0 0 24 24',
          fill: 'none',
          stroke: 'currentColor',
          'stroke-width': '2',
          'stroke-linecap': 'round',
          'stroke-linejoin': 'round',
          class: classes
        ) do
          safe_join([
            tag.circle(cx: '12', cy: '12', r: '5'),
            tag.path(d: 'M12 1v2M12 21v2M4.2 4.2l1.4 1.4M18.4 18.4l1.4 1.4M1 12h2M21 12h2M4.2 19.8l1.4-1.4M18.4 5.6l1.4-1.4')
          ])
        end
      end

      def moon_icon(options = {})
        classes = options[:class]

        tag.svg(
          xmlns: 'http://www.w3.org/2000/svg',
          width: '20',
          height: '20',
          viewBox: '0 0 24 24',
          fill: 'none',
          stroke: 'currentColor',
          'stroke-width': '2',
          'stroke-linecap': 'round',
          'stroke-linejoin': 'round',
          class: classes
        ) do
          tag.path(d: 'M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z')
        end
      end

      def swap_sun_icon
        tag.svg(
          class: 'swap-off h-10 w-10 fill-current',
          xmlns: 'http://www.w3.org/2000/svg',
          viewBox: '0 0 24 24'
        ) do
          tag.path(d: 'M5.64,17l-.71.71a1,1,0,0,0,0,1.41,1,1,0,0,0,1.41,0l.71-.71A1,1,0,0,0,5.64,17ZM5,12a1,1,0,0,0-1-1H3a1,1,0,0,0,0,2H4A1,1,0,0,0,5,12Zm7-7a1,1,0,0,0,1-1V3a1,1,0,0,0-2,0V4A1,1,0,0,0,12,5ZM5.64,7.05a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.41l-.71-.71A1,1,0,0,0,4.93,6.34Zm12,.29a1,1,0,0,0,.7-.29l.71-.71a1,1,0,1,0-1.41-1.41L17,5.64a1,1,0,0,0,0,1.41A1,1,0,0,0,17.66,7.34ZM21,11H20a1,1,0,0,0,0,2h1a1,1,0,0,0,0-2Zm-9,8a1,1,0,0,0-1,1v1a1,1,0,0,0,2,0V20A1,1,0,0,0,12,19ZM18.36,17A1,1,0,0,0,17,18.36l.71.71a1,1,0,0,0,1.41,0,1,1,0,0,0,0-1.41ZM12,6.5A5.5,5.5,0,1,0,17.5,12,5.51,5.51,0,0,0,12,6.5Zm0,9A3.5,3.5,0,1,1,15.5,12,3.5,3.5,0,0,1,12,15.5Z')
        end
      end

      def swap_moon_icon
        tag.svg(
          class: 'swap-on h-10 w-10 fill-current',
          xmlns: 'http://www.w3.org/2000/svg',
          viewBox: '0 0 24 24'
        ) do
          tag.path(d: 'M21.64,13a1,1,0,0,0-1.05-.14,8.05,8.05,0,0,1-3.37.73A8.15,8.15,0,0,1,9.08,5.49a8.59,8.59,0,0,1,.25-2A1,1,0,0,0,8,2.36,10.14,10.14,0,1,0,22,14.05,1,1,0,0,0,21.64,13Zm-9.5,6.69A8.14,8.14,0,0,1,7.08,5.22v.27A10.15,10.15,0,0,0,17.22,15.63a9.79,9.79,0,0,0,2.1-.22A8.11,8.11,0,0,1,12.14,19.73Z')
        end
      end
    end
  end
end