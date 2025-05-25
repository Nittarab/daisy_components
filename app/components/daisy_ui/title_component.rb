# frozen_string_literal: true

module DaisyUI
  class TitleComponent < ViewComponent::Base
    def call
      tag.li(class: 'menu-title') { content }
    end
  end
end
