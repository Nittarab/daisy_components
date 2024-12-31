# frozen_string_literal: true

module DaisyComponents
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
