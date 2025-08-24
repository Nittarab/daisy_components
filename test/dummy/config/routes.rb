# frozen_string_literal: true

Rails.application.routes.draw do
  root "landing#index"
  get "landing/index" # keep for named helper
  mount DaisyUI::Engine => '/daisyui'

  # Mount Lookbook at the root level
  mount Lookbook::Engine, at: '/lookbook'
end
