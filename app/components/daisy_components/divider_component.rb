# frozen_string_literal: true

module DaisyComponents
  class DividerComponent < ViewComponent::Base
    def call
      tag.li(class: 'divider')
    end
  end
end
