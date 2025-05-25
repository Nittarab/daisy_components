# frozen_string_literal: true

module DaisyUI
  class Divider < ViewComponent::Base
    def call
      tag.li(class: 'divider')
    end
  end
end
