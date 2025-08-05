# frozen_string_literal: true

# @label Tabs
module DaisyUI
  module Navigation
    class TabsPreview < ViewComponent::Preview
      include DaisyUI::IconsHelper

      # @!group Playground

      # Playground
      # ---
      # Interactive playground for Tabs component
      # @param style [Symbol] select { choices: [default, bordered, lifted, boxed] }
      # @param size [Symbol] select { choices: [xs, sm, md, lg] }
      # @param show_content [Boolean] toggle Show tab content panels
      # @param custom_classes [String] text "Custom CSS classes"
      def playground(
        style: :default,
        size: :md,
        show_content: true,
        custom_classes: ''
      )
        render DaisyUI::Tabs.new(
          style: style,
          size: size,
          show_content: show_content,
          class: custom_classes,
          tabs: [
            { text: 'Home', content: '<p>Welcome to the home page! This is where you will find all the latest updates and news.</p>'.html_safe, active: true },
            { text: 'About', content: '<p>Learn more about our company and what we do. We are committed to excellence and innovation.</p>'.html_safe },
            { text: 'Services', content: '<p>Discover our range of services and how we can help you achieve your goals.</p>'.html_safe },
            { text: 'Contact', content: '<p>Get in touch with us for any questions or inquiries. We are here to help!</p>'.html_safe, disabled: true }
          ]
        )
      end

      # @!endgroup

      # Basic tabs
      # ---
      # Basic tabs with content panels
      def basic_tabs
        render DaisyUI::Tabs.new(
          tabs: [
            { text: 'Tab 1', content: 'Content for Tab 1', active: true },
            { text: 'Tab 2', content: 'Content for Tab 2' },
            { text: 'Tab 3', content: 'Content for Tab 3' }
          ]
        )
      end

      # Bordered tabs
      # ---
      # Tabs with bordered style
      def bordered_tabs
        render DaisyUI::Tabs.new(
          style: :bordered,
          tabs: [
            { text: 'Home', content: 'Home content goes here', active: true },
            { text: 'About', content: 'About content goes here' },
            { text: 'Contact', content: 'Contact content goes here' }
          ]
        )
      end

      # Lifted tabs
      # ---
      # Tabs with lifted style
      def lifted_tabs
        render DaisyUI::Tabs.new(
          style: :lifted,
          tabs: [
            { text: 'Dashboard', content: 'Dashboard overview and statistics', active: true },
            { text: 'Analytics', content: 'Detailed analytics and reports' },
            { text: 'Settings', content: 'User settings and preferences' }
          ]
        )
      end

      # Boxed tabs
      # ---
      # Tabs with boxed style
      def boxed_tabs
        render DaisyUI::Tabs.new(
          style: :boxed,
          tabs: [
            { text: 'Projects', content: 'Your active projects and tasks', active: true },
            { text: 'Team', content: 'Team members and collaboration' },
            { text: 'Reports', content: 'Project reports and summaries' }
          ]
        )
      end

      # Tab sizes
      # ---
      # Different tab sizes demonstration
      def tab_sizes
        render_with_template
      end

      # Tabs with disabled items
      # ---
      # Demonstrates disabled tabs
      def tabs_with_disabled_items
        render DaisyUI::Tabs.new(
          style: :bordered,
          tabs: [
            { text: 'Available', content: 'This tab is available', active: true },
            { text: 'Also Available', content: 'This tab is also available' },
            { text: 'Disabled', content: 'This content is not accessible', disabled: true },
            { text: 'Coming Soon', content: 'Feature coming soon', disabled: true }
          ]
        )
      end

      # Tabs without content
      # ---
      # Tabs used for navigation without content panels
      def tabs_without_content
        render DaisyUI::Tabs.new(
          style: :lifted,
          show_content: false,
          tabs: [
            { text: 'Home', href: '#home', active: true },
            { text: 'Products', href: '#products' },
            { text: 'Services', href: '#services' },
            { text: 'About', href: '#about' }
          ]
        )
      end

      # Navigation tabs
      # ---
      # Tabs used as navigation links
      def navigation_tabs
        render DaisyUI::Tabs.new(
          style: :boxed,
          show_content: false,
          class: 'w-fit',
          tabs: [
            { text: 'Dashboard', href: '/dashboard', active: true },
            { text: 'Users', href: '/users' },
            { text: 'Settings', href: '/settings' },
            { text: 'Logout', href: '/logout', method: :delete }
          ]
        )
      end

      # Tabs with rich content
      # ---
      # Tabs with complex HTML content
      def tabs_with_rich_content
        render DaisyUI::Tabs.new(
          style: :bordered,
          size: :lg,
          tabs: [
            { 
              text: 'Overview', 
              content: '
                <div class="space-y-4">
                  <h3 class="text-lg font-semibold">Welcome to the Overview</h3>
                  <p>This is a comprehensive overview of all the features and capabilities.</p>
                  <div class="stats shadow">
                    <div class="stat">
                      <div class="stat-title">Downloads</div>
                      <div class="stat-value">31K</div>
                    </div>
                    <div class="stat">
                      <div class="stat-title">Users</div>
                      <div class="stat-value">4,200</div>
                    </div>
                  </div>
                </div>
              '.html_safe,
              active: true 
            },
            { 
              text: 'Features', 
              content: '
                <div class="space-y-4">
                  <h3 class="text-lg font-semibold">Key Features</h3>
                  <ul class="list-disc list-inside space-y-2">
                    <li>Feature 1: Advanced functionality</li>
                    <li>Feature 2: User-friendly interface</li>
                    <li>Feature 3: Powerful integrations</li>
                    <li>Feature 4: Mobile responsive</li>
                  </ul>
                </div>
              '.html_safe
            },
            { 
              text: 'Support', 
              content: '
                <div class="space-y-4">
                  <h3 class="text-lg font-semibold">Get Support</h3>
                  <p>Need help? We are here to assist you!</p>
                  <div class="flex gap-2">
                    <button class="btn btn-primary">Contact Support</button>
                    <button class="btn btn-outline">View Docs</button>
                  </div>
                </div>
              '.html_safe
            }
          ]
        )
      end

      # JavaScript ready tabs
      # ---
      # Tabs with data attributes ready for JavaScript integration
      def javascript_ready_tabs
        render DaisyUI::Tabs.new(
          style: :bordered,
          class: 'mb-4',
          data: { controller: 'tabs' },
          tabs: [
            { text: 'Profile', content: '<div class="p-4"><h3 class="font-bold">Profile Settings</h3><p>Manage your profile information and preferences.</p></div>'.html_safe, active: true },
            { text: 'Account', content: '<div class="p-4"><h3 class="font-bold">Account Settings</h3><p>Update your account details and security settings.</p></div>'.html_safe },
            { text: 'Billing', content: '<div class="p-4"><h3 class="font-bold">Billing Information</h3><p>View and manage your subscription and payment methods.</p></div>'.html_safe },
            { text: 'Notifications', content: '<div class="p-4"><h3 class="font-bold">Notification Preferences</h3><p>Configure how and when you receive notifications.</p></div>'.html_safe }
          ]
        )
      end

      # Responsive tabs
      # ---
      # Tabs that adapt to different screen sizes
      def responsive_tabs
        render DaisyUI::Tabs.new(
          style: :lifted,
          size: :sm,
          class: 'w-full sm:w-auto',
          tabs: [
            { text: 'Mobile', content: 'Content optimized for mobile devices', active: true },
            { text: 'Tablet', content: 'Content optimized for tablet devices' },
            { text: 'Desktop', content: 'Content optimized for desktop devices' }
          ]
        )
      end
    end
  end
end
