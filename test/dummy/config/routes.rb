# frozen_string_literal: true

Rails.application.routes.draw do
  mount DaisyComponents::Engine => '/daisy_components'

  # Mount Lookbook at the root level in development
  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
