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
        if @href && @href != ''
          tag.a(href: @href, class: system_arguments[:class]) { content }
        elsif @href == ''
          # Render as link without href attribute (for breadcrumbs compatibility)
          tag.a(class: system_arguments[:class]) { content }
        elsif @icon_span
          # Apply special styling for items with icons (when no href)
          tag.span(class: 'inline-flex items-center gap-2') { content }
        else
          content
        end
      end
    end
  end
end
