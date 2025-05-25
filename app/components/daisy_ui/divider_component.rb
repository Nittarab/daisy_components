# frozen_string_literal: true

module DaisyUI
  class DividerComponent < ViewComponent::Base
    def call
      tag.li(class: 'divider')
    end
  end
end
