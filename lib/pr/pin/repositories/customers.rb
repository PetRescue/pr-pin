module PR
  module Pin
    module Repositories
      class Customers < ROM::Repository[:customers]
        include Concerns::Common
      end
    end
  end
end
