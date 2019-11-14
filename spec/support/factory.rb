require 'rom-factory'

builder = ROM::Factory.configure do |config|
  config.rom = PR::Pin.environments[:default]
end

Factory = builder.struct_namespace(PR::Pin::Struct)
