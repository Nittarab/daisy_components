# frozen_string_literal: true

module DaisyUI
  # ThemeController component renders DaisyUI compliant markup that allows users
  # to switch the active theme. The underlying implementation mirrors the
  # examples provided by DaisyUI's documentation and supports the most common
  # controller variants (checkbox, toggle, radio button, radio input list,
  # swap toggle and dropdown).
  #
  # Only a subset of DaisyUI's features are abstracted at component level – the
  # remaining flexibility can be achieved by passing plain CSS classes via the
  # `class:` keyword or extra HTML attributes through `**system_arguments`.
  #
  # ==== Examples
  #
  #   # Checkbox controller
  #   render DaisyUI::ThemeController.new(
  #     variant: :checkbox,
  #     value:   "synthwave"
  #   )
  #
  #   # Toggle controller with custom classes
  #   render DaisyUI::ThemeController.new(
  #     variant: :toggle,
  #     value:   "synthwave",
  #     class:   "col-span-2 border-sky-400 bg-amber-300"
  #   )
  #
  #   # Swap controller with custom SVG icons
  #   render DaisyUI::ThemeController.new(
  #     variant: :swap,
  #     value:   "synthwave",
  #     icon_on:  helpers.sun_icon("h-6 w-6"),
  #     icon_off: helpers.moon_icon("h-6 w-6"),
  #     effect:  :rotate
  #   )
  #
  # ==== Parameters
  # * +variant+  – Symbol representing the controller style. Supported values:
  #                +:checkbox+, +:toggle+, +:swap+, +:radio_button+,
  #                +:radio_input+, +:dropdown+.
  # * +value+    – The theme value bound to the controller (required for
  #                single-value controllers, optional for collections).
  # * +values+   – Array of theme values (required for variant that renders a
  #                collection – radio_button, radio_input, dropdown).
  # * +effect+   – Optional animation effect for swap variant (+:rotate+,
  #                +:flip+, +:flip_active+).
  # * +icon_on+  – Custom SVG/HTML to render for the ON state (swap variant).
  # * +icon_off+ – Custom SVG/HTML to render for the OFF state (swap variant).
  # * +label_before+ – Optional text/HTML rendered before the controller
  #                    (toggle with text/icons).
  # * +label_after+  – Optional text/HTML rendered after the controller
  #                    (toggle with text/icons).
  # * +prompt+  – Text shown on dropdown trigger.
  # * +trigger_icon+ – Custom SVG/HTML to render for the dropdown trigger.
  # * +classes+ – Additional CSS classes.
  # * +system_arguments+ – Additional HTML attributes forwarded to the root
  #                       element.
  class ThemeController < DaisyUI::BaseComponent
    EFFECTS = {
      rotate: 'swap-rotate',
      flip: 'swap-flip',
      flip_active: 'swap-flip-active'
    }.freeze

    def initialize(variant: :checkbox, value: nil, values: nil, effect: nil,
                   icon_on: nil, icon_off: nil, label_before: nil, label_after: nil,
                   prompt: 'Theme', trigger_icon: nil, classes: nil, **system_arguments)
      @variant = variant.to_sym
      @value = value
      @values = values || []
      @effect = build_argument(effect, EFFECTS, 'effect') if effect
      @icon_on = icon_on
      @icon_off = icon_off
      @label_before = label_before
      @label_after = label_after
      @prompt = prompt
      @trigger_icon = trigger_icon
      @passed_classes = classes
      super(**system_arguments)

      validate_parameters!
    end

    def call
      case @variant
      when :checkbox then checkbox
      when :toggle then toggle
      when :swap then swap
      when :radio_button then radio_button_group
      when :radio_input then radio_input_group
      when :dropdown then dropdown
      else
        raise ArgumentError, "Unsupported variant: #{@variant}"
      end
    end

    private

    #############################################
    # Variant helpers
    #############################################

    def checkbox
      tag.input(type: 'checkbox', value: @value, class: class_names('checkbox theme-controller', @passed_classes,
                                                                    system_arguments[:class]), **system_arguments.except(:class))
    end

    def toggle
      wrapper_needed = @label_before || @label_after || icons?.any?

      wrapper_has_toggle = @passed_classes&.include?('toggle') || system_arguments[:class]&.include?('toggle')

      input_classes = class_names(
        'theme-controller',
        (wrapper_has_toggle ? nil : 'toggle'),
        (wrapper_needed ? nil : @passed_classes),
        (wrapper_needed ? nil : system_arguments[:class])
      )

      input = tag.input(type: 'checkbox', value: @value, class: input_classes)

      return input unless wrapper_needed

      base_wrapper_class = if @passed_classes || system_arguments[:class]
                             class_names(@passed_classes, system_arguments[:class])
                           else
                             'flex cursor-pointer gap-2'
                           end

      tag.label(class: base_wrapper_class) do
        elements = if base_wrapper_class.include?('toggle')
                     [input, icon(:before), icon(:after)]
                   else
                     [icon(:before), input, icon(:after)]
                   end

        safe_join([
          processed_label(@label_before),
          *elements.compact,
          processed_label(@label_after)
        ].compact)
      end
    end

    def swap
      tag.label(class: class_names('swap', @effect, @passed_classes, system_arguments[:class])) do
        safe_join([
                    '<!-- this hidden checkbox controls the state -->'.html_safe,
                    tag.input(type: 'checkbox', value: @value, class: 'theme-controller'),
                    '<!-- sun icon -->'.html_safe,
                    swap_state(:off),
                    '<!-- moon icon -->'.html_safe,
                    swap_state(:on)
                  ])
      end
    end

    def radio_button_group
      raise ArgumentError, 'values must be provided for radio_button variant' if @values.empty?

      name = system_arguments[:name] || 'theme-buttons'

      tag.div(class: class_names('join join-vertical', @passed_classes, system_arguments[:class])) do
        safe_join(
          @values.map do |theme|
            tag.input(type: 'radio', name:, value: theme, 'aria-label': theme.titleize,
                      class: class_names('btn theme-controller join-item'))
          end
        )
      end
    end

    def radio_input_group
      raise ArgumentError, 'values must be provided for radio_input variant' if @values.empty?

      name = system_arguments[:name] || 'theme-radios'

      tag.fieldset(class: class_names('fieldset', @passed_classes, system_arguments[:class])) do
        safe_join(
          @values.map do |theme|
            tag.label(class: 'flex gap-2 cursor-pointer items-center') do
              safe_join([
                          tag.input(type: 'radio', name:, value: theme, class: 'radio radio-sm theme-controller'),
                          " #{theme.titleize} "
                        ])
            end
          end
        )
      end
    end

    def dropdown
      raise ArgumentError, 'values must be provided for dropdown variant' if @values.empty?

      tag.div(class: class_names('dropdown mb-72', @passed_classes, system_arguments[:class])) do
        safe_join([
                    dropdown_trigger,
                    dropdown_content
                  ])
      end
    end

    def dropdown_trigger
      tag.div(tabindex: '0', role: 'button', class: 'btn m-1') do
        safe_join([
          " #{@prompt} ",
          @trigger_icon
        ].compact)
      end
    end

    def dropdown_content
      tag.ul(tabindex: '0', class: 'dropdown-content bg-base-300 rounded-box z-1 w-52 p-2 shadow-2xl') do
        safe_join(
          @values.map do |theme|
            tag.li do
              tag.input(type: 'radio', name: 'theme-dropdown',
                        class: 'theme-controller w-full btn btn-sm btn-block btn-ghost justify-start',
                        'aria-label': theme.titleize, value: theme)
            end
          end
        )
      end
    end

    #############################################
    # Helpers
    #############################################

    def icons?
      [@icon_on, @icon_off].compact
    end

    def icon(position)
      case position
      when :before then @icon_on if @icon_on && !@label_before
      when :after then @icon_off if @icon_off && !@label_after
      end
    end

    def swap_state(state)
      provided_icon = (state == :on ? @icon_on : @icon_off)

      if provided_icon && provided_icon.include?('class="')
        return provided_icon.sub('class="', "class=\"swap-#{state} ").html_safe
      elsif provided_icon
        return "<span class=\"swap-#{state}\">#{provided_icon}</span>".html_safe
      end

      default_icon_class = state == :on ? 'ph ph-moon' : 'ph ph-sun'
      %(<i class="swap-#{state} #{default_icon_class} h-10 w-10 fill-current"></i>).html_safe
    end

    def validate_parameters!
      case @variant
      when :checkbox, :toggle, :swap
        raise ArgumentError, 'value must be provided' unless @value
      when :radio_button, :radio_input, :dropdown
        raise ArgumentError, 'values must be provided and not empty' if @values.empty?
      end
    end

    def processed_label(label)
      return unless label

      return label if label.to_s.include?('<') # assume already HTML-safe

      tag.span(label, class: 'label-text')
    end
  end
end
