module PR
  module Pin
    module Repositories
      class Subscriptions < ROM::Repository[:subscriptions]
        include Concerns::Common
      end
    end
  end
end
