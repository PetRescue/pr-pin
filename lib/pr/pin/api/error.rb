module PR
  module Pin
    module API
      class Error < PR::Pin::Error
        attr_reader :response, :result

        def initialize(error)
          @response = error.response
          @result = error.result

          super(error.message)
        end

        def response_code
          response.code
        end

        def to_h
          result
        end

        def code
          result[:error]
        end

        def description
          result[:error_description]
        end

        def messages
          result.fetch(:messages, [])
        end

        def success?
          false
        end

        def error?
          true
        end

        def inspect
          "#<#{self.class} - Status: `#{response_code}', Code: `#{code}', Message: `#{description}'>"
        end
      end
    end
  end
end
