module PR
  module Pin
    module Repositories
      class Plans < ROM::Repository[:plans]
        include Concerns::Common
      end
    end
  end
end
