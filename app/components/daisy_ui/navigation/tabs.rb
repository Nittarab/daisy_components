# frozen_string_literal: true

module DaisyUI
  # Tabs component implementing DaisyUI's tabs styles
  #
  # @example Basic usage with parameters
  #   <%= render DaisyUI::Tabs.new(
  #     tabs: [
  #       { text: "Tab 1", content: "Content 1", active: true },
  #       { text: "Tab 2", content: "Content 2" },
  #       { text: "Tab 3", content: "Content 3" }
  #     ]
  #   ) %>
  #
  # @example With different styles
  #   <%= render DaisyUI::Tabs.new(
  #     style: :bordered,
  #     size: :lg,
  #     tabs: [
  #       { text: "Home", content: "Home content", active: true },
  #       { text: "About", content: "About content" },
  #       { text: "Contact", content: "Contact content", disabled: true }
  #     ]
  #   ) %>
  #
  # @example Using slots for complex tabs
  #   <%= render(DaisyUI::Tabs.new(style: :lifted)) do |tabs| %>
  #     <% tabs.with_tab(text: "Tab 1", active: true) do %>
  #       <p>Custom content for tab 1</p>
  #     <% end %>
  #     <% tabs.with_tab(text: "Tab 2") do %>
  #       <p>Custom content for tab 2</p>
  #     <% end %>
  #   <% end %>
  #
  # @example Tabs only (without content panels)
  #   <%= render DaisyUI::Tabs.new(
  #     style: :boxed,
  #     show_content: false,
  #     tabs: [
  #       { text: "Home", href: "/", active: true },
  #       { text: "About", href: "/about" },
  #       { text: "Contact", href: "/contact" }
  #     ]
  #   ) %>
  #
  # @note If both `tabs` parameters and a block with `with_tab` are provided,
  #   the tabs from parameters will be rendered first, followed by tabs defined in the block.

  class Tabs < BaseComponent
    # Available tab styles from DaisyUI
    STYLES = {
      default: nil,
      bordered: 'tabs-bordered',
      lifted: 'tabs-lifted',
      boxed: 'tabs-boxed'
    }.freeze

    # Available tab sizes from DaisyUI
    SIZES = {
      xs: 'tabs-xs',
      sm: 'tabs-sm',
      md: 'tabs-md',
      lg: 'tabs-lg'
    }.freeze

    # Polymorphic slot for tab elements
    renders_many :tabs, 'DaisyUI::Tabs::Tab'

    # @param tabs [Array<Hash>] Optional array of tab hashes. Each hash should contain:
    #   - text [String] Tab label text
    #   - content [String] Tab content (optional if show_content is false)
    #   - active [Boolean] Whether this tab is active (default: false)
    #   - disabled [Boolean] Whether this tab is disabled (default: false)
    #   - href [String] Link URL if tab should be a link instead of button
    # @param style [Symbol] Tab style (:default, :bordered, :lifted, :boxed)
    # @param size [Symbol] Tab size (:xs, :sm, :md, :lg)
    # @param show_content [Boolean] Whether to show tab content panels (default: true)
    # @param system_arguments [Hash] Additional HTML attributes for the tabs container.
    def initialize(
      tabs: nil,
      style: :default,
      size: nil,
      show_content: true,
      **system_arguments
    )
      super(**system_arguments)

      tabs&.each do |tab_options|
        with_tab(**tab_options)
      end

      @style = build_argument(style, STYLES, 'style')
      @size = build_argument(size, SIZES, 'size')
      @show_content = show_content
    end

    def call
      if @show_content
        tag.div(class: 'tabs-container', **system_arguments.except(:class)) do
          safe_join([render_tabs, render_content].compact)
        end
      else
        render_tabs
      end
    end

    private

    def render_tabs
      tag.div(role: 'tablist', class: computed_tab_classes, **(@show_content ? {} : system_arguments.except(:class))) do
        tabs.each_with_index.map do |tab, index|
          tab.call(index: index, show_content: @show_content)
        end
      end
    end

    def render_content
      return unless @show_content

      tag.div(class: 'tab-content-container mt-4') do
        tabs.each_with_index.map do |tab, index|
          next unless tab.content.present?

          tag.div(
            class: class_names('tab-panel', { 'hidden' => !tab.active }),
            role: 'tabpanel',
            id: "tab-panel-#{index}",
            'aria-labelledby' => "tab-#{index}"
          ) do
            tab.content
          end
        end
      end
    end

    def computed_tab_classes
      modifiers = ['tabs']
      modifiers << @style if @style.present?
      modifiers << @size if @size.present?

      class_names(modifiers, system_arguments[:class])
    end
  end
end
