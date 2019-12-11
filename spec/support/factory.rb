require 'rom-factory'

builder = ROM::Factory.configure do |config|
  config.rom = PR::Pin.environments[:default]
end

Factory = builder.struct_namespace(PR::Pin::Struct)

Dir[SPEC_ROOT.join('support/factories/*.rb').to_s].each do |f|
  require f
end
