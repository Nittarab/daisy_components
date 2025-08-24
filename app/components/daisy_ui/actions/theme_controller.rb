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
    include IconsHelper
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
      when 'checkbox', 'toggle'
        render_input_with_wrapper(input_type: 'checkbox')
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

    def render_input_with_wrapper(input_type:)
      input_element = build_input(type: input_type)
      
      # For simple checkbox without wrapper content
      return input_element unless has_wrapper_content? || @type == 'toggle'
      
      # Build wrapper content
      content = []
      content << tag.span(@text_before, class: 'label-text') if @text_before
      content << @icon_before if @icon_before
      content << input_element
      content << @icon_after if @icon_after
      content << tag.span(@text_after, class: 'label-text') if @text_after

      tag.label(safe_join(content), class: 'flex cursor-pointer gap-2')
    end

    def build_input(type:)
      attributes = base_input_attributes(type: type)
      attributes[:class] = input_classes_for_type
      tag.input(**attributes)
    end

    def base_input_attributes(type:)
      attributes = {
        type: type,
        value: @value,
        **system_arguments.except(:class)
      }
      attributes[:checked] = true if @checked
      attributes
    end

    def input_classes_for_type
      case @type
      when 'checkbox'
        class_names('checkbox', 'theme-controller', @custom_classes, system_arguments[:class])
      when 'toggle'
        class_names('toggle', 'theme-controller', size_class, @custom_classes, system_arguments[:class])
      end
    end

    def render_radio_group
      return unless @themes

      tag.fieldset(class: 'fieldset') do
        safe_join(@themes.map { |theme| build_radio_item(theme, style: :standard) })
      end
    end

    def render_radio_buttons
      return unless @themes

      tag.div(class: 'join join-vertical') do
        safe_join(@themes.map { |theme| build_radio_item(theme, style: :button) })
      end
    end

    def build_radio_item(theme, style:)
      attributes = base_radio_attributes(theme)
      
      case style
      when :standard
        attributes[:class] = class_names('radio', size_class, 'theme-controller')
        build_radio_with_label(attributes, theme[:label])
      when :button
        attributes[:class] = class_names('btn', 'theme-controller', 'join-item')
        attributes['aria-label'] = theme[:label]
        tag.input(**attributes)
      end
    end

    def base_radio_attributes(theme)
      attributes = {
        type: 'radio',
        name: @name,
        value: theme[:value]
      }
      attributes[:checked] = true if theme[:checked]
      attributes
    end

    def build_radio_with_label(attributes, label)
      tag.label(class: 'flex gap-2 cursor-pointer items-center') do
        safe_join([
          tag.input(**attributes),
          label
        ])
      end
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
        safe_join(@themes.map { |theme| build_dropdown_item(theme) })
      end
    end

    def build_dropdown_item(theme)
      tag.li do
        attributes = base_radio_attributes(theme)
        attributes[:class] = 'theme-controller w-full btn btn-sm btn-block btn-ghost justify-start'
        attributes['aria-label'] = theme[:label]
        tag.input(**attributes)
      end
    end

    def render_swap
      attributes = base_checkbox_attributes
      attributes[:class] = 'theme-controller'
      
      tag.label(class: 'swap swap-rotate') do
        safe_join([
          tag.input(**attributes),
          render_swap_icons
        ].flatten)
      end
    end

    def render_toggle_icons_inside
      attributes = base_checkbox_attributes
      attributes[:class] = 'theme-controller'
      
      tag.label(class: 'toggle text-base-content') do
        safe_join([
          tag.input(**attributes),
          tag.i('', class: 'ph ph-sun', 'aria-label': 'sun'),
          tag.i('', class: 'ph ph-moon', 'aria-label': 'moon')
        ])
      end
    end

    def base_checkbox_attributes
      attributes = {
        type: 'checkbox',
        value: @value
      }
      attributes[:checked] = true if @checked
      attributes
    end

    def render_swap_icons
      [
        # Sun icon (swap-off)
        sun_icon(class: 'swap-off h-10 w-10', 'aria-label': 'sun'),
        # Moon icon (swap-on)
        moon_icon(class: 'swap-on h-10 w-10', 'aria-label': 'moon')
      ]
    end

    def dropdown_chevron
      chevron_down_icon(class: 'inline-block h-2 w-2 opacity-60')
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
