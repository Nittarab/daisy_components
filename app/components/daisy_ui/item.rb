# frozen_string_literal: true

module DaisyUI
  class Item < BaseComponent
    def initialize(href: nil, **system_arguments)
      @href = href
      super(**system_arguments)
    end

    def call
      tag.li do
        if @href && @href != ''
          tag.a(href: @href, class: system_arguments[:class]) { content }
        elsif @href == ''
          # Render as link without href attribute (for breadcrumbs compatibility)
          tag.a(class: system_arguments[:class]) { content }
        else
          # Check if content contains icons to apply special styling for breadcrumbs
          if content.to_s.include?('<i class=')
            tag.span(class: 'inline-flex items-center gap-2') { content }
          else
            content
          end
        end
      end
    end
  end
end
