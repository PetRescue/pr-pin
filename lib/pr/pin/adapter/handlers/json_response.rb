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
            pagination_result = result.fetch(:pagination, false)

            if SUCCESS_CODES.include?(response.code)
              if %i(post put patch).include?(dataset.request_method)
                response = result[:response]
              else
                response = Array([result[:response]]).flatten(1)
              end

              if pagination_result
                PaginatedResponse.new(response, pagination_result)
              else
                Response.new(response)
              end
            else
              raise(ResponseError.new(response, result))
            end
          end
        end
      end
    end
  end
end
