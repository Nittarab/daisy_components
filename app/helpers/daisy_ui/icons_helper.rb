# frozen_string_literal: true

module DaisyUI
  module IconsHelper
    ICONS = {
      hamburger: 'ph-list',
      error: 'ph-x-circle',
      close: 'ph-x-circle',
      volume_on: 'ph-volume-high',
      volume_off: 'ph-volume-low',
      sun: 'ph-sun',
      info: 'ph-info',
      moon: 'ph-moon',
      warning: 'ph-warning',
      chevron_down: 'ph-caret-down',
      check: 'ph-check',
      heart: 'ph-heart',
      home: 'ph-house',
      email: 'ph-envelope',
      github: 'ph-github-logo',
      google: 'ph-google-logo',
      facebook: 'ph-facebook-logo',
      x: 'ph-x-logo',
      kakao: 'ph-kakao-logo',
      apple: 'ph-apple-logo',
      amazon: 'ph-amazon-logo',
      microsoft: 'ph-microsoft-logo',
      telegram: 'ph-telegram-logo',
      twitter: 'ph-twitter-logo',
      instagram: 'ph-instagram-logo',
      linkedin: 'ph-linkedin-logo',
      youtube: 'ph-youtube-logo',
      discord: 'ph-discord-logo',
      twitch: 'ph-twitch-logo',
      slack: 'ph-slack-logo',
      wechat: 'ph-wechat-logo',
      chart_bar: 'ph-chart-bar',
      plus: 'ph-plus',
      shopping_cart: 'ph-shopping-cart',
      bell: 'ph-bell',
      magnifying_glass: 'ph-magnifying-glass'
    }.freeze

    def phosphor_icon(icon_class, options = {})
      additional_classes = options.delete(:class) || ''
      full_class = "ph #{icon_class} #{additional_classes}".strip

      content_tag(:i, '', options.merge(class: full_class))
    end

    ICONS.each do |key, value|
      define_method(:"#{key}_icon") do |options = {}|
        phosphor_icon(value, options)
      end
    end
  end
end
