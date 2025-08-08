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
        render(DaisyUI::Alert.new(
                 text: text,
                 color: color,
                 variant: variant,
                 icon: has_icon ? icon_param : nil,
                 dismissible: dismissible,
                 vertical: vertical,
                 class: classes
               ))
      end

      # @!endgroup

      def alert
        render(DaisyUI::Alert.new(text: '12 unread messages. Tap to see.', icon: info_icon(class: 'h-6 w-6 shrink-0')))
      end

      def info_color
        render(DaisyUI::Alert.new(text: 'New software update available.', color: :info, icon: info_icon(class: 'h-6 w-6 shrink-0')))
      end

      def success_color
        render(DaisyUI::Alert.new(text: 'Your purchase has been confirmed!', color: :success, icon: check_icon(class: 'h-6 w-6 shrink-0')))
      end

      def warning_color
        render(DaisyUI::Alert.new(text: 'Warning: Invalid email address!', color: :warning, icon: warning_icon(class: 'h-6 w-6 shrink-0')))
      end

      def error_color
        render(DaisyUI::Alert.new(text: 'Error! Task failed successfully.', color: :error, icon: error_icon(class: 'h-6 w-6 shrink-0')))
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
        render_with_template(locals: { helper: self })
      end

      def alert_with_buttons_responsive
        render_with_template(locals: { helper: self })
      end

      def alert_with_buttons_parameter
        render(DaisyUI::Alert.new(
                 text: 'Accept cookies?',
                 vertical: true,
                 buttons: [
                   { text: 'Deny', size: :sm },
                   { text: 'Accept', size: :sm, color: :primary }
                 ]
               ))
      end
    end
  end
end
