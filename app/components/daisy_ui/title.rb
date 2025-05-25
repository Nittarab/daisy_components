# frozen_string_literal: true

module DaisyUI
  class Title < ViewComponent::Base
    def call
      tag.li(class: 'menu-title') { content }
    end
  end
end
