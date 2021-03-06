module PR
  module Pin
    module Adapter
      class Dataset < ROM::HTTP::Dataset
        config.default_request_handler = Handlers::JSONRequest.new
        config.default_response_handler = Handlers::JSONResponse.new

        option :secret_key, type: ROM::Types::Strict::String
        option :error_handler

        def materialize
          response
        end
      end
    end
  end
end
