# frozen_string_literal: true

# @label Alert
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class AlertPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground
      # Default
      # ---------------
      # Interactive alert component with customizable styling
      #
      # @param text text "Alert message text"
      # @param color select {choices: [info, success, warning, error]}
      # @param variant select {choices: [outline, soft, dash]}
      # @param has_icon toggle "Show icon"
      # @param dismissible toggle "Make dismissible"
      # @param vertical toggle "Vertical layout on mobile"
      # @param classes text "Additional CSS classes"
      def playground(
        text: '12 unread messages. Tap to see.',
        color: nil,
        variant: nil,
        has_icon: true,
        dismissible: false,
        vertical: false,
        classes: ''
      )
        icon_param = if has_icon
          info_icon  # Always use info icon when user wants to show an icon
        else
          nil  # No icon when has_icon is false
        end
        
        render(DaisyUI::Alert.new(
                 text: text,
                 color: color,
                 variant: variant,
                 icon: icon_param,
                 dismissible: dismissible,
                 vertical: vertical,
                 class: classes
               ))
      end

      # @!endgroup
      
      def alert
        render(DaisyUI::Alert.new(text: '12 unread messages. Tap to see.'))
      end

      def info_color
        render(DaisyUI::Alert.new(text: 'New software update available.', color: :info))
      end

      def success_color
        render(DaisyUI::Alert.new(text: 'Your purchase has been confirmed!', color: :success))
      end

      def warning_color
        render(DaisyUI::Alert.new(text: 'Warning: Invalid email address!', color: :warning))
      end

      def error_color
        render(DaisyUI::Alert.new(text: 'Error! Task failed successfully.', color: :error))
      end

      def alert_outline_style
        render_with_template
      end

      def alert_soft_style
        render_with_template
      end

      def alert_dash_style
        render_with_template
      end

      def alert_with_title_and_description
        alert = DaisyUI::Alert.new(
          color: :info,
          title: 'New message!',
          description: 'You have 1 unread message',
          vertical: true
        )
        alert.with_actions do
          tag.button('See', class: 'btn btn-sm')
        end
        render alert
      end

      def alert_with_buttons_responsive
        render_with_template
      end
    end
  end
end