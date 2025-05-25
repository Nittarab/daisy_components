# frozen_string_literal: true

require_relative 'lib/daisy_ui/version'

Gem::Specification.new do |spec|
  spec.name        = 'daisy_components'
  spec.version     = DaisyUI::VERSION
  spec.authors     = ['Patrick Barattin']
  spec.email       = ['pbarattin@gmail.com']
  spec.homepage    = 'https://github.com/pbarattin/daisy_components'
  spec.summary     = 'DaisyUI components for Rails'
  spec.description = 'A collection of ViewComponents implementing DaisyUI design system'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.4.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "TODO: Put your gem's public repo URL here."
  spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Use git to list files and then filter to include only necessary directories and top-level files.
  # This is often more reliable than Dir.glob, especially in complex build environments.
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    # Reject files/directories starting with specific prefixes (test, spec, tmp, .*)
    # or specific files like .rubocop.yml
    f.match(%r{^(test|spec|tmp|\.|Gemfile\.lock|\.rubocop\.yml)/}) || f == '.rubocop.yml'
  end

  spec.add_dependency 'rails', '>= 8.0.1'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # This tells Bundler what file to require when the gem is loaded
  spec.require_paths = ['lib']
end
