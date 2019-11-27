module PR
  module Pin
    module Adapter
      class Handlers
        class JSONRequest
          SSL_PORT = 443

          attr_reader :clients

          def initialize
            @clients = Hash.new do |hash, key|
              hash[key] = Net::HTTP.new(*key).tap do |client|
                if SSL_PORT == client.port
                  client.use_ssl = true
                  client.verify_mode = OpenSSL::SSL::VERIFY_PEER
                end
              end
            end
          end

          def call(dataset)
            uri = dataset.uri

            request_class = Net::HTTP.const_get(
              PR::Pin::Inflector.classify(dataset.request_method)
            )

            request = request_class.new(uri.request_uri)
            request.basic_auth(dataset.secret_key, '')

            dataset.headers.each_with_object(request) do |(header, value), request|
              request[header.to_s] = value
            end

            request.body = dataset.params.to_json if dataset.params.any?

            clients[[uri.host, uri.port]].request(request)
          end
        end
      end
    end
  end
end
