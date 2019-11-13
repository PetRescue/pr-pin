
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pr/pin/version'

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
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/PetRescue/pr-pin'
    spec.metadata['changelog_uri'] = 'https://github.com/PetRescue/pr-pin/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_runtime_dependency 'dry-container'
  spec.add_runtime_dependency 'dry-inflector'
  spec.add_runtime_dependency 'dry-types'
  spec.add_runtime_dependency 'rom', '5.1.2'
  spec.add_runtime_dependency 'rom-http', '0.8.0'
end
