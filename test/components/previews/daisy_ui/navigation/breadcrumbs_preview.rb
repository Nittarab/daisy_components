# frozen_string_literal: true

# @label Breadcrumbs
module DaisyUI
  module Navigation
    class BreadcrumbsPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Playground
      # ---
      # Interactive playground for Breadcrumbs component
      # @param size select { choices: [xs, sm, md, lg, xl] }
      # @param custom_classes text "Custom CSS classes (e.g., 'max-w-xs')"
      def playground(
        size: :sm,
        custom_classes: ''
      )
        render DaisyUI::Breadcrumbs.new(
          size: size,
          class: custom_classes,
          items: [
            { text: 'Home', href: '#', icon: phosphor_icon('ph-house', class: 'h-4 w-4') },
            { text: 'Documents', href: '#', icon: phosphor_icon('ph-folder', class: 'h-4 w-4') },
            { text: 'Add Document', icon: phosphor_icon('ph-plus', class: 'h-4 w-4') }
          ]
        )
      end

      # @!endgroup

      # Breadcrumbs
      # ---------------
      # Basic breadcrumbs with text links
      def breadcrumbs
        render DaisyUI::Breadcrumbs.new(
          items: [
            { text: 'Home', href: '' },
            { text: 'Documents', href: '' },
            { text: 'Add Document' }
          ]
        )
      end

      # Breadcrumbs with icons
      # ---------------
      # Breadcrumbs with icons for each item
      def breadcrumbs_with_icons
        render DaisyUI::Breadcrumbs.new(
          items: [
            { text: 'Home', href: '', icon: tag.i(class: 'ph ph-house h-4 w-4') },
            { text: 'Documents', href: '', icon: tag.i(class: 'ph ph-house h-4 w-4') },
            { text: 'Add Document', icon: tag.i(class: 'ph ph-plus h-4 w-4') }
          ]
        )
      end

      # Breadcrumbs with max width
      # ---------------
      # Breadcrumbs with max width constraint
      def breadcrumbs_with_max_width
        render DaisyUI::Breadcrumbs.new(
          class: 'max-w-xs',
          items: [
            { text: 'Long text 1' },
            { text: 'Long text 2' },
            { text: 'Long text 3' },
            { text: 'Long text 4' },
            { text: 'Long text 5' }
          ]
        )
      end
    end
  end
end
