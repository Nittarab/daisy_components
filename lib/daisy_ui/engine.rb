# frozen_string_literal: true

module DaisyUI
  class Engine < ::Rails::Engine
    isolate_namespace DaisyUI

    # Configure inflector for proper constant mapping
    config.before_initialize do
      Rails.autoloaders.each do |autoloader|
        autoloader.inflector.inflect(
          'daisy_ui' => 'DaisyUI'
        )

        # Collapse directories to avoid nested namespaces
        autoloader.collapse(root.join('app/components/daisy_ui/actions'))
        autoloader.collapse(root.join('app/components/daisy_ui/data_display'))
        autoloader.collapse(root.join('app/components/daisy_ui/navigation'))
      end
    end

    # Only load Lookbook in development
    if Rails.env.development?
      initializer 'daisyui.lookbook' do |_app|
        # Configure Lookbook paths relative to the engine
        Lookbook.configure do |config|
          # Initialize paths as arrays before appending
          config.preview_paths = [root.join('test/components/previews')]
          config.layout_paths = [root.join('test/components/previews/layouts')]
          config.page_paths = [root.join('test/components/docs')]

          # Group components by their namespace
          config.preview_nav_groups = {
            'Actions' => 'daisyui/actions/*',
            'Data Display' => 'daisyui/data_display/*',
            'Data Input' => 'daisyui/data_input/*',
            'Layout' => 'daisyui/layout/*',
            'Navigation' => 'daisyui/navigation/*'
          }

          # Configure the default display options
          config.display_options = {
            theme: 'light',
            bg_color: '#ffffff',
            padding: true
          }
        end
      end

      config.autoload_paths << root.join('app/components')
    end
  end
end
