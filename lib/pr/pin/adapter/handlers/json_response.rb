module PR
  module Pin
    module Adapter
      class Handlers
        class JSONResponse
          SUCCESS_CODES = %w(200 201).freeze

          def self.call(response, dataset)
            result = JSON.parse(
              response.body,
              symbolize_names: true
            )

            if SUCCESS_CODES.include?(response.code)
              if %i(post put patch).include?(dataset.request_method)
                result[:response]
              else
                Array([result[:response]]).flatten(1)
              end
            else
              raise(Error.new(response, result))
            end
          end
        end
      end
    end
  end
end
