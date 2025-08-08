# frozen_string_literal: true

module DaisyUI
  class Title < DaisyUI::BaseComponent
    def call
      tag.li(class: 'menu-title') { content }
    end
  end
end
