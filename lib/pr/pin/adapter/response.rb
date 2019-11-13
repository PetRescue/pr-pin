module PR
  module Pin
    module Adapter
      class Response < SimpleDelegator
        def paginates?
          false
        end

        def class
          __getobj__.class
        end
      end
    end
  end
end
