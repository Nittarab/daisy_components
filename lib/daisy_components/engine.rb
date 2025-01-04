# frozen_string_literal: true

module DaisyComponents
  class Engine < ::Rails::Engine
    isolate_namespace DaisyComponents

    # Only load Lookbook in development
    if Rails.env.development?
      initializer 'daisy_components.lookbook' do |_app|
        # Configure Lookbook paths relative to the engine
        Lookbook.configure do |config|
          # Initialize paths as arrays before appending
          config.preview_paths = [root.join('test/components/previews')]
          config.layout_paths = [root.join('test/components/previews/layouts')]
          config.page_paths = [root.join('test/components/docs')]

          # Group components by their namespace
          config.preview_nav_groups = {
            'Actions' => 'daisy_components/actions/*',
            'Data Display' => 'daisy_components/data_display/*',
            'Data Input' => 'daisy_components/data_input/*',
            'Layout' => 'daisy_components/layout/*',
            'Navigation' => 'daisy_components/navigation/*',
            'Feedback' => 'daisy_components/feedback/*'
          }

          # Configure the default display options
          config.display_options = {
            theme: 'light',
            bg_color: '#ffffff',
            padding: true
          }
        end
      end
    end
  end
end
