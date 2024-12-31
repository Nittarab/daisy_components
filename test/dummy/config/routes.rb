# frozen_string_literal: true

Rails.application.routes.draw do
  mount DaisyComponents::Engine => '/daisy_components'
end
