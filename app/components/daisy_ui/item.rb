# frozen_string_literal: true

module DaisyUI
  class Item < BaseComponent
    def initialize(href: nil, icon_span: false, **system_arguments)
      @href = href
      @icon_span = icon_span
      super(**system_arguments)
    end

    def call
      tag.li do
        render_item_content
      end
    end

    private

    def render_item_content
      if @href.present? && @href != ''
        tag.a(href: @href, class: system_arguments[:class]) { content }
      elsif @href == ''
        render_empty_href_link
      elsif @icon_span
        render_icon_span
      else
        content
      end
    end

    def render_empty_href_link
      # Render as link without href attribute (for breadcrumbs compatibility)
      tag.a(class: system_arguments[:class]) { content }
    end

    def render_icon_span
      # Apply special styling for items with icons (when no href)
      tag.span(class: 'inline-flex items-center gap-2') { content }
    end
  end
end
