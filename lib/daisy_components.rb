# frozen_string_literal: true

require 'daisy_components/version'
require 'daisy_components/engine'
require 'view_component'

# Only require lookbook in development
require 'lookbook' if Rails.env.development?

module DaisyComponents
  class Error < StandardError; end
  # Your code goes here...
end
