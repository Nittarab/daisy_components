# frozen_string_literal: true

Rails.application.routes.draw do
  mount DaisyUI::Engine => '/daisyui'

  # Mount Lookbook at the root level in development
  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
