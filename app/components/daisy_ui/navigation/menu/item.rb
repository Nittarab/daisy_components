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
    # @example With icon (passing icon HTML directly)
    #   <%= render(DaisyUI::Menu::Item.new(
    #     text: "Settings",
    #     href: "/settings",
    #     icon_start: helpers.phosphor_icon('ph-gear')
    #   )) %>
    #
    # @example With badge (passing badge text directly)
    #   <%= render(DaisyUI::Menu::Item.new(
    #     text: "Messages",
    #     href: "/messages",
    #     badge: "3"
    #   )) %>
    #
    # @example With icon and badge using slots (alternative)
    #   <%= render(DaisyUI::Menu::Item.new(text: "Notifications", href: "/notifications")) do |item| %>
    #     <% item.with_start_icon { helpers.phosphor_icon('ph-bell') } %>
    #     <% item.with_badge(class: "badge-primary") { "New" } %>
    #   <% end %>
    class Item < BaseComponent
      renders_one :start_icon
      renders_one :end_icon
      renders_one :badge, lambda { |text = nil, **system_arguments|
        DaisyUI::Badge.new(text: text, **system_arguments)
      }

      # @param text [String] Item text content. Can also be provided as block content.
      # @param href [String] Link URL.
      # @param active [Boolean] Active state (adds `menu-active` class to the link).
      # @param disabled [Boolean] Disabled state (adds `menu-disabled` class to the `<li>` element).
      # @param focused [Boolean] Focus state (adds `menu-focus` class to the link).
      # @param icon_start [String, ActiveSupport::SafeBuffer] HTML for the leading icon. Alternatively, use the `with_start_icon` slot.
      # @param icon_end [String, ActiveSupport::SafeBuffer] HTML for the trailing icon. Alternatively, use the `with_end_icon` slot.
      # @param badge [String, Hash] Badge content or options for `DaisyUI::Badge`.
      #   If a String is passed, it's used as the badge text.
      #   If a Hash is passed, it's used as arguments for `DaisyUI::Badge.new`.
      #   Alternatively, use the `with_badge` slot.
      # @param tooltip [String] Tooltip text (HTML `title` attribute on the `<li>` element).
      # @param target [String] Link target (e.g., `_blank`).
      # @param method [Symbol, String] HTTP method for Rails links (e.g., `:delete`).
      # @param system_arguments [Hash] Additional HTML attributes for the `<li>` element.
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

      def computed_li_classes
        class_names(
          { 'menu-disabled' => @disabled },
          system_arguments[:class] # Allow user to pass classes to li
        ).presence
      end

      def computed_a_classes
        class_names(
          {
            'menu-active' => @active, # DaisyUI class for active item
            'menu-focus' => @focused # DaisyUI class for focused item
            # 'active' and 'focus' can be added by users if they mean something else
          }
        ).presence
      end

      def li_attributes
        {
          **system_arguments.except(:class, :title), # Exclude class as it's handled in computed_li_classes, title is for tooltip
          class: computed_li_classes,
          title: @tooltip # Apply tooltip to the li element
        }.compact
      end

      def link_content
        tag.a(**link_attributes) do
          item_content
        end
      end

      def link_attributes
        data_hash = { turbo_method: @method }.compact
        {
          href: @href,
          target: @target,
          data: data_hash.presence,
          class: computed_a_classes
        }.compact
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
          @text # Use the text parameter if no block content
        end
      end

      def badge_content
        return unless @badge

        # This method is kept for compatibility if badge was passed directly as a simple string
        # But the `renders_one :badge` with the lambda is the primary way badges are now handled
        # if `with_badge` slot or initializer `badge:` hash is used.
        if @badge.is_a?(String)
          tag.span(@badge, class: 'badge badge-xs') # Basic badge if string
        else
          # If @badge is a Hash, it means it was intended for the DaisyUI::Badge component
          # and should have been handled by `with_badge(**@badge)` or the slot.
          # This path should ideally not be hit if using the component correctly.
          nil
        end
      end
    end
  end
end
