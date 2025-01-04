# frozen_string_literal: true

require_relative 'lib/daisy_components/version'

Gem::Specification.new do |spec|
  spec.name        = 'daisy_components'
  spec.version     = DaisyComponents::VERSION
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

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 8.0.1'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
