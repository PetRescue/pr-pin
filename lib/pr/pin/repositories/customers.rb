module PR
  module Pin
    module Repositories
      class Customers < ROM::Repository[:customers]
        include Concerns::Common

        def find(token)
          relation = root.with_path(token)

          API::Result.wrap(relation) { relation.one }
        end
      end
    end
  end
end
