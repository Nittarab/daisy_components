# frozen_string_literal: true

require_relative 'lib/daisy_ui/version'

Gem::Specification.new do |spec|
  spec.name        = 'daisy_components'
  spec.version     = DaisyUI::VERSION
  spec.authors     = ['Patrick Barattin']
  spec.email       = ['p.barattin@gmail.com']
  spec.homepage    = 'https://github.com/Nittarab/daisy_components'
  spec.summary     = 'DaisyUI components for Rails'
  spec.description = 'A collection of ViewComponents implementing DaisyUI design system'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.3.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Nittarab/daisy_components'
  spec.metadata['changelog_uri'] = 'https://github.com/Nittarab/daisy_components/blob/main/CHANGELOG.md'

  # Use git to list files and then filter to include only necessary directories and top-level files.
  # This is often more reliable than Dir.glob, especially in complex build environments.
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    # Reject files/directories starting with specific prefixes (test, spec, tmp, .*)
    # or specific files like .rubocop.yml
    f.match(%r{^(test|spec|tmp|\.|Gemfile\.lock|\.rubocop\.yml)/}) || f == '.rubocop.yml'
  end

  spec.add_dependency 'lookbook', '>= 2.3.4'
  spec.add_dependency 'rails', '>= 7.0'
  spec.add_dependency 'redcarpet', '>= 3.6.1'
  spec.add_dependency 'view_component', '>= 3.21.0'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # This tells Bundler what file to require when the gem is loaded
  spec.require_paths = ['lib']
end
