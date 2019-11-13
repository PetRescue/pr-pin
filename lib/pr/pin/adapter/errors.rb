module PR
  module Pin
    module Adapter
      Error = Class.new(StandardError)
      NoPaginationError = Class.new(Error)

      class ResponseError < Error
        attr_reader :response, :result

        def initialize(response, result)
          @response = response
          @result = result

          super(result[:error_description])
        end
      end
    end
  end
end
