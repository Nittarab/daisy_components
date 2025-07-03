# frozen_string_literal: true

# @label Stat
# @display bg_color "#fff"
module DaisyUI
  module DataDisplay
    class StatPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground
      # Default
      # ---------------
      # Interactive stat component with customizable options
      #
      # @param title text "Stat title"
      # @param value text "Stat value"
      # @param description text "Stat description"
      # @param direction select {choices: [horizontal, vertical, responsive]}
      # @param shadow toggle "Add shadow"
      # @param centered toggle "Center align items"
      # @param has_icon toggle "Add icon"
      # @param classes text "Additional CSS classes"
      def playground(
        title: 'Total Page Views',
        value: '89,400',
        description: '21% more than last month',
        direction: :horizontal,
        shadow: true,
        centered: false,
        has_icon: false,
        classes: ''
      )
        render(DaisyUI::Stat.new(
                 title: title,
                 value: value,
                 description: description,
                 direction: direction,
                 shadow: shadow,
                 centered: centered,
                 class: classes
               )) do |component|
          if has_icon
            component.with_stat do |stat|
              stat.with_figure { heart_icon(class: 'h-8 w-8 text-primary inline-block stroke-current') }
              stat.with_title { title }
              stat.with_value(color: :primary) { value }
              stat.with_description { description }
            end
          end
        end
      end

      # @!endgroup

      # Stat
      # ---
      # Basic stat showing a single data point
      def stat
        render(DaisyUI::Stat.new(
                 title: 'Total Page Views',
                 value: '89,400',
                 description: '21% more than last month',
                 shadow: true
               ))
      end

      # Stat with icons or image
      # ---
      # Multiple stats with icons, avatars, and different color values
      def stat_with_icons_or_image
        render_with_template(locals: { helper: self })
      end

      # Centered items
      # ---
      # Stats with centered alignment for cleaner appearance
      def centered_items
        render(DaisyUI::Stat.new(shadow: true)) do |component|
          component.with_stat(
            title: 'Downloads',
            value: '31K',
            description: 'From January 1st to February 1st',
            centered: true
          )
          component.with_stat(
            title: 'Users',
            value: '4,200',
            description: '↗︎ 40 (2%)',
            centered: true
          )
          component.with_stat(
            title: 'New Registers',
            value: '1,200',
            description: '↘︎ 90 (14%)',
            centered: true
          )
        end
      end

      # Vertical
      # ---
      # Stats arranged vertically instead of horizontally
      def vertical
        render(DaisyUI::Stat.new(direction: :vertical, shadow: true)) do |component|
          component.with_stat(
            title: 'Downloads',
            value: '31K',
            description: 'Jan 1st - Feb 1st'
          )
          component.with_stat(
            title: 'New Users',
            value: '4,200',
            description: '↗︎ 400 (22%)'
          )
          component.with_stat(
            title: 'New Registers',
            value: '1,200',
            description: '↘︎ 90 (14%)'
          )
        end
      end

      # Responsive (vertical on small screen, horizontal on large screen)
      # ---
      # Stats that adapt layout based on screen size
      def responsive_vertical_on_small_screen_horizontal_on_large_screen
        render(DaisyUI::Stat.new(direction: :responsive, shadow: true)) do |component|
          component.with_stat(
            title: 'Downloads',
            value: '31K',
            description: 'Jan 1st - Feb 1st'
          )
          component.with_stat(
            title: 'New Users',
            value: '4,200',
            description: '↗︎ 400 (22%)'
          )
          component.with_stat(
            title: 'New Registers',
            value: '1,200',
            description: '↘︎ 90 (14%)'
          )
        end
      end

      # With custom colors and button
      # ---
      # Stats with custom styling and action buttons
      def with_custom_colors_and_button
        render(DaisyUI::Stat.new(class: 'bg-base-100 border-base-300 border')) do |component|
          component.with_stat do |stat|
            stat.with_title { 'Account balance' }
            stat.with_value { '$89,400' }
            stat.with_actions do
              render(DaisyUI::Button.new(text: 'Add funds', size: :xs, color: :success))
            end
          end
          component.with_stat do |stat|
            stat.with_title { 'Current balance' }
            stat.with_value { '$89,400' }
            stat.with_actions do
              safe_join([
                          render(DaisyUI::Button.new(text: 'Withdrawal', size: :xs)),
                          ' ',
                          render(DaisyUI::Button.new(text: 'Deposit', size: :xs))
                        ])
            end
          end
        end
      end
    end
  end
end