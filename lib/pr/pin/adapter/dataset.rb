module PR
  module Pin
    module Adapter
      class Dataset < ROM::HTTP::Dataset
        config.default_request_handler = Handlers::JSONRequest
        config.default_response_handler = Handlers::JSONResponse

        option :secret_key, type: ROM::Types::Strict::String
        option :error_handler
      end
    end
  end
end
