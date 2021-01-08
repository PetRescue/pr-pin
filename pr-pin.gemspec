require File.expand_path('../lib/pr/pin/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'pr-pin'
  spec.version       = PR::Pin::VERSION
  spec.authors       = ['AMHOL']
  spec.email         = ['andyholland1991@aol.com']

  spec.summary       = %q{Pin Payments API wrapper inplemented using rom-rb HTTP adapter.}
  spec.description   = %q{Pin Payments API wrapper inplemented using rom-rb HTTP adapter.}
  spec.homepage      = 'https://github.com/PetRescue/pr-pin'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata = {
    'homepage_uri'    => spec.homepage,
    'source_code_uri' => spec.homepage,
    'bug_tracker_uri' => 'https://github.com/PetRescue/pr-pin/issues'
  }

  spec.files = Dir['LICENSE', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'pry'
  spec.add_runtime_dependency 'concurrent-ruby'
  spec.add_runtime_dependency 'dry-container'
  spec.add_runtime_dependency 'dry-inflector'
  spec.add_runtime_dependency 'dry-types'
  spec.add_runtime_dependency 'rom', '>= 5.0.0'
  # spec.add_runtime_dependency 'rom-http', '>= 0.8.0'
end
