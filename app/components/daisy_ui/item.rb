# frozen_string_literal: true

module DaisyUI
  class Item < BaseComponent
    def initialize(href: nil, **system_arguments)
      @href = href
      super(**system_arguments)
    end

    def call
      tag.li do
        if @href
          tag.a(href: @href, class: system_arguments[:class]) { content }
        else
          content
        end
      end
    end
  end
end
