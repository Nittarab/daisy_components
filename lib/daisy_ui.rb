# frozen_string_literal: true

require 'daisy_ui/version'
require 'daisy_ui/engine'
require 'view_component'

# Only require lookbook in development
require 'lookbook' if Rails.env.development?

module DaisyUI
  class Error < StandardError; end
  # Your code goes here...
end
