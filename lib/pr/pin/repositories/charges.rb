module PR
  module Pin
    module Repositories
      class Charges < ROM::Repository[:charges]
        include Concerns::Common
      end
    end
  end
end
