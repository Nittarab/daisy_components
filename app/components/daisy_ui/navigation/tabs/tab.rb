# frozen_string_literal: true

module DaisyUI
  class Tabs
    # Tab sub-component for individual tab items
    #
    # @example Basic tab
    #   <%= render(DaisyUI::Tabs::Tab.new(text: "Home", content: "Home content", active: true)) %>
    #
    # @example Tab with link
    #   <%= render(DaisyUI::Tabs::Tab.new(text: "About", href: "/about")) %>
    #
    # @example Disabled tab
    #   <%= render(DaisyUI::Tabs::Tab.new(text: "Contact", content: "Contact content", disabled: true)) %>
    class Tab < BaseComponent
      attr_reader :content, :active

      # @param text [String] Tab label text
      # @param content [String, ActiveSupport::SafeBuffer] Tab content panel
      # @param active [Boolean] Whether this tab is active (default: false)
      # @param disabled [Boolean] Whether this tab is disabled (default: false)
      # @param href [String] Link URL if tab should be a link instead of button
      # @param target [String] Link target (e.g., `_blank`)  
      # @param method [Symbol, String] HTTP method for Rails links (e.g., `:delete`)
      # @param system_arguments [Hash] Additional HTML attributes for the tab element
      def initialize(
        text: nil,
        content: nil,
        active: false,
        disabled: false,
        href: nil,
        target: nil,
        method: nil,
        **system_arguments,
        &block
      )
        @text = text
        @content = content
        @active = active
        @disabled = disabled
        @href = href
        @target = target
        @method = method

        super(**system_arguments)

        # Capture block content if provided
        @content = capture(&block) if block_given?
      end

      def call(index: 0, show_content: true)
        if @href
          render_link_tab(index)
        else
          render_button_tab(index, show_content)
        end
      end

      private

      def render_link_tab(index)
        tag.a(**link_attributes(index)) do
          tab_text
        end
      end

      def render_button_tab(index, show_content)
        tag.button(**button_attributes(index, show_content)) do
          tab_text
        end
      end

      def link_attributes(index)
        data_hash = { turbo_method: @method }.compact
        {
          href: @href,
          target: @target,
          role: 'tab',
          id: "tab-#{index}",
          class: computed_tab_classes,
          data: data_hash.presence,
          **system_arguments.except(:class)
        }.compact
      end

      def button_attributes(index, show_content)
        data_attributes = {}
        if show_content
          data_attributes['tab-target'] = "#tab-panel-#{index}"
          data_attributes['action'] = 'click->tabs#switch'
        end

        {
          type: 'button',
          role: 'tab',
          id: "tab-#{index}",
          disabled: @disabled,
          class: computed_tab_classes,
          data: data_attributes.presence,
          'aria-selected' => @active.to_s,
          'aria-controls' => (show_content ? "tab-panel-#{index}" : nil),
          **system_arguments.except(:class)
        }.compact
      end

      def computed_tab_classes
        class_names(
          'tab',
          {
            'tab-active' => @active,
            'tab-disabled' => @disabled
          },
          system_arguments[:class]
        )
      end

      def tab_text
        if content.present? && @text.blank?
          content
        elsif @text.present?
          @text
        else
          content
        end
      end
    end
  end
end