# frozen_string_literal: true

module DaisyUI
  # Navbar component
  #
  # Displays a responsive navigation bar that can contain branding, navigation links,
  # and other actions. It is structured into three main sections: start, center, and end.
  #
  # @param shadow [Boolean] (false) If true, adds a subtle shadow below the navbar.
  # @param **system_arguments [Hash] HTML attributes to be applied to the main navbar `div` tag.
  #   This allows for customization of classes, IDs, or other attributes.
  #
  # @slot navbar_start [Proc] Defines the content for the left-aligned section of the navbar.
  #   Typically used for logos, branding, or hamburger menus on smaller screens.
  #   Accepts `**system_arguments` which are passed to the wrapping `div.navbar-start`.
  #   Example: `c.navbar_start(class: "custom-class") { "Brand" }`
  # @slot navbar_center [Proc] Defines the content for the center-aligned section of the navbar.
  #   Often used for primary navigation links. Can be hidden on smaller screens if needed.
  #   Accepts `**system_arguments` which are passed to the wrapping `div.navbar-center`.
  #   Example: `c.navbar_center { "Main Navigation" }`
  # @slot navbar_end [Proc] Defines the content for the right-aligned section of the navbar.
  #   Suitable for user avatars, action buttons, or secondary navigation.
  #   Accepts `**system_arguments` which are passed to the wrapping `div.navbar-end`.
  #   Example: `c.navbar_end { "User Profile" }`
  #
  # @return [String] The HTML string representing the rendered navbar component.
  #
  class Navbar < BaseComponent
    renders_one :navbar_start, lambda { |*_args, **system_arguments, &block|
      system_arguments[:class] = class_names('navbar-start', system_arguments[:class])
      tag.div(**system_arguments) { block.call }
    }

    renders_one :navbar_center, lambda { |*_args, **system_arguments, &block|
      system_arguments[:class] = class_names('navbar-center', system_arguments[:class])
      tag.div(**system_arguments) { block.call }
    }

    renders_one :navbar_end, lambda { |*_args, **system_arguments, &block|
      system_arguments[:class] = class_names('navbar-end', system_arguments[:class])
      tag.div(**system_arguments) { block.call }
    }

    # @param shadow [Boolean] (false) If true, adds a subtle shadow below the navbar.
    # @param **system_arguments [Hash] HTML attributes for the main navbar `div`.
    def initialize(shadow: false, **system_arguments)
      @shadow = shadow
      super(**system_arguments)
    end

    def call
      tag.div(**full_arguments) { content }
    end

    private

    def full_arguments
      base = {
        class: computed_classes
      }
      base.merge(system_arguments.except(:class))
    end

    def computed_classes
      modifiers = %w[navbar]
      modifiers << 'shadow-sm' if @shadow

      class_names(modifiers, system_arguments[:class])
    end
  end
end
