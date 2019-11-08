require 'json'
require 'net/http'
require 'rom-http'
require 'pr/pin/inflector'
require 'pr/pin/adapter/error'
require 'pr/pin/adapter/handlers/json_request'
require 'pr/pin/adapter/handlers/json_response'
require 'pr/pin/adapter/gateway'
require 'pr/pin/adapter/dataset'
require 'pr/pin/adapter/relation'
require 'pr/pin/adapter/commands'

ROM.register_adapter(:pr_pin, PR::Pin::Adapter)
