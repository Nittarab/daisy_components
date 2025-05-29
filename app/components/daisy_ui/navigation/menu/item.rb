# frozen_string_literal: true

module DaisyUI
  class Menu
    # Menu item sub-component for individual menu entries
    #
    # @example Basic item
    #   <%= render(DaisyUI::Menu::Item.new(text: "Home", href: "/")) %>
    #
    # @example Active item
    #   <%= render(DaisyUI::Menu::Item.new(text: "Dashboard", href: "/dashboard", active: true)) %>
    #
    # @example With icon
    #   <%= render(DaisyUI::Menu::Item.new(
    #     text: "Settings",
    #     href: "/settings",
    #     icon_start: helpers.cog_icon
    #   )) %>
    #
    # @example With badge
    #   <%= render(DaisyUI::Menu::Item.new(
    #     text: "Messages",
    #     href: "/messages",
    #     badge: "3"
    #   )) %>
    class Item < BaseComponent
      renders_one :start_icon
      renders_one :end_icon
      renders_one :badge, lambda { |**system_arguments|
        DaisyUI::Badge.new(**system_arguments)
      }

      # @param text [String] Item text content
      # @param href [String] Link URL
      # @param active [Boolean] Active state (adds menu-active)
      # @param disabled [Boolean] Disabled state (adds menu-disabled)
      # @param focused [Boolean] Focus state (adds menu-focus)
      # @param icon_start [String] Leading icon
      # @param icon_end [String] Trailing icon
      # @param badge [String] Badge content
      # @param tooltip [String] Tooltip text
      # @param target [String] Link target
      # @param method [String] HTTP method for Rails links
      # @param system_arguments [Hash] Additional HTML attributes
      def initialize(
        text: nil,
        href: nil,
        active: false,
        disabled: false,
        focused: false,
        icon_start: nil,
        icon_end: nil,
        badge: nil,
        tooltip: nil,
        target: nil,
        method: nil,
        **system_arguments
      )
        @text = text
        @href = href
        @active = active
        @disabled = disabled
        @focused = focused
        @badge = badge
        @tooltip = tooltip
        @target = target
        @method = method

        with_start_icon { icon_start } if icon_start
        with_badge { badge } if badge
        with_end_icon { icon_end } if icon_end

        super(**system_arguments)
      end

      def call
        tag.li(**li_attributes) do
          link_content
        end
      end

      private

      def li_attributes
        attrs = {}
        attrs[:class] = li_classes if li_classes.present?
        attrs[:title] = @tooltip if @tooltip
        attrs.merge(system_arguments.except(:class))
      end

      def li_classes
        modifiers = []
        modifiers << 'menu-disabled' if @disabled
        class_names(modifiers, system_arguments[:class])
      end

      def link_content
        tag.a(**link_attributes) do
          item_content
        end
      end

      def link_attributes
        attrs = {}
        attrs[:href] = @href if @href
        attrs[:target] = @target if @target
        attrs[:data] = { turbo_method: @method }.compact if @method

        link_class = link_classes
        attrs[:class] = link_class if link_class.present?

        attrs
      end

      def link_classes
        modifiers = []
        modifiers << 'menu-active' if @active
        modifiers << 'menu-focus' if @focused
        class_names(modifiers)
      end

      def item_content
        safe_join([
          start_icon,
          content_with_text,
          badge,
          end_icon
        ].compact)
      end

      def content_with_text
        if content.present?
          content
        elsif @text.present?
          @text
        end
      end

      def badge_content
        return unless @badge

        tag.span(@badge, class: 'badge badge-xs')
      end
    end
  end
end
