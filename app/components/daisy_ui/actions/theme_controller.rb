# frozen_string_literal: true

module DaisyUI
  # Theme Controller component implementing DaisyUI's theme switching functionality
  #
  # @example Simple checkbox theme controller
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :checkbox,
  #     value: 'synthwave'
  #   )) %>
  #
  # @example Toggle with text labels
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :toggle,
  #     value: 'synthwave',
  #     label_before: 'Current',
  #     label_after: 'Synthwave'
  #   )) %>
  #
  # @example Toggle with icons
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :toggle,
  #     value: 'synthwave',
  #     icon_before: helpers.sun_icon,
  #     icon_after: helpers.moon_icon
  #   )) %>
  #
  # @example Radio button group
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :radio_buttons,
  #     name: 'theme-buttons',
  #     themes: [
  #       { value: 'default', label: 'Default' },
  #       { value: 'retro', label: 'Retro' },
  #       { value: 'cyberpunk', label: 'Cyberpunk' }
  #     ]
  #   )) %>
  #
  # @example Radio inputs with fieldset
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :radio_inputs,
  #     name: 'theme-radios',
  #     themes: [
  #       { value: 'default', label: 'Default' },
  #       { value: 'retro', label: 'Retro' }
  #     ]
  #   )) %>
  #
  # @example Dropdown theme selector
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :dropdown,
  #     button_text: 'Theme',
  #     themes: [
  #       { value: 'default', label: 'Default' },
  #       { value: 'retro', label: 'Retro' },
  #       { value: 'cyberpunk', label: 'Cyberpunk' }
  #     ]
  #   )) %>
  #
  # @example Swap with icons
  #   <%= render(DaisyUI::ThemeController.new(
  #     type: :swap,
  #     value: 'synthwave',
  #     icon_on: helpers.moon_icon(class: 'swap-off h-10 w-10 fill-current'),
  #     icon_off: helpers.sun_icon(class: 'swap-on h-10 w-10 fill-current')
  #   )) %>
  class ThemeController < BaseComponent
    # Available input types
    TYPES = %w[checkbox toggle radio_buttons radio_inputs dropdown swap].freeze

    # Available toggle styles
    TOGGLE_STYLES = {
      default: '',
      inside_icons: 'toggle text-base-content'
    }.freeze

    # @param type [String] The type of theme controller (checkbox/toggle/radio_buttons/radio_inputs/dropdown/swap)
    # @param value [String] The theme value for single theme controllers
    # @param name [String] The name attribute for radio inputs
    # @param checked [Boolean] Whether the input is initially checked
    # @param themes [Array<Hash>] Array of theme options for multi-theme controllers
    # @param label_before [String] Text label before the input
    # @param label_after [String] Text label after the input
    # @param icon_before [String] Icon before the input
    # @param icon_after [String] Icon after the input
    # @param icon_on [String] Icon for swap component's on state
    # @param icon_off [String] Icon for swap component's off state
    # @param button_text [String] Text for dropdown button
    # @param custom_classes [String] Additional CSS classes for the input
    # @param toggle_style [String] Style variant for toggle components
    # @param system_arguments [Hash] Additional HTML attributes
    def initialize( # rubocop:disable Metrics/ParameterLists
      type:,
      value: nil,
      name: nil,
      checked: false,
      themes: nil,
      label_before: nil,
      label_after: nil,
      icon_before: nil,
      icon_after: nil,
      icon_on: nil,
      icon_off: nil,
      button_text: 'Theme',
      custom_classes: nil,
      toggle_style: :default,
      **system_arguments
    )
      @type = validate_type!(type)
      @value = value
      @name = name
      @checked = checked
      @themes = themes
      @label_before = label_before
      @label_after = label_after
      @icon_before = icon_before
      @icon_after = icon_after
      @icon_on = icon_on
      @icon_off = icon_off
      @button_text = button_text
      @custom_classes = custom_classes
      @toggle_style = build_argument(toggle_style, TOGGLE_STYLES, 'toggle_style')
      super(**system_arguments)
    end

    def call
      case @type
      when 'checkbox'
        render_checkbox
      when 'toggle'
        render_toggle
      when 'radio_buttons'
        render_radio_buttons
      when 'radio_inputs'
        render_radio_inputs
      when 'dropdown'
        render_dropdown
      when 'swap'
        render_swap
      end
    end

    private

    def validate_type!(type)
      type_str = type.to_s
      return type_str if TYPES.include?(type_str)

      raise ArgumentError, "Invalid type: #{type}. Must be one of: #{TYPES.join(', ')}"
    end

    def render_checkbox
      tag.input(**checkbox_attributes)
    end

    def render_toggle
      if @toggle_style == 'toggle text-base-content'
        # Special case for toggle with icons inside
        tag.label(class: @toggle_style) do
          safe_join([
            tag.input(**toggle_inside_attributes),
            content
          ].compact)
        end
      elsif @label_before || @label_after || @icon_before || @icon_after
        tag.label(class: toggle_label_classes) do
          safe_join([
            @label_before ? tag.span(@label_before, class: 'label-text') : @label_before,
            @icon_before,
            tag.input(**toggle_attributes),
            @label_after ? tag.span(@label_after, class: 'label-text') : @label_after,
            @icon_after
          ].compact)
        end
      else
        tag.input(**toggle_attributes)
      end
    end

    def render_radio_buttons
      return unless @themes&.any?

      tag.div(class: 'join join-vertical') do
        safe_join(@themes.map { |theme| render_radio_button(theme) })
      end
    end

    def render_radio_inputs
      return unless @themes&.any?

      tag.fieldset(class: 'fieldset') do
        safe_join(@themes.map { |theme| render_radio_input(theme) })
      end
    end

    def render_dropdown
      return unless @themes&.any?

      tag.div(class: 'dropdown mb-72') do
        safe_join([
          render_dropdown_button,
          render_dropdown_menu
        ])
      end
    end

    def render_swap
      tag.label(class: 'swap swap-rotate') do
        safe_join([
          '<!-- this hidden checkbox controls the state -->'.html_safe,
          tag.input(**swap_attributes),
          '<!-- sun icon -->'.html_safe,
          @icon_off,
          '<!-- moon icon -->'.html_safe,
          @icon_on
        ].compact)
      end
    end

    def checkbox_attributes
      {
        type: 'checkbox',
        value: @value,
        class: class_names('checkbox theme-controller', @custom_classes, system_arguments[:class]),
        checked: @checked || nil,
        **system_arguments.except(:class)
      }.compact
    end

    def toggle_attributes
      classes = case @toggle_style
                when 'toggle text-base-content'
                  @toggle_style
                else
                  class_names('toggle theme-controller', @custom_classes, system_arguments[:class])
                end

      {
        type: 'checkbox',
        value: @value,
        class: classes,
        checked: @checked || nil,
        **system_arguments.except(:class)
      }.compact
    end

    def toggle_inside_attributes
      {
        type: 'checkbox',
        value: @value,
        class: class_names('theme-controller', @custom_classes, system_arguments[:class]),
        checked: @checked || nil,
        **system_arguments.except(:class)
      }.compact
    end

    def toggle_label_classes
      class_names('flex cursor-pointer gap-2', system_arguments[:class])
    end

    def render_radio_button(theme)
      tag.input(
        type: 'radio',
        name: @name,
        class: 'btn theme-controller join-item',
        'aria-label': theme[:label],
        value: theme[:value],
        checked: theme[:checked] || nil
      )
    end

    def render_radio_input(theme)
      tag.label(class: 'flex gap-2 cursor-pointer items-center') do
        safe_join([
          tag.input(
            type: 'radio',
            name: @name,
            class: 'radio radio-sm theme-controller',
            value: theme[:value],
            checked: theme[:checked] || nil
          ),
          ' ',
          theme[:label],
          ' '
        ])
      end
    end

    def render_dropdown_button
      tag.div(tabindex: '0', role: 'button', class: 'btn m-1') do
        safe_join([
          @button_text,
          ' ',
          dropdown_chevron_icon
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
          name: @name || 'theme-dropdown',
          class: 'theme-controller w-full btn btn-sm btn-block btn-ghost justify-start',
          'aria-label': theme[:label],
          value: theme[:value],
          checked: theme[:checked] || nil
        )
      end
    end

    def swap_attributes
      {
        type: 'checkbox',
        class: class_names('theme-controller', @custom_classes, system_arguments[:class]),
        value: @value,
        checked: @checked || nil,
        **system_arguments.except(:class)
      }.compact
    end

    def dropdown_chevron_icon
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
  end
end