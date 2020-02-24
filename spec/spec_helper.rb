require 'coveralls'
Coveralls.wear!

require 'pathname'
require 'securerandom'
require 'bundler/setup'

SPEC_ROOT = root = Pathname(__FILE__).dirname

begin
  require 'pry'
  require 'pry-byebug'
rescue LoadError
end

require 'pr-pin'

Dir[root.join('support/*.rb').to_s].each do |f|
  require f
end

Dir[root.join('shared/**/*.rb').to_s].each do |f|
  require f
end

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
