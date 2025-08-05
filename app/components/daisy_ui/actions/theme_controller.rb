# frozen_string_literal: true

module DaisyUI
  # ThemeController component implementing DaisyUI's theme switching functionality
  #
  # @example Basic checkbox theme toggle
  #   <%= render(ThemeController.new(value: "synthwave")) %>
  #
  # @example Toggle with icons
  #   <%= render(ThemeController.new(
  #     type: :toggle,
  #     value: "dark", 
  #     icon_before: helpers.sun_icon,
  #     icon_after: helpers.moon_icon
  #   )) %>
  #
  # @example Radio button selection
  #   <%= render(ThemeController.new(
  #     type: :radio_button,
  #     name: "theme-buttons",
  #     themes: [
  #       { value: "default", label: "Default" },
  #       { value: "retro", label: "Retro" },
  #       { value: "cyberpunk", label: "Cyberpunk" }
  #     ]
  #   )) %>
  #
  # @example Dropdown theme selector
  #   <%= render(ThemeController.new(
  #     type: :dropdown,
  #     button_text: "Theme",
  #     themes: [
  #       { value: "default", label: "Default" },
  #       { value: "retro", label: "Retro" }
  #     ]
  #   )) %>
  class ThemeController < BaseComponent
    # Available theme controller types
    TYPES = {
      checkbox: 'checkbox',
      toggle: 'toggle',
      radio: 'radio',
      radio_button: 'btn',
      dropdown: 'dropdown',
      swap: 'swap',
      toggle_icons_inside: 'toggle_icons_inside'
    }.freeze

    # @param type [Symbol] Type of theme controller (:checkbox, :toggle, :radio, :radio_button, :dropdown, :swap, :toggle_icons_inside)
    # @param value [String] Theme value for single input types
    # @param name [String] Name attribute for radio button groups
    # @param themes [Array<Hash>] Array of theme options with :value and :label keys
    # @param checked [Boolean] Whether the input should be checked by default
    # @param text_before [String] Text to display before toggle input
    # @param text_after [String] Text to display after toggle input  
    # @param icon_before [String] Icon to display before toggle input
    # @param icon_after [String] Icon to display after toggle input
    # @param button_text [String] Text for dropdown button
    # @param size [String] Size modifier for inputs
    # @param custom_classes [String] Additional CSS classes for styling
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize( # rubocop:disable Metrics/ParameterLists
      type: :checkbox,
      value: nil,
      name: nil,
      themes: nil,
      checked: false,
      text_before: nil,
      text_after: nil,
      icon_before: nil,
      icon_after: nil,
      button_text: 'Theme',
      size: nil,
      custom_classes: nil,
      **system_arguments
    )
      @type = build_argument(type, TYPES, 'type')
      @value = value
      @name = name || 'theme-controller'
      @themes = themes
      @checked = checked
      @text_before = text_before
      @text_after = text_after
      @icon_before = icon_before
      @icon_after = icon_after
      @button_text = button_text
      @size = size
      @custom_classes = custom_classes

      super(**system_arguments)
    end

    def call
      case @type
      when 'checkbox'
        render_checkbox
      when 'toggle'
        render_toggle
      when 'radio'
        render_radio_group
      when 'btn'
        render_radio_buttons
      when 'dropdown'
        render_dropdown
      when 'swap'
        render_swap
      when 'toggle_icons_inside'
        render_toggle_icons_inside
      end
    end

    private

    def render_checkbox
      tag.input(
        type: 'checkbox',
        value: @value,
        checked: @checked,
        class: class_names('checkbox', 'theme-controller', @custom_classes, system_arguments[:class]),
        **system_arguments.except(:class)
      )
    end

    def render_toggle
      content = []
      content << tag.span(@text_before, class: 'label-text') if @text_before
      content << @icon_before if @icon_before
      
      input_classes = class_names('toggle', 'theme-controller', size_class, @custom_classes, system_arguments[:class])
      content << tag.input(
        type: 'checkbox',
        value: @value,
        checked: @checked,
        class: input_classes,
        **system_arguments.except(:class)
      )
      
      content << @icon_after if @icon_after
      content << tag.span(@text_after, class: 'label-text') if @text_after

      if has_wrapper_content?
        tag.label(safe_join(content), class: 'flex cursor-pointer gap-2')
      else
        content.first
      end
    end

    def render_radio_group
      return unless @themes

      tag.fieldset(class: 'fieldset') do
        safe_join(@themes.map { |theme| render_radio_item(theme) })
      end
    end

    def render_radio_item(theme)
      tag.label(class: 'flex gap-2 cursor-pointer items-center') do
        safe_join([
          tag.input(
            type: 'radio',
            name: @name,
            value: theme[:value],
            class: class_names('radio', size_class, 'theme-controller'),
            checked: theme[:checked]
          ),
          theme[:label]
        ])
      end
    end

    def render_radio_buttons
      return unless @themes

      tag.div(class: 'join join-vertical') do
        safe_join(@themes.map { |theme| render_radio_button_item(theme) })
      end
    end

    def render_radio_button_item(theme)
      tag.input(
        type: 'radio',
        name: @name,
        value: theme[:value],
        class: class_names('btn', 'theme-controller', 'join-item'),
        'aria-label': theme[:label],
        checked: theme[:checked]
      )
    end

    def render_dropdown
      return unless @themes

      tag.div(class: 'dropdown mb-72') do
        safe_join([
          render_dropdown_button,
          render_dropdown_menu
        ])
      end
    end

    def render_dropdown_button
      tag.div(tabindex: '0', role: 'button', class: 'btn m-1') do
        safe_join([
          @button_text,
          dropdown_chevron
        ])
      end
    end

    def render_dropdown_menu
      tag.ul(tabindex: '0', class: 'dropdown-content bg-base-300 rounded-box z-1 w-52 p-2 shadow-2xl') do
        safe_join(@themes.map { |theme| render_dropdown_item(theme) })
      end
    end

    def render_dropdown_item(theme)
      tag.li do
        tag.input(
          type: 'radio',
          name: @name,
          value: theme[:value],
          class: 'theme-controller w-full btn btn-sm btn-block btn-ghost justify-start',
          'aria-label': theme[:label],
          checked: theme[:checked]
        )
      end
    end

    def render_swap
      tag.label(class: 'swap swap-rotate') do
        safe_join([
          tag.input(
            type: 'checkbox',
            value: @value,
            class: 'theme-controller',
            checked: @checked
          ),
          render_swap_icons
        ].flatten)
      end
    end

    def render_toggle_icons_inside
      tag.label(class: 'toggle text-base-content') do
        safe_join([
          tag.input(
            type: 'checkbox',
            value: @value,
            class: 'theme-controller',
            checked: @checked
          ),
          tag.i('', class: 'ph ph-sun', 'aria-label': 'sun'),
          tag.i('', class: 'ph ph-moon', 'aria-label': 'moon')
        ])
      end
    end

    def render_swap_icons
      [
        # Sun icon (swap-off)
        tag.svg(
          class: 'swap-off h-10 w-10 fill-current',
          xmlns: 'http://www.w3.org/2000/svg',
          viewBox: '0 0 24 24'
        ) do
          tag.path(d: 'M5.64,17l-.71.71a1,1,0,0,0,0,1.41,1,1,0,0,0,1.41,0l.71-.71A1,1,0,0,0,5.64,17ZM5,12a1,1,0,0,0-1-1H3a1,1,0,0,0,0,2H4A1,1,0,0,0,5,12Zm7-7a1,1,0,0,0,1-1V3a1,1,0,0,0-2,0V4A1,1,0,0,0,12,5ZM5.64,7.05a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.41l-.71-.71A1,1,0,0,0,4.93,6.34Zm12,.29a1,1,0,0,0,.7-.29l.71-.71a1,1,0,1,0-1.41-1.41L17,5.64a1,1,0,0,0,0,1.41A1,1,0,0,0,17.66,7.34ZM21,11H20a1,1,0,0,0,0,2h1a1,1,0,0,0,0-2Zm-9,8a1,1,0,0,0-1,1v1a1,1,0,0,0,2,0V20A1,1,0,0,0,12,19ZM18.36,17A1,1,0,0,0,17,18.36l.71.71a1,1,0,0,0,1.41,0,1,1,0,0,0,0-1.41ZM12,6.5A5.5,5.5,0,1,0,17.5,12,5.51,5.51,0,0,0,12,6.5Zm0,9A3.5,3.5,0,1,1,15.5,12,3.5,3.5,0,0,1,12,15.5Z')
        end,
        # Moon icon (swap-on) 
        tag.svg(
          class: 'swap-on h-10 w-10 fill-current',
          xmlns: 'http://www.w3.org/2000/svg',
          viewBox: '0 0 24 24'
        ) do
          tag.path(d: 'M21.64,13a1,1,0,0,0-1.05-.14,8.05,8.05,0,0,1-3.37.73A8.15,8.15,0,0,1,9.08,5.49a8.59,8.59,0,0,1,.25-2A1,1,0,0,0,8,2.36,10.14,10.14,0,1,0,22,14.05,1,1,0,0,0,21.64,13Zm-9.5,6.69A8.14,8.14,0,0,1,7.08,5.22v.27A10.15,10.15,0,0,0,17.22,15.63a9.79,9.79,0,0,0,2.1-.22A8.11,8.11,0,0,1,12.14,19.73Z')
        end
      ]
    end

    def dropdown_chevron
      tag.svg(
        width: '12px',
        height: '12px',
        class: 'inline-block h-2 w-2 fill-current opacity-60',
        xmlns: 'http://www.w3.org/2000/svg',
        viewBox: '0 0 2048 2048'
      ) do
        tag.path(d: 'M1799 349l242 241-1017 1017L7 590l242-241 775 775 775-775z')
      end
    end

    def size_class
      return unless @size

      case @size.to_s
      when 'sm'
        case @type
        when 'radio'
          'radio-sm'
        when 'toggle'
          'toggle-sm'
        else
          nil
        end
      else
        nil
      end
    end

    def has_wrapper_content?
      @text_before || @text_after || @icon_before || @icon_after
    end
  end
end