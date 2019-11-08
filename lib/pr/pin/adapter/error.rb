module PR
  module Pin
    module Adapter
      class Error < StandardError
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
