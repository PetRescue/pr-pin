if ENV.fetch('COVERAGE', false)
  require 'simplecov'

  SimpleCov.start do
    minimum_coverage 90
    maximum_coverage_drop 2
    add_filter %r{^/spec/}
  end
end

require 'pathname'
require 'securerandom'
require 'bundler/setup'

SPEC_ROOT = root = Pathname(__FILE__).dirname
SUPPORT_FILES = Dir[root.join('support/*.rb').to_s].sort_by(&File.method(:basename))
SHARED_FILES = Dir[root.join('shared/**/*.rb').to_s]

begin
  require 'pry'
  require 'pry-byebug'
rescue LoadError
end

require 'pr-pin'

SUPPORT_FILES.each(&method(:require))
SHARED_FILES.each(&method(:require))

RSpec.configure do |config|
  config.after do
    Test.remove_constants
  end

  config.around do |example|
    ConstantLeakFinder.find(example)
  end

  config.disable_monkey_patching!
  config.warnings = true
  config.filter_run_when_matching :focus
end
