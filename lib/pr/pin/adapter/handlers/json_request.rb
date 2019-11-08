module PR
  module Pin
    module Adapter
      class Handlers
        class JSONRequest
          class << self
            def client(host, port)
              clients["#{host}:#{port}"] ||= Net::HTTP.new(
                host,
                port
              ).tap do |client|
                client.use_ssl = true
                client.verify_mode = OpenSSL::SSL::VERIFY_PEER
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

              client(uri.host, uri.port).request(request)
            end

            private

            def clients
              @clients ||= Concurrent::Hash.new
            end
          end
        end
      end
    end
  end
end
